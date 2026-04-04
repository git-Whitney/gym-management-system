<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style.css">
</head>
<body>

    <h2>Login</h2>

<form action="LoginServlet" method="post">
    <input type="email" name="email" placeholder="Enter Email" required><br><br>
    <input type="password" name="password" placeholder="Enter Password" required><br><br>
    <button type="submit">Login</button>
</form>

<p style="color:red;">
    <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
</p>


  
    <script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
</body>
</html>