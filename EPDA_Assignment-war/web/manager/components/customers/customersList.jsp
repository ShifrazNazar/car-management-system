<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<%@page import="java.util.List"%>
<%@page import="model.CustomerFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Customer List -->
<div class="table-container">
    <h2><i class="fas fa-users"></i> Customer List</h2>
    <form action="ManagingStaffServlet" method="GET" style="margin-bottom: 20px;">
        <input type="hidden" name="action" value="searchCustomer">
        <div class="form-group" style="display: flex; gap: 10px;">
            <input type="text" name="searchTerm" placeholder="Search customers by name..." style="flex: 1;">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> Search
            </button>
        </div>
    </form>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${customerList}" var="customer">
                <tr>
                    <td>${customer.customerId}</td>
                    <td>${customer.username}</td>
                    <td>${customer.email}</td>
                    <td>
                        <div class="action-buttons">
                            <button type="button" class="btn btn-primary btn-sm" onclick="showUpdateForm('customer-${customer.customerId}')">
                                <i class="fas fa-edit"></i> Update
                            </button>
                            <form action="ManagingStaffServlet" method="POST" style="display: inline;">
                                <input type="hidden" name="action" value="deleteCustomer">
                                <input type="hidden" name="id" value="${customer.customerId}">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                        <div id="customer-${customer.customerId}" class="update-form" style="display: none;">
                            <form action="ManagingStaffServlet" method="POST">
                                <input type="hidden" name="action" value="updateCustomer">
                                <input type="hidden" name="id" value="${customer.customerId}">
                                <div class="form-group">
                                    <input type="text" name="username" value="${customer.username}" required>
                                </div>
                                <div class="form-group">
                                    <input type="password" name="password" placeholder="New password">
                                </div>
                                <div class="form-group">
                                    <input type="email" name="email" value="${customer.email}" required>
                                </div>
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-save"></i> Save
                                </button>
                                <button type="button" class="btn btn-secondary btn-sm" onclick="hideUpdateForm('customer-${customer.customerId}')">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>