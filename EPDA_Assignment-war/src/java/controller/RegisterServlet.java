/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import model.Customer;
import model.Salesman;
import model.ManagingStaff;
import model.CustomerFacade;
import model.SalesmanFacade;
import model.ManagingStaffFacade;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;

    @EJB
    private SalesmanFacade salesmanFacade;

    @EJB
    private ManagingStaffFacade managingStaffFacade;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        if (username == null || password == null || email == null || role == null || role.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(30 * 60); // 30 minutes
        session.setAttribute("lastActivity", System.currentTimeMillis());

        switch (role.toLowerCase()) {
            case "customer":
                Customer customer = new Customer();
                customer.setUsername(username);
                customer.setPassword(password);
                customer.setEmail(email);
                customer.setRole("customer");

                customerFacade.create(customer);

                session.setAttribute("user", customer);
                session.setAttribute("role", "customer");
                response.sendRedirect("customer.jsp");
                break;

            case "salesman":
                Salesman salesman = new Salesman(username, email, password, role);
                salesmanFacade.create(salesman);

                session.setAttribute("user", salesman);
                session.setAttribute("role", "salesman");
                response.sendRedirect("salesman.jsp");
                break;

            case "manager":
                ManagingStaff manager = new ManagingStaff();
                manager.setUsername(username);
                manager.setPassword(password);
                manager.setEmail(email);
                manager.setRole("manager");
                managingStaffFacade.create(manager);

                session.setAttribute("user", manager);
                session.setAttribute("role", "manager");
                response.sendRedirect("manager.jsp");
                break;

            default:
                request.setAttribute("errorMessage", "Invalid role selected.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
        }
    }
}
