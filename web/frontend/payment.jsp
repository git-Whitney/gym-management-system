<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Payment — FitZone</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style3.css">
</head>
<body class="has-bg-image">

<%@ include file="nav.jsp" %>

<div class="page-wrapper">

  <div class="page-header">
    <div class="greeting">Make a <span>Payment</span></div>
    <div class="subtext">Secure M-Pesa payment — KES 300 per semester</div>
  </div>

  <div class="glass-card">
    <h2>💳 M-Pesa Checkout</h2>

    <div style="background:rgba(0,198,255,0.08); border:1px solid rgba(0,198,255,0.2); border-radius:10px; padding:14px 16px; margin-bottom:20px; font-size:13px; color:rgba(255,255,255,0.75);">
      📲 An STK push will be sent to your M-Pesa number. Enter your PIN to complete.
    </div>

    <form id="paymentForm" action="${pageContext.request.contextPath}/stkpush" method="post">
      <div class="form-group">
        <label>M-Pesa Phone Number</label>
        <input id="mpesaPhone" class="form-input" type="tel" pattern="^254[17][0-9]{8}$" name="phone"
               placeholder="2547XXXXXXXX" oninput="validatePhone(this.value)"required>
        <span id="phoneError"></span>
        <small class="error-message" id="mpesaError"></small>
      </div>
      <input type="hidden" name="amount" value="300">
      <button type="submit" class="btn btn-primary">Pay KES 300 via M-Pesa 💚</button>
    </form>
  </div>

  <!-- Last payment details -->
  <c:if test="${payment != null}">
    <div class="glass-card" style="margin-top:16px;">
      <h2>Last Transaction</h2>
      <div class="booking-card" style="margin:0;">
        <div class="booking-row">💰 Amount: <b>KES ${payment.amount}</b></div>
        <div class="booking-row">📅 Semester: ${payment.semester}</div>
        <div class="booking-row">🔖 Code: ${payment.transactionCode}</div>
        <div class="booking-row">📡 Status: <span class="status">${payment.status}</span></div>
      </div>
    </div>
  </c:if>

  <div style="text-align:center; margin-top:16px;">
    <a href="${pageContext.request.contextPath}/PaymentHistoryServlet" class="link">View full payment history →</a>
  </div>

</div>
<script src="${pageContext.request.contextPath}/frontend/js/script.js"></script>
</body>
</html>
