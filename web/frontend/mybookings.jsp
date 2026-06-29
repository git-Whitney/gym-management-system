<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
  List<Map<String, String>> bookings =
    (List<Map<String, String>>) request.getAttribute("bookings");
  String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>My Bookings — FitZone</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style3.css">
</head>
<body class="has-bg-image">

<%@ include file="nav.jsp" %>

<div class="page-wrapper">

  <div class="page-header">
    <div class="greeting">My <span>Bookings</span></div>
    <div class="subtext">All your scheduled gym sessions</div>
  </div>

  <% if ("booked".equals(success)) { %>
    <div class="alert success">🎉 Booking successful! See you at the gym.</div>
  <% } %>

  <!-- QR / Entrance pass notice -->
  <div style="background:rgba(0,198,255,0.1); border:1px solid rgba(0,198,255,0.25); border-radius:10px; padding:12px 16px; font-size:13px; color:rgba(255,255,255,0.8); margin-bottom:18px;">
    🎟️ Show this screen at the gym entrance
  </div>

  <%
    if (bookings == null || bookings.isEmpty()) {
  %>
    <div class="alert warning">You have no bookings yet. <a href="${pageContext.request.contextPath}/LoadSessions" class="link">Book a session →</a></div>
  <%
    } else {
      for (Map<String, String> b : bookings) {
  %>
  <div class="booking-card">
    <div class="booking-row">🕒 <strong><%= b.get("time") %></strong></div>
    <div class="booking-row">📅 Date: <%= b.get("date") != null ? b.get("date") : "Today" %></div>
    <div class="booking-row">Status: <span class="status-confirmed">✅ CONFIRMED</span></div>
    <div class="booking-row">💰 Paid: KES <%= b.get("amount") != null ? b.get("amount") : "0" %></div>
    <div class="booking-row">📡 Payment:
      <span class="<%= "PENDING".equals(b.get("status")) ? "status-pending" : "status-confirmed" %>">
        <%= b.get("status") != null ? b.get("status") : "Not Paid" %>
      </span>
    </div>
  </div>
  <%
      }
    }
  %>

</div>

</body>
</html>
