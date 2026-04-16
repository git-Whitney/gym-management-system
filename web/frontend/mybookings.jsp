<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
List<Map<String, String>> bookings =
    (List<Map<String, String>>) request.getAttribute("bookings");
%>
<%
String success = request.getParameter("success");
%>

<% if ("booked".equals(success)) { %>
    <div class="alert success">
        🎉 Booking successful! 
    </div>
<% } %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>

<body>
    <% if (bookings == null) { %>
    <p style="color:red;">NO DATA RECEIVED FROM SERVLET</p>
<% } %>
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
        <div class="booking-row">
    💰 Paid: KES <%= b.get("amount") != null ? b.get("amount") : "0" %>
</div>

<div class="booking-row">
    📡 Payment Status: <%= b.get("status") != null ? b.get("status") : "Not Paid" %>
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
