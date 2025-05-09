package controller;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ManagingStaff;
import model.ManagingStaffFacade;
import model.Salesman;
import model.SalesmanFacade;
import model.Customer;
import model.CustomerFacade;
import model.Car;
import model.CarFacade;
import model.Feedback;
import model.FeedbackFacade;
import model.Sale;
import model.SaleFacade;
import java.util.List;
import util.PasswordHasher;

@WebServlet(name = "ManagingStaffServlet", urlPatterns = {"/ManagingStaffServlet"})
public class ManagingStaffServlet extends HttpServlet {

    @EJB
    private ManagingStaffFacade managingStaffFacade;
    
    @EJB
    private SalesmanFacade salesmanFacade;
    
    @EJB
    private CustomerFacade customerFacade;
    
    @EJB
    private CarFacade carFacade;
    
    @EJB
    private FeedbackFacade feedbackFacade;
    
    @EJB
    private SaleFacade saleFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if user is logged in and has manager role
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"manager".equals(session.getAttribute("role"))) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // Get current manager from session
            ManagingStaff currentManager = (ManagingStaff) session.getAttribute("user");
            if (currentManager == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            String action = request.getParameter("action");
            
            // Set facade attributes for JSP access
            request.setAttribute("managingStaffFacade", managingStaffFacade);
            request.setAttribute("salesmanFacade", salesmanFacade);
            request.setAttribute("customerFacade", customerFacade);
            request.setAttribute("carFacade", carFacade);
            request.setAttribute("saleFacade", saleFacade);
            request.setAttribute("feedbackFacade", feedbackFacade);
            
            // Load all lists by default
            List<ManagingStaff> staffList = managingStaffFacade.findAll();
            List<Salesman> salesmanList = salesmanFacade.findAll();
            List<Customer> customerList = customerFacade.findAll();
            List<Car> carList = carFacade.findAll();
            List<Sale> saleList = saleFacade.findAll();
            List<Feedback> feedbackList = feedbackFacade.findAll();
            
            // Set the lists as request attributes
            request.setAttribute("staffList", staffList);
            request.setAttribute("salesmanList", salesmanList);
            request.setAttribute("customerList", customerList);
            request.setAttribute("carList", carList);
            request.setAttribute("saleList", saleList);
            request.setAttribute("feedbackList", feedbackList);
            
            if (action == null) {
                request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
                return;
            }

            switch (action) {
                case "addStaff":
                    addStaff(request, response);
                    break;
                case "updateStaff":
                    updateStaff(request, response);
                    break;
                case "deleteStaff":
                    deleteStaff(request, response);
                    break;
                case "searchStaff":
                    searchStaff(request, response);
                    break;
                case "approveSalesman":
                    approveSalesman(request, response);
                    break;
                case "updateSalesman":
                    updateSalesman(request, response);
                    break;
                case "deleteSalesman":
                    deleteSalesman(request, response);
                    break;
                case "searchSalesman":
                    searchSalesman(request, response);
                    break;
                case "updateCustomer":
                    updateCustomer(request, response);
                    break;
                case "deleteCustomer":
                    deleteCustomer(request, response);
                    break;
                case "searchCustomer":
                    searchCustomer(request, response);
                    break;
                case "addCar":
                    addCar(request, response);
                    break;
                case "updateCar":
                    updateCar(request, response);
                    break;
                case "deleteCar":
                    deleteCar(request, response);
                    break;
                case "searchCar":
                    searchCar(request, response);
                    break;
                case "viewPayments":
                    viewPayments(request, response);
                    break;
                case "viewFeedback":
                    viewFeedback(request, response);
                    break;
                default:
                    request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
        }
    }

    private void addStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            
            if (username == null || password == null || email == null || 
                username.isEmpty() || password.isEmpty() || email.isEmpty()) {
                request.setAttribute("error", "All fields are required");
                request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Check if username already exists
            if (managingStaffFacade.findByUsername(username) != null) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Hash the password before creating new staff
            String hashedPassword = PasswordHasher.hashPassword(password);
            ManagingStaff staff = new ManagingStaff(username, hashedPassword, email, "manager");
            managingStaffFacade.create(staff);
            
            // Reload all data after adding staff
            reloadAllData(request);
            request.setAttribute("message", "Staff added successfully");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while adding staff: " + e.getMessage());
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void updateStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        ManagingStaff staff = managingStaffFacade.find(id);
        if (staff != null) {
            staff.setUsername(username);
            if (password != null && !password.isEmpty()) {
                // Hash the password before updating
                String hashedPassword = PasswordHasher.hashPassword(password);
                staff.setPassword(hashedPassword);
            }
            staff.setEmail(email);
            managingStaffFacade.edit(staff);
            
            // Reload all data after updating staff
            reloadAllData(request);
            request.setAttribute("message", "Staff updated successfully");
        } else {
            request.setAttribute("error", "Staff not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        ManagingStaff staff = managingStaffFacade.find(id);
        if (staff != null) {
            managingStaffFacade.remove(staff);
            
            // Reload all data after deleting staff
            reloadAllData(request);
            request.setAttribute("message", "Staff deleted successfully");
        } else {
            request.setAttribute("error", "Staff not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void searchStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<ManagingStaff> staffList = managingStaffFacade.searchByName(searchTerm);
            request.setAttribute("staffList", staffList);
        } else {
            request.setAttribute("staffList", managingStaffFacade.findAll());
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void reloadAllData(HttpServletRequest request) {
        // Reload all lists
        request.setAttribute("staffList", managingStaffFacade.findAll());
        request.setAttribute("salesmanList", salesmanFacade.findAll());
        request.setAttribute("customerList", customerFacade.findAll());
        request.setAttribute("carList", carFacade.findAll());
        request.setAttribute("saleList", saleFacade.findAll());
        request.setAttribute("feedbackList", feedbackFacade.findAll());
    }

    private void approveSalesman(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Salesman salesman = salesmanFacade.find(id);
        if (salesman != null) {
            salesman.setRole("approved");
            salesmanFacade.edit(salesman);
            
            // Reload all data after approving salesman
            reloadAllData(request);
            request.setAttribute("message", "Salesman approved successfully");
        } else {
            request.setAttribute("error", "Salesman not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void updateSalesman(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        Salesman salesman = salesmanFacade.find(id);
        if (salesman != null) {
            salesman.setUsername(username);
            if (password != null && !password.isEmpty()) {
                // Hash the password before updating
                String hashedPassword = PasswordHasher.hashPassword(password);
                salesman.setPassword(hashedPassword);
            }
            salesman.setEmail(email);
            salesmanFacade.edit(salesman);
            
            // Reload all data after updating salesman
            reloadAllData(request);
            request.setAttribute("message", "Salesman updated successfully");
        } else {
            request.setAttribute("error", "Salesman not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void deleteSalesman(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Salesman salesman = salesmanFacade.find(id);
        if (salesman != null) {
            salesmanFacade.remove(salesman);
            
            // Reload all data after deleting salesman
            reloadAllData(request);
            request.setAttribute("message", "Salesman deleted successfully");
        } else {
            request.setAttribute("error", "Salesman not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void searchSalesman(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Salesman> salesmanList = salesmanFacade.searchByName(searchTerm);
            request.setAttribute("salesmanList", salesmanList);
        } else {
            request.setAttribute("salesmanList", salesmanFacade.findAll());
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        Customer customer = customerFacade.find(id);
        if (customer != null) {
            customer.setUsername(username);
            if (password != null && !password.isEmpty()) {
                // Hash the password before updating
                String hashedPassword = PasswordHasher.hashPassword(password);
                customer.setPassword(hashedPassword);
            }
            customer.setEmail(email);
            customerFacade.edit(customer);
            
            // Reload all data after updating customer
            reloadAllData(request);
            request.setAttribute("message", "Customer updated successfully");
        } else {
            request.setAttribute("error", "Customer not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Customer customer = customerFacade.find(id);
        if (customer != null) {
            customerFacade.remove(customer);
            
            // Reload all data after deleting customer
            reloadAllData(request);
            request.setAttribute("message", "Customer deleted successfully");
        } else {
            request.setAttribute("error", "Customer not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void searchCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Customer> customerList = customerFacade.searchByName(searchTerm);
            request.setAttribute("customerList", customerList);
        } else {
            request.setAttribute("customerList", customerFacade.findAll());
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void addCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String make = request.getParameter("make");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        double price = Double.parseDouble(request.getParameter("price"));
        
        Car car = new Car();
        car.setMake(make);
        car.setModel(model);
        car.setColor(color);
        car.setPrice(price);
        car.setStatus("available");
        
        carFacade.create(car);
        
        // Reload all data after adding car
        reloadAllData(request);
        request.setAttribute("message", "Car added successfully");
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void updateCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String make = request.getParameter("make");
        String model = request.getParameter("model");
        double price = Double.parseDouble(request.getParameter("price"));
        String status = request.getParameter("status");
        
        Car car = carFacade.find(id);
        if (car != null) {
            car.setMake(make);
            car.setModel(model);
            car.setPrice(price);
            car.setStatus(status);
            carFacade.edit(car);
            
            // Reload all data after updating car
            reloadAllData(request);
            request.setAttribute("message", "Car updated successfully");
        } else {
            request.setAttribute("error", "Car not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void deleteCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Car car = carFacade.find(id);
        if (car != null) {
            carFacade.remove(car);
            
            // Reload all data after deleting car
            reloadAllData(request);
            request.setAttribute("message", "Car deleted successfully");
        } else {
            request.setAttribute("error", "Car not found");
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void searchCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Car> carList = carFacade.searchByModel(searchTerm);
            request.setAttribute("carList", carList);
        } else {
            request.setAttribute("carList", carFacade.findAll());
        }
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void viewPayments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Sale> saleList = saleFacade.findAll();
        request.setAttribute("saleList", saleList);
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
    }

    private void viewFeedback(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Feedback> feedbackList = feedbackFacade.findAll();
        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("manager/dashboard.jsp").forward(request, response);
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