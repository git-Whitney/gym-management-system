<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>
<body>
<div class="container">
     <div class="glass-card">
    <h2>Login</h2>

<form action="${pageContext.request.contextPath}/LoginServlet" method="post">
    <input type="email" name="email" placeholder="Enter Email" required>
    <input type="text" name="regNo" placeholder="Enter RegNo" required>
    <button type="submit">Login</button>
</form>
<p class="link-text">Don't have an account?</p>
<a class="link" href="${pageContext.request.contextPath}/frontend/register.jsp">Register here</a>

<p class="error">
    <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
</p>
     </div>
</div>
  
    <script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
</body>
</html>