<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>
<body>

    <h2>Login</h2>

<form action="${pageContext.request.contextPath}/LoginServlet" method="post">
    <input type="email" name="email" placeholder="Enter Email" required><br><br>
    <input type="text" name="regNo" placeholder="Enter RegNo" required><br><br>
    <button type="submit">Login</button>
</form>
<p>Don't have an account?</p>
<a href="${pageContext.request.contextPath}/frontend/register.jsp">Register here</a>

<p style="color:red;">
    <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
</p>


  
    <script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
</body>
</html>