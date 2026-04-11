<%-- 
    Document   : profile
    Created on : Apr 11, 2026, 7:46:57 PM
    Author     : san
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email"); // if you store it
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>

<body>

<div class="container">
<div class="glass-card">

    <h2>👤 My Profile</h2>

    <div class="profile-card">

        <p><strong>Name:</strong> <%= name != null ? name : "User" %></p>

        <p><strong>Email:</strong> <%= email != null ? email : "Not set" %></p>

        <p><strong>Status:</strong> Active Member 💪</p>

        <p><strong>Member since:</strong> 2026</p>

    </div>

    <a href="editProfile.jsp" class="card">✏️ Edit Profile</a>

    <a href="logout.jsp" class="card">🚪 Logout</a>

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
