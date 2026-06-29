<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin — FitZone</title>
  <link rel="stylesheet" href="css/style3.css">
</head>
<body class="has-bg-image">

<div class="page-wrapper">

  <div class="page-header">
    <div class="greeting">Admin <span>Panel</span></div>
    <div class="subtext">Welcome, Administrator</div>
  </div>

  <div class="quick-actions">
    <a href="register.jsp" class="action-card">
      <span class="action-icon">➕</span>
      <span class="action-label">Register Member</span>
    </a>
    <a href="members.jsp" class="action-card">
      <span class="action-icon">👥</span>
      <span class="action-label">View Members</span>
    </a>
    <a href="booking.jsp" class="action-card">
      <span class="action-icon">📅</span>
      <span class="action-label">Manage Bookings</span>
    </a>
    <a href="payment.jsp" class="action-card">
      <span class="action-icon">💳</span>
      <span class="action-label">Record Payment</span>
    </a>
  </div>

  <form action="LogoutServlet" method="post" style="margin-top:10px;">
    <button type="submit" class="btn btn-danger">🚪 Logout</button>
  </form>

</div>

</body>
</html>
