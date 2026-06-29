<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
  String payment = request.getParameter("payment");
  String success = request.getParameter("success");
  String error   = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Book Session — FitZone</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style3.css">
</head>
<body class="has-bg-image">

<%@ include file="nav.jsp" %>

<div class="page-wrapper">

  <div class="page-header">
    <div class="greeting">Book a <span>Session</span></div>
    <div class="subtext">Choose an available time slot below</div>
  </div>

  <% if ("success".equals(payment)) { %><div class="alert success">✅ Payment successful!</div><% } %>
  <% if ("fail".equals(payment))    { %><div class="alert error">❌ Payment failed. Try again.</div><% } %>
  <% if ("1".equals(success))       { %><div class="alert success">🎉 Booking confirmed!</div><% } %>
  <% if ("full".equals(error))      { %><div class="alert error">😔 That session is full.</div><% } %>
  <% if ("already".equals(error))   { %><div class="alert warning">⚠️ You already booked this session today.</div><% } %>

  <%
    List<Map<String, String>> sessions =
      (List<Map<String, String>>) request.getAttribute("sessions");

    if (sessions == null) {
  %>
    <p class="text-muted" style="text-align:center; padding:30px 0;">⚠️ Could not load sessions. Please try again.</p>
  <% } else { for (Map<String, String> s : sessions) {
       int booked   = Integer.parseInt(s.get("booked"));
       int capacity = Integer.parseInt(s.get("capacity"));
       boolean isFull = booked >= capacity;
  %>

  <% if (!isFull) { %>
  <form action="${pageContext.request.contextPath}/BookServlet" method="post" style="margin:0;">
    <input type="hidden" name="session_id" value="<%= s.get("id") %>">
    <button type="submit" class="session-card" style="width:100%; background:none; text-align:left; cursor:pointer; border:1px solid rgba(255,255,255,0.1); border-radius:14px; display:flex; justify-content:space-between; align-items:center; padding:16px 18px; margin-bottom:10px; color:white; transition:all 0.25s; font-family:inherit;">
      <span class="time">🕒 <%= s.get("time") %></span>
      <span class="slots"><%= booked %>/<%= capacity %> booked</span>
    </button>
  </form>
  <% } else { %>
  <div class="session-card full">
    <span class="time">🕒 <%= s.get("time") %></span>
    <span style="font-size:12px; color:#ff4d4d; font-weight:600; background:rgba(255,77,77,0.12); border:1px solid rgba(255,77,77,0.25); padding:4px 10px; border-radius:20px;">FULL</span>
  </div>
  <% } } } %>

</div>

</body>
</html>
