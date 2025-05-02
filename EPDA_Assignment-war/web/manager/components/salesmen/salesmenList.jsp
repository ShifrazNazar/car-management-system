<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Salesman"%>
<%@page import="java.util.List"%>
<%@page import="model.SalesmanFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Salesmen List -->
<div class="table-container">
    <h2><i class="fas fa-user-tie"></i> Salesmen List</h2>
    <form action="ManagingStaffServlet" method="GET" style="margin-bottom: 20px;">
        <input type="hidden" name="action" value="searchSalesman">
        <div class="form-group" style="display: flex; gap: 10px;">
            <input type="text" name="searchTerm" placeholder="Search salesmen by name..." style="flex: 1;">
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
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${salesmanList}" var="salesman">
                <tr>
                    <td>${salesman.salesmanId}</td>
                    <td>${salesman.username}</td>
                    <td>${salesman.email}</td>
                    <td>
                        <span class="status-badge ${salesman.role eq 'approved' ? 'status-available' : 'status-booked'}">
                            ${salesman.role}
                        </span>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <form action="ManagingStaffServlet" method="POST" style="display: inline;">
                                <input type="hidden" name="action" value="approveSalesman">
                                <input type="hidden" name="id" value="${salesman.salesmanId}">
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-check"></i> Approve
                                </button>
                            </form>
                            <button type="button" class="btn btn-primary btn-sm" onclick="showUpdateForm('salesman-${salesman.salesmanId}')">
                                <i class="fas fa-edit"></i> Update
                            </button>
                            <form action="ManagingStaffServlet" method="POST" style="display: inline;">
                                <input type="hidden" name="action" value="deleteSalesman">
                                <input type="hidden" name="id" value="${salesman.salesmanId}">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                        <div id="salesman-${salesman.salesmanId}" class="update-form" style="display: none;">
                            <form action="ManagingStaffServlet" method="POST">
                                <input type="hidden" name="action" value="updateSalesman">
                                <input type="hidden" name="id" value="${salesman.salesmanId}">
                                <div class="form-group">
                                    <input type="text" name="username" value="${salesman.username}" required>
                                </div>
                                <div class="form-group">
                                    <input type="password" name="password" placeholder="New password">
                                </div>
                                <div class="form-group">
                                    <input type="email" name="email" value="${salesman.email}" required>
                                </div>
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-save"></i> Save
                                </button>
                                <button type="button" class="btn btn-secondary btn-sm" onclick="hideUpdateForm('salesman-${salesman.salesmanId}')">
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