<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register page</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <h2>Register</h2>

<form action="RegisterServlet" method="post">
    <input type="text" name="name" placeholder="Full Name" required><br><br>
    <input type="text" name="regNo" placeholder="Registration Number" required><br><br>
    <input type="email" name="email" placeholder="Email" required><br><br>
    <input type="text" name="phone" placeholder="Phone" required><br><br>
    <button type="submit">Register</button>
</form>

    
    <script src="js/script.js"></script>
</body>
</html>
