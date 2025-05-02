package controller;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Salesman;
import model.SalesmanFacade;
import model.Car;
import model.CarFacade;
import model.Customer;
import model.CustomerFacade;
import model.Sale;
import model.SaleFacade;
import java.util.List;

@WebServlet(name = "SalesmanServlet", urlPatterns = {"/SalesmanServlet"})
public class SalesmanServlet extends HttpServlet {

    @EJB
    private SalesmanFacade salesmanFacade;
    
    @EJB
    private CarFacade carFacade;
    
    @EJB
    private CustomerFacade customerFacade;
    
    @EJB
    private SaleFacade saleFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and has salesman role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"salesman".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get current salesman from session
        Salesman currentSalesman = (Salesman) session.getAttribute("user");
        if (currentSalesman == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        // Set facade attributes for JSP access
        request.setAttribute("carFacade", carFacade);
        request.setAttribute("saleFacade", saleFacade);
        
        // Load all cars and sales for current salesman by default
        List<Car> carList = carFacade.findAll();
        List<Sale> saleList = saleFacade.findBySalesmanId(currentSalesman.getSalesmanId());
        
        // Set the lists as request attributes
        request.setAttribute("carList", carList);
        request.setAttribute("saleList", saleList);
        
        if (action == null) {
            request.getRequestDispatcher("salesman/dashboard.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "updateProfile":
                updateProfile(request, response, currentSalesman);
                break;
            case "updateCarStatus":
                updateCarStatus(request, response);
                break;
            case "processPayment":
                processPayment(request, response);
                break;
            case "searchCars":
                searchCars(request, response);
                break;
            case "viewSales":
                viewSales(request, response, currentSalesman.getSalesmanId());
                break;
            default:
                request.getRequestDispatcher("salesman/dashboard.jsp").forward(request, response);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, Salesman salesman) 
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            
            if (username != null && !username.isEmpty()) {
                salesman.setUsername(username);
            }
            if (password != null && !password.isEmpty()) {
                salesman.setPassword(password);
            }
            if (email != null && !email.isEmpty()) {
                salesman.setEmail(email);
            }
            
            salesmanFacade.edit(salesman);
            
            // Update session with new user data
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.setAttribute("user", salesman);
            }
            
            request.setAttribute("message", "Profile updated successfully");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while updating profile: " + e.getMessage());
        }
        request.getRequestDispatcher("salesman/dashboard.jsp").forward(request, response);
    }

    private void updateCarStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Long carId = Long.parseLong(request.getParameter("carId"));
            String status = request.getParameter("status");
            
            Car car = carFacade.find(carId);
            if (car != null) {
                car.setStatus(status);
                carFacade.edit(car);
                request.setAttribute("message", "Car status updated successfully");
            } else {
                request.setAttribute("error", "Car not found");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while updating car status: " + e.getMessage());
        }
        request.getRequestDispatcher("salesman/dashboard.jsp").forward(request, response);
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Long saleId = Long.parseLong(request.getParameter("saleId"));
            double amountPaid = Double.parseDouble(request.getParameter("amountPaid"));
            String comment = request.getParameter("comment");
            
            Sale sale = saleFacade.find(saleId);
            if (sale != null) {
                sale.setAmountPaid(amountPaid);
                sale.setComment(comment);
                sale.setStatus("paid");
                saleFacade.edit(sale);
                
                // Update car status to paid
                Car car = sale.getCar();
                car.setStatus("paid");
                carFacade.edit(car);
                
                request.setAttribute("message", "Payment processed successfully");
            } else {
                request.setAttribute("error", "Sale not found");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while processing payment: " + e.getMessage());
        }
        request.getRequestDispatcher("salesman/dashboard.jsp").forward(request, response);
    }

    private void searchCars(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Car> carList = carFacade.searchByModel(searchTerm);
            request.setAttribute("carList", carList);
        } else {
            request.setAttribute("carList", carFacade.findAll());
        }
        request.getRequestDispatcher("salesman/dashboard.jsp").forward(request, response);
    }

    private void viewSales(HttpServletRequest request, HttpServletResponse response, Long salesmanId) 
            throws ServletException, IOException {
        List<Sale> saleList = saleFacade.findBySalesmanId(salesmanId);
        request.setAttribute("saleList", saleList);
        request.getRequestDispatcher("salesman/dashboard.jsp").forward(request, response);
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