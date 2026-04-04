<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard page</title>

    
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Dashboard</h2>

<a href="booking.jsp">Book Session</a><br><br>
<a href="payment.jsp">Make Payment</a><br><br>

<p>Welcome, <%= session.getAttribute("user") %></p>
    
    <script src="js/script.js"></script>
</body>
</html>
