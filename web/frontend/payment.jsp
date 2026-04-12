<!DOCTYPE html>
<html>
<head>
    <title>Payment Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style2.css">
</head>
<body>
    <div class="container">
<form action="${pageContext.request.contextPath}/PaymentServlet" method="post">

    <input type="hidden" name="session_id" value="<%= request.getParameter("session_id") %>">

    <label>Enter Amount:</label>
    <input type="number" name="amount" required>

    <button type="submit">Pay</button>
</form>
    </div>
    <div class="bottom-nav">

    <a href="${pageContext.request.contextPath}/frontend/dashboard.jsp" class="nav-item">
        <span>?</span>
        <small>Home</small>
    </a>

    <a href="${pageContext.request.contextPath}/LoadSessions" class="nav-item">
        <span>?</span>
        <small>Booking</small>
    </a>
        <a href="${pageContext.request.contextPath}/myBookings" class="nav-item">
        <span>?</span>
        <small>My Bookings</small>
    </a>

    <a href="${pageContext.request.contextPath}/frontend/payment.jsp" class="nav-item">
        <span>?</span>
        <small>Payment</small>
    </a>

    <a href="${pageContext.request.contextPath}/frontend/profile.jsp" class="nav-item">
        <span>?</span>
        <small>Profile</small>
    </a>

</div>
</body>
</html>