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
</body>
</html>