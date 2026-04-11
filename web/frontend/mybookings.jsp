<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
List<Map<String, String>> bookings =
    (List<Map<String, String>>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>

<body>
<div style="margin-top:10px; padding:6px; background:#00c6ff33; border-radius:8px;">
    🎟️ Show this at the gym entrance
</div>
<div class="container">
<div class="glass-card">

    <h2>📋 My Bookings</h2>

    <%
    if (bookings == null || bookings.isEmpty()) {
    %>
        <div class="alert error">
            You have no bookings yet.
        </div>
    <%
    } else {
        for (Map<String, String> b : bookings) {
    %>

    <div class="booking-card">

        <div class="booking-row">
            🕒 <strong><%= b.get("time") %></strong>
        </div>

        <div class="booking-row">
            📅 Date: <%= b.get("date") != null ? b.get("date") : "Today" %>
        </div>

        <div class="booking-row">
            💳 Payment: <%= b.get("payment_status") != null ? b.get("payment_status") : "Pending" %>
        </div>

        <div class="booking-row">
            Status: <span class="status">CONFIRMED</span>
        </div>

    </div>

    <%
        }
    }
    %>

</div>
</div>
<div class="bottom-nav">

    <a href="${pageContext.request.contextPath}/frontend/dashboard.jsp" class="nav-item">
        <span>🏠</span>
        <small>Home</small>
    </a>
        <a href="${pageContext.request.contextPath}/LoadSessions" class="nav-item">
        <span>📅</span>
        <small>Booking</small>
    </a>

    <a href="${pageContext.request.contextPath}/frontend/mybookings.jsp" class="nav-item">
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
