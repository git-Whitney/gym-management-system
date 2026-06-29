<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login — FitZone</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style3.css">
</head>
<body class="has-bg-image">

<div class="auth-page">
  <div class="auth-card">

    <div class="brand">FIT<span>ZONE</span></div>
    <p class="tagline">Push harder. Train smarter. Live better.</p>

    <h2>Welcome Back</h2>

    <form id="loginForm" action="${pageContext.request.contextPath}/LoginServlet" method="post">
      
      <div class="form-group">
        <label>Registration Number</label>
        <input id="loginRegNo" class="form-input" type="text" name="regNo" placeholder="e.g. S17/10777/22" required>
        <small class="error-message" id="loginRegNoError"></small>
      </div>
        <div class="form-group" style="position: relative;">
       <label>Password</label>

       <input id="loginPassword" class="form-input" type="password" name="password" required>

       <span 
       onclick="togglePassword('loginPassword', this)" 
        style="position:absolute; right:10px; top:38px; cursor:pointer;">
        👁️
       </span>
</div>

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert error"><%= request.getAttribute("error") %></div>
      <% } %>

      <button type="submit" class="btn btn-primary" style="margin-top:4px;">Login →</button>
    </form>
    <div style="margin-top:10px;">
    <a href="forgotPassword.jsp">Forgot Password?</a>
   </div>
    <div class="auth-footer" style="margin-top:20px;">
      Don't have an account? <a href="${pageContext.request.contextPath}/frontend/register.jsp">Register here</a>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
</body>
</html>
