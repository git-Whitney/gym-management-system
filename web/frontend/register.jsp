<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Register — FitZone</title>
  <link rel="stylesheet" href="/GymManagementSystem2/frontend/css/style3.css">
  
</head>
<body class="has-bg-image">

<div class="auth-page">
  <div class="auth-card">

    <div class="brand">FIT<span>ZONE</span></div>
    <p class="tagline">Start your fitness journey today.</p>

    <h2>Create Account</h2>

    <%
      String message = (String) session.getAttribute("message");
      if (message != null) {
        session.removeAttribute("message");
    %>
      <div class="alert success"><%= message %> Redirecting to Login...</div>
      <script>setTimeout(() => window.location.href = "login.jsp", 2000);</script>
    <% } %>

    <form  id="registerForm" action="/GymManagementSystem2/RegisterServlet" method="post">
      <div class="form-group">
        <label>Full Name</label>
        <input id="name" class="form-input" type="text" name="name" placeholder="Your full name" required>
        <small class="error-message" id="nameError"></small>
      </div>
      <div class="form-group">
        <label>Registration Number</label>
        <input  id="regNo" class="form-input" type="text" name="regNo" placeholder="e.g. S17/10777/22" required>
        <small class="error-message" id="regNoError"></small>
      </div>
      <div class="form-group">
        <label>Email Address</label>
        <input id="email" class="form-input" type="email" name="email" placeholder="you@example.com" required>
        <small class="error-message" id="emailError"></small>
      </div>
        <div class="form-group">
     <label>Phone Number</label>
     <input id="phone"  class="form-input" type="text" name="phone"  placeholder="e.g. 0712345678" required>
     <small class="error-message" id="phoneError"></small>
    </div>
        
      <div class="form-group password-group">
     <label>Password</label>
     <div class="password-wrapper">
     <input id="password" class="form-input" type="password" name="password"autocomplete="new-password" required>
     <span class="toggle-password" onclick="togglePassword('password', this)">👁️</span>
     </div>
     <small class="error-message" id="passwordError"></small>
   </div>

    <div class="form-group password-group">
    <label>Confirm Password</label>
    <div class="password-wrapper">
    <input id="confirmPassword" class="form-input" type="password" name="confirmPassword" autocomplete="new-password" required>
    <span class="toggle-password" onclick="togglePassword('confirmPassword', this)">👁️</span>
  </div>
  <small class="error-message" id="confirmPasswordError"></small>
</div>


      <button type="submit" class="btn btn-primary">Create Account →</button>
    </form>

    <div class="auth-footer" style="margin-top:20px;">
      Already have an account? <a href="${pageContext.request.contextPath}/frontend/login.jsp">Login here</a>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
</body>
</html>
