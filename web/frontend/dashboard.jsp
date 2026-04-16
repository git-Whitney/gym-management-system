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
    <div style="width:100%; margin-top:20px; text-align:left;">

    <h3 style="color:white;">💳 Recent Payments</h3>

    <%
        java.util.List<com.gym.system.Payment> recentPayments =
            (java.util.List<com.gym.system.Payment>) request.getAttribute("recentPayments");

        if (recentPayments != null && !recentPayments.isEmpty()) {
            for (com.gym.system.Payment p : recentPayments) {
    %>

    <div class="booking-card">
        <div class="booking-row">
            💰 Amount: <b><%= p.getAmount() %></b>
        </div>

        <div class="booking-row">
            📅 Date: <%= p.getPaymentDate() %>
        </div>

        <div class="booking-row status">
            Status: <%= p.getStatus() %>
        </div>
    </div>

    <%
            }
        } else {
    %>

        <p style="color:white;">No payments yet.</p>

    <%
        }
    %>

    <a href="${pageContext.request.contextPath}/PaymentHistoryServlet"
       class="card" style="margin-top:15px;">
        View Full Payment History →
    </a>

</div>

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