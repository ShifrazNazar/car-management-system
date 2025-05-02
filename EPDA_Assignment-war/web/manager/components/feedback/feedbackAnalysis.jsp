<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Feedback"%>
<%@page import="java.util.List"%>
<%@page import="model.FeedbackFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Feedback Analysis -->
<div class="table-container">
    <h2><i class="fas fa-comment-alt"></i> Feedback Analysis</h2>
    <table>
        <thead>
            <tr>
                <th>Feedback ID</th>
                <th>Car</th>
                <th>Customer</th>
                <th>Rating</th>
                <th>Comment</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${feedbackList}" var="feedback">
                <tr>
                    <td>${feedback.feedbackId}</td>
                    <td>${feedback.car.make} ${feedback.car.model}</td>
                    <td>${feedback.customer.username}</td>
                    <td>
                        <div class="rating">
                            <c:forEach begin="1" end="${feedback.rating}">
                                <i class="fas fa-star"></i>
                            </c:forEach>
                        </div>
                    </td>
                    <td>${feedback.comment}</td>
                    <td>${feedback.submittedAt}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
