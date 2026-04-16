<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>
<body>
    <div class="container">
        
<div class="glass-card">
    <h2>💳 Payment </h2>
    <!<!-- m-pesa payment form -->
    <form action="${pageContext.request.contextPath}/stkpush" method="post">

        <input type="text" name="phone"
               placeholder="Enter M-Pesa Number (2547XXXXXXXX)"
               required>

        <input type="hidden" name="amount" value="300">

        <button type="submit">Pay 300 KES via M-Pesa</button>

    </form>

    <hr style="width:100%; margin:15px 0; opacity:0.3;">
    <!<!-- payment details -->

    <c:if test="${payment != null}">

        <p>💰 Amount: KES ${payment.amount}</p>
        <p>📅 Semester: ${payment.semester}</p>
        <p>📡 Status: ${payment.status}</p>
        <p>🔖 Transaction: ${payment.transactionCode}</p>

    </c:if>

    <c:if test="${payment == null}">
        <p>No payment found</p>
    </c:if>

</div>

    </div>
    <!<!-- bottom navigation -->
    <div class="bottom-nav">

    <a href="${pageContext.request.contextPath}/frontend/dashboard.jsp" class="nav-item">
        <span>🏠</span>
        <small>Home</small>
    </a>

    <a href="${pageContext.request.contextPath}/LoadSessions" class="nav-item">
        <span>📅</span>
        <small>Booking</small>
    </a>
        <a href="${pageContext.request.contextPath}/myBookings" class="nav-item">
        <span>📋</span>
        <small>My Bookings</small>
    </a>

    <a href="${pageContext.request.contextPath}/frontend/payment.jsp" class="nav-item">
        <span>💳</span>
        <small>Payment</small>
    </a>

    <a href="${pageContext.request.contextPath}/frontend/profile.jsp" class="nav-item">
        <span>👤</span>
        <small>Profile</small>
    </a>

</div>
</body>
</html>