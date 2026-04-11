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
    <h2>Welcome, <%= name != null ? name : "User" %></h2>

    <!-- BOOK SESSION -->
    <a  href="${pageContext.request.contextPath}/LoadSessions" class="card">
        Book Session
    </a>

    <!-- MAKE PAYMENT -->
    <a href="payment.jsp" class="card">
        Make Payment
    </a>

    <!-- VIEW PROFILE -->
    <a href="profile.jsp" class="card">
        View Profile
    </a>

  </div>
</div>
<script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
</body>
</html>