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

@WebServlet(name = "CustomerServlet", urlPatterns = {"/CustomerServlet"})
public class CustomerServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CustomerServlet.class.getName());

    @EJB
    private CustomerFacade customerFacade;
    
    @EJB
    private SaleFacade saleFacade;
    
    @EJB
    private FeedbackFacade feedbackFacade;

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
                customer.setPassword(password);
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

    private void submitFeedback(HttpServletRequest request, HttpServletResponse response, Customer customer) 
            throws ServletException, IOException {
        try {
            Long saleId = Long.parseLong(request.getParameter("saleId"));
            double rating = Double.parseDouble(request.getParameter("rating"));
            String title = request.getParameter("reviewTitle");
            String content = request.getParameter("reviewContent");
            
            Sale sale = saleFacade.find(saleId);
            if (sale != null && sale.getCustomer().equals(customer)) {
                Feedback feedback = new Feedback();
                feedback.setCustomer(customer);
                feedback.setCar(sale.getCar());
                feedback.setRating(rating);
                feedback.setComment(content);
                
                feedbackFacade.create(feedback);
                
                // Update sale reviewed status
                sale.setReviewed(true);
                saleFacade.edit(sale);
                
                request.setAttribute("message", "Review submitted successfully");
            } else {
                request.setAttribute("error", "Invalid sale or unauthorized access");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error submitting feedback", e);
            request.setAttribute("error", "An error occurred while submitting feedback: " + e.getMessage());
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
                
                request.setAttribute("message", "Review deleted successfully");
            } else {
                request.setAttribute("error", "Review not found");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error deleting feedback", e);
            request.setAttribute("error", "An error occurred while deleting review: " + e.getMessage());
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }

    private void getSaleDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Long saleId = Long.parseLong(request.getParameter("saleId"));
            Sale sale = saleFacade.find(saleId);
            
            if (sale != null) {
                response.setContentType("application/json");
                response.getWriter().write(String.format(
                    "{\"carModel\":\"%s\",\"saleDate\":\"%s\"}",
                    sale.getCar().getModel(),
                    sale.getSaleDate()
                ));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sale not found");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting sale details", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void viewPurchases(HttpServletRequest request, HttpServletResponse response, Long customerId) 
            throws ServletException, IOException {
        try {
            List<Sale> saleList = saleFacade.findByCustomerId(customerId);
            request.setAttribute("saleList", saleList);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error viewing purchases", e);
            request.setAttribute("error", "An error occurred while viewing purchases: " + e.getMessage());
        }
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
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
