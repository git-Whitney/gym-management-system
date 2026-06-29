<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String name  = (String) session.getAttribute("name");
  String email = (String) session.getAttribute("email");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Profile — FitZone</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style3.css">
</head>
<body class="has-bg-image">

<%@ include file="nav.jsp" %>

<div class="page-wrapper">

  <div class="page-header">
    <div class="greeting">My <span>Profile</span></div>
    <div class="subtext">Manage your account details</div>
  </div>

  <div class="glass-card" style="text-align:center;">
    <div class="profile-avatar">💪</div>

    <div style="margin-bottom:20px;">
      <h3 style="font-family:'Syne',sans-serif; font-size:20px; font-weight:700;">
        <%= name != null ? name : "Athlete" %>
      </h3>
      <p class="text-muted"><%= email != null ? email : "No email set" %></p>
    </div>

    <div class="profile-info">
      <div class="profile-row">
        <span class="label">Status</span>
        <span class="badge">Active Member ✅</span>
      </div>
      <div class="profile-row">
        <span class="label">Member Since</span>
        <span class="value">2026</span>
      </div>
      <div class="profile-row">
        <span class="label">Plan</span>
        <span class="value">Monthly</span>
      </div>
    </div>
  </div>

  <a href="editProfile.jsp" class="btn btn-secondary" style="display:block; text-decoration:none; text-align:center; padding:14px; margin-bottom:10px;">
    ✏️ Edit Profile
  </a>

  <a href="${pageContext.request.contextPath}/frontend/login.jsp"
     class="btn btn-danger" style="display:block; text-decoration:none; text-align:center; padding:14px;">
    🚪 Logout
  </a>

</div>

</body>
</html>
