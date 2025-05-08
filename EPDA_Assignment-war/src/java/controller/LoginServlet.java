/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import model.CustomerFacade;
import model.ManagingStaff;
import model.ManagingStaffFacade;
import model.Salesman;
import model.SalesmanFacade;
import util.PasswordHasher;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @EJB
    private CustomerFacade customerFacade;
    
    @EJB
    private SalesmanFacade salesmanFacade;
    
    @EJB
    private ManagingStaffFacade managingStaffFacade;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get login details from request
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
                request.setAttribute("errorMessage", "Username and password are required.");
                forwardToLogin(request, response);
                return;
            }

            // Authenticate the user
            Object user = authenticate(username, password);

            if (user != null) {
                // Create new session
                HttpSession session = request.getSession(true);
                
                // Store user object and role in session
                if (user instanceof ManagingStaff) {
                    ManagingStaff staff = (ManagingStaff) user;
                    session.setAttribute("user", staff);
                    session.setAttribute("userId", staff.getId());
                    session.setAttribute("role", "manager");
                    response.sendRedirect("ManagingStaffServlet");
                } else if (user instanceof Salesman) {
                    Salesman salesman = (Salesman) user;
                    session.setAttribute("user", salesman);
                    session.setAttribute("userId", salesman.getSalesmanId());
                    session.setAttribute("role", "salesman");
                    response.sendRedirect("SalesmanServlet");
                } else if (user instanceof Customer) {
                    Customer customer = (Customer) user;
                    session.setAttribute("user", customer);
                    session.setAttribute("userId", customer.getCustomerId());
                    session.setAttribute("role", "customer");
                    response.sendRedirect("CustomerServlet");
                }
            } else {
                // Authentication failed
                request.setAttribute("errorMessage", "Invalid username or password.");
                forwardToLogin(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during login process", e);
            request.setAttribute("errorMessage", "An error occurred during login. Please try again.");
            forwardToLogin(request, response);
        }
    }

    private void forwardToLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    private Object authenticate(String username, String password) {
        try {
            // Check if the user is a Managing Staff (Admin)
            ManagingStaff managingStaff = managingStaffFacade.findByUsername(username);
            if (managingStaff != null && PasswordHasher.verifyPassword(password, managingStaff.getPassword())) {
                return managingStaff;
            }

            // Check if the user is a Salesman
            Salesman salesman = salesmanFacade.findByUsername(username);
            if (salesman != null && PasswordHasher.verifyPassword(password, salesman.getPassword())) {
                return salesman;
            }

            // Check if the user is a Customer
            Customer customer = customerFacade.findByUsername(username);
            if (customer != null && PasswordHasher.verifyPassword(password, customer.getPassword())) {
                return customer;
            }

            return null;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during authentication", e);
            return null;
        }
    }
}