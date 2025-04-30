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


@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;
    
    @EJB
    private SalesmanFacade salesmanFacade;
    
    @EJB
    private ManagingStaffFacade managingStaffFacade;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login details from request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Authenticate the user
        Object user = authenticate(username, password);

        if (user != null) {
            // Store the user role in session
            HttpSession session = request.getSession();
            if (user instanceof ManagingStaff) {
                session.setAttribute("role", "admin");
                response.sendRedirect("admin.jsp"); // Redirect to admin dashboard
            } else if (user instanceof Salesman) {
                session.setAttribute("role", "salesman");
                response.sendRedirect("salesman.jsp"); // Redirect to salesman dashboard
            } else if (user instanceof Customer) {
                session.setAttribute("role", "customer");
                response.sendRedirect("customer.jsp"); // Redirect to customer dashboard
            }
        } else {
            // Authentication failed, redirect back to login
            request.setAttribute("errorMessage", "Invalid username or password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }

    private Object authenticate(String username, String password) {
        // Check if the user is a Managing Staff (Admin)
        ManagingStaff managingStaff = managingStaffFacade.login(username, password);
        if (managingStaff != null) {
            return managingStaff;
        }

        // Check if the user is a Salesman
        Salesman salesman = salesmanFacade.login(username, password);
        if (salesman != null) {
            return salesman;
        }

        // Check if the user is a Customer
        Customer customer = customerFacade.login(username, password);
        if (customer != null) {
            return customer;
        }

        // Return null if no user found
        return null;
    }
}