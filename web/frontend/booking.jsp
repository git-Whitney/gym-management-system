<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
String payment = request.getParameter("payment");
String success = request.getParameter("success");
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    
    <title>Booking Session page</title>

    <link rel="stylesheet" href="/GymManagementSystem2/frontend/css/style2.css">
</head>
<body>
<div class="container">
    <div class="glass-card">
   <h2>Book a Session</h2>
   <% if ("success".equals(payment)) { %>
    <div class="alert success">Payment successful!</div>
<% } else if ("fail".equals(payment)) { %>
    <div class="alert error">Payment failed!</div>
<% } %>

<% if ("1".equals(success)) { %>
    <div class="alert success">Booking successful!</div>
<% } else if ("full".equals(error)) { %>
    <div class="alert error">Session is full!</div>
<% } %>
<% if ("already".equals(error)) { %>
    <div class="alert error">You already booked this session today!</div>
<% } %>

<%
List<Map<String, String>> sessions = 
    (List<Map<String, String>>) request.getAttribute("sessions");

if (sessions != null) {
    for (Map<String, String> s : sessions) {
        int booked = Integer.parseInt(s.get("booked"));
        int capacity = Integer.parseInt(s.get("capacity"));

        if (booked < capacity) {
%>
<%
if (sessions == null) {
    out.println("<p style='color:red;'>NO SESSIONS FOUND — Servlet not working</p>");
}
%>

<form action="${pageContext.request.contextPath}/BookServlet" method="post">
    <input type="hidden" name="session_id" value="<%= s.get("id") %>">
    
    <button type="submit" class="card">
        <span>🕒 <%= s.get("time") %></span>
    <span><%= booked %>/<%= capacity %></span>
    </button>
</form>

<%
        } else {
%>

<button class="card" disabled>
     <span>🕒 <%= s.get("time") %></span>
    <span>FULL</span>
</button>

<%
        }
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
