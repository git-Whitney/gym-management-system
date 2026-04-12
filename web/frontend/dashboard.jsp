<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String name = (String) session.getAttribute("name");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>
<body>
<div class="container">
  <div class="glass-card">
    <h2>Hey, <%= name != null ? name : "User" %> 👋</h2>

    <!-- BOOK SESSION -->
    <a  href="${pageContext.request.contextPath}/LoadSessions" class="card">
        🏋️ Book Session
    </a>

    <!-- MAKE PAYMENT -->
    <a href="payment.jsp" class="card">
        💳 Make Payment
    </a>

    <!-- VIEW PROFILE -->
    <a href="profile.jsp" class="card">
        👤 View Profile
    </a>

  </div>
</div>
<script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
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