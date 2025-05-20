package controller;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import model.CustomerFacade;
import model.Sale;
import model.SaleFacade;
import model.Feedback;
import model.FeedbackFacade;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.PasswordHasher;
import model.Car;
import model.CarFacade;
import model.Salesman;
import model.SalesmanFacade;
import java.util.Date;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/CustomerServlet"})
public class CustomerServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CustomerServlet.class.getName());

    @EJB
    private CustomerFacade customerFacade;
    
    @EJB
    private SaleFacade saleFacade;
    
    @EJB
    private FeedbackFacade feedbackFacade;
    
    @EJB
    private CarFacade carFacade;
    
    @EJB
    private SalesmanFacade salesmanFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if user is logged in and has customer role
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("role"))) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // Get current customer from session
            Customer currentCustomer = (Customer) session.getAttribute("user");
            if (currentCustomer == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            String action = request.getParameter("action");
            
            // Set facade attributes for JSP access
            request.setAttribute("saleFacade", saleFacade);
            request.setAttribute("feedbackFacade", feedbackFacade);
            
            // Load all sales and feedback for current customer by default
            List<Sale> saleList = saleFacade.findByCustomerId(currentCustomer.getCustomerId());
            List<Feedback> feedbackList = feedbackFacade.findByCustomerId(currentCustomer.getCustomerId());
            
            // Calculate average rating
            double averageRating = feedbackList.stream()
                .mapToDouble(Feedback::getRating)
                .average()
                .orElse(0.0);
            
            // Set the lists and average rating as request attributes
            request.setAttribute("saleList", saleList);
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("averageRating", averageRating);
            
            // Load available cars for purchase form
            List<Car> availableCars = carFacade.findByStatus("available");
            request.setAttribute("availableCars", availableCars);
            
            // Load all salesmen for purchase form
            List<Salesman> salesmen = salesmanFacade.findAll();
            request.setAttribute("salesmen", salesmen);
            
            if (action == null) {
                // Default action: show dashboard
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }

            switch (action) {
                case "updateProfile":
                    updateProfile(request, response, currentCustomer);
                    break;
                case "searchSales":
                    searchSales(request, response, currentCustomer);
                    break;
                case "submitPurchase":
                    submitPurchase(request, response, currentCustomer);
                    break;
                case "submitFeedback":
                    submitFeedback(request, response, currentCustomer);
                    break;
                case "deleteFeedback":
                    deleteFeedback(request, response);
                    break;
                case "getSaleDetails":
                    getSaleDetails(request, response);
                    break;
                case "viewPurchases":
                    viewPurchases(request, response, currentCustomer.getCustomerId());
                    break;
                default:
                    // For any unknown action, show dashboard
                    request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in CustomerServlet", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, Customer customer) 
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            
            if (username != null && !username.isEmpty()) {
                customer.setUsername(username);
            }
            if (password != null && !password.isEmpty()) {
                // Hash the password before updating
                String hashedPassword = PasswordHasher.hashPassword(password);
                customer.setPassword(hashedPassword);
            }
            if (email != null && !email.isEmpty()) {
                customer.setEmail(email);
            }
            
            customerFacade.edit(customer);
            
            // Update session with new user data
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.setAttribute("user", customer);
            }
            
            // Reload all data after updating profile
            reloadAllData(request, customer.getCustomerId());
            request.setAttribute("message", "Profile updated successfully");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating profile", e);
            request.setAttribute("error", "An error occurred while updating profile: " + e.getMessage());
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }

    private void searchSales(HttpServletRequest request, HttpServletResponse response, Customer customer) 
            throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("searchTerm");
            List<Sale> saleList;
            
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                saleList = saleFacade.searchByModel(searchTerm, customer.getCustomerId());
            } else {
                saleList = saleFacade.findByCustomerId(customer.getCustomerId());
            }
            
            request.setAttribute("saleList", saleList);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error searching sales", e);
            request.setAttribute("error", "An error occurred while searching sales: " + e.getMessage());
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }

    private void submitPurchase(HttpServletRequest request, HttpServletResponse response, Customer customer) 
            throws ServletException, IOException {
        try {
            String carIdStr = request.getParameter("carId");
            String salesmanIdStr = request.getParameter("salesmanId");
            
            if (carIdStr == null || carIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Invalid car selection");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            if (salesmanIdStr == null || salesmanIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please select a salesman");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            Long carId = Long.parseLong(carIdStr);
            Long salesmanId = Long.parseLong(salesmanIdStr);
            
            Car car = carFacade.find(carId);
            Salesman salesman = salesmanFacade.find(salesmanId);
            
            if (car == null || !"available".equals(car.getStatus())) {
                request.setAttribute("errorMessage", "Selected car is not available");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            if (salesman == null) {
                request.setAttribute("errorMessage", "Selected salesman is not available");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Create new sale with all required fields
            Sale sale = new Sale();
            sale.setCar(car);
            sale.setCustomer(customer);
            sale.setSalesman(salesman); // Use the selected salesman
            sale.setStatus("booked");
            sale.setReviewed(false);
            sale.setSaleDate(new Date());
            sale.setAmountPaid(0.0); // Initial amount paid is 0
            sale.setComment("Purchase request submitted");
            
            // Update car status
            car.setStatus("booked");
            carFacade.edit(car);
            
            // Save the sale
            saleFacade.create(sale);
            
            // Reload all data
            reloadAllData(request, customer.getCustomerId());
            request.setAttribute("message", "Car purchase request submitted successfully!");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error submitting purchase", e);
            request.setAttribute("errorMessage", "An error occurred while submitting purchase: " + e.getMessage());
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }

    private void submitFeedback(HttpServletRequest request, HttpServletResponse response, Customer customer) 
            throws ServletException, IOException {
        try {
            // Get and validate saleId
            String saleIdStr = request.getParameter("saleId");
            if (saleIdStr == null || saleIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Invalid sale ID");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            Long saleId = Long.parseLong(saleIdStr);
            
            // Get and validate rating
            String ratingStr = request.getParameter("rating");
            if (ratingStr == null || ratingStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please select a rating");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            double rating = Double.parseDouble(ratingStr);
            if (rating < 1 || rating > 5) {
                request.setAttribute("errorMessage", "Please select a valid rating (1-5 stars)");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Get and validate content
            String content = request.getParameter("reviewContent");
            if (content == null || content.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please provide a review");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Get the sale
            Sale sale = saleFacade.find(saleId);
            if (sale == null || !sale.getCustomer().equals(customer)) {
                request.setAttribute("errorMessage", "Invalid sale or unauthorized access");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Check if sale is paid and not reviewed
            if (!"paid".equals(sale.getStatus())) {
                request.setAttribute("errorMessage", "Cannot submit feedback for unpaid purchases");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            if (sale.isReviewed()) {
                request.setAttribute("errorMessage", "You have already submitted feedback for this purchase");
                request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Create and save feedback
            Feedback feedback = new Feedback();
            feedback.setCustomer(customer);
            feedback.setCar(sale.getCar());
            feedback.setRating(rating);
            feedback.setComment(content);
            feedback.setSubmittedAt(new Date());
            
            feedbackFacade.create(feedback);
            
            // Update sale reviewed status
            sale.setReviewed(true);
            saleFacade.edit(sale);
            
            // Reload all data after submitting feedback
            reloadAllData(request, customer.getCustomerId());
            request.setAttribute("message", "Thank you for your review!");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input format. Please try again.");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error submitting feedback", e);
            request.setAttribute("errorMessage", "An error occurred while submitting your review");
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }

    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Long feedbackId = Long.parseLong(request.getParameter("feedbackId"));
            Feedback feedback = feedbackFacade.find(feedbackId);
            
            if (feedback != null) {
                // Update sale reviewed status
                Sale sale = saleFacade.findByCarId(feedback.getCar().getCarId()).stream()
                    .filter(s -> s.getCustomer().equals(feedback.getCustomer()))
                    .findFirst()
                    .orElse(null);
                
                if (sale != null) {
                    sale.setReviewed(false);
                    saleFacade.edit(sale);
                }
                
                // Delete the feedback
                feedbackFacade.remove(feedback);
                
                // Reload all data after deleting feedback
                Customer customer = (Customer) request.getSession().getAttribute("user");
                reloadAllData(request, customer.getCustomerId());
                request.setAttribute("successMessage", "Review deleted successfully");
            } else {
                request.setAttribute("errorMessage", "Review not found");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error deleting feedback", e);
            request.setAttribute("errorMessage", "An error occurred while deleting review: " + e.getMessage());
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }

    private void getSaleDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String saleIdStr = request.getParameter("saleId");
            if (saleIdStr == null || saleIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Sale ID is required");
                return;
            }

            Long saleId = Long.parseLong(saleIdStr);
            Sale sale = saleFacade.find(saleId);
            
            if (sale == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sale not found");
                return;
            }

            // Create JSON response
            String jsonResponse = String.format(
                "{\"carModel\":\"%s\",\"saleDate\":\"%s\",\"saleId\":%d}",
                sale.getCar().getModel(),
                sale.getSaleDate(),
                sale.getSaleId()
            );

            // Set response headers
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // Write JSON response
            response.getWriter().write(jsonResponse);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid sale ID format");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting sale details", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving sale details");
        }
    }

    private void viewPurchases(HttpServletRequest request, HttpServletResponse response, Long customerId) 
            throws ServletException, IOException {
        try {
            List<Sale> saleList = saleFacade.findByCustomerId(customerId);
            request.setAttribute("saleList", saleList);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error viewing purchases", e);
            request.setAttribute("errorMessage", "An error occurred while viewing purchases: " + e.getMessage());
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }

    private void reloadAllData(HttpServletRequest request, Long customerId) {
        // Reload all sales and feedback for current customer
        List<Sale> saleList = saleFacade.findByCustomerId(customerId);
        List<Feedback> feedbackList = feedbackFacade.findByCustomerId(customerId);
        
        // Calculate average rating
        double averageRating = feedbackList.stream()
            .mapToDouble(Feedback::getRating)
            .average()
            .orElse(0.0);
        
        // Set the lists and average rating as request attributes
        request.setAttribute("saleList", saleList);
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("averageRating", averageRating);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
