<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin page</title>

    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>


<h1>Admin Dashboard</h1>

<p>Welcome, Admin</p>

<hr>

<h3>Management Panel</h3>

<div>
    <a href="register.jsp">
        <button>Register Member</button>
    </a>

    <a href="members.jsp">
        <button>View Members</button>
    </a>

    <a href="booking.jsp">
        <button>Manage Bookings</button>
    </a>

    <a href="payment.jsp">
        <button>Record Payment</button>
    </a>
</div>

<hr>

<h3>Quick Actions</h3>

<form action="LogoutServlet" method="post">
    <button type="submit">Logout</button>
</form>


    <script src="js/script.js"></script>
</body>
</html>
