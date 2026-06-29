<%@ page import="java.util.*, com.gym.system.Payment" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Payment History — FitZone</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style3.css">
</head>
<body class="has-bg-image">

<%@ include file="nav.jsp" %>

<div class="page-wrapper" style="max-width:720px;">

  <div class="page-header">
    <div class="greeting">Payment <span>History</span></div>
    <div class="subtext">All your transactions in one place</div>
  </div>

  <div class="glass-card" style="padding:0; overflow:hidden;">
    <div class="payment-table-wrapper">
      <table class="payment-table">
        <thead>
          <tr>
            <th>#</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Semester</th>
            <th>Phone</th>
            <th>Method</th>
            <th>Txn Code</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Payment> payments = (List<Payment>) request.getAttribute("payments");
            if (payments != null && !payments.isEmpty()) {
              for (Payment p : payments) {
          %>
          <tr>
            <td><%= p.getPaymentId() %></td>
            <td><b>KES <%= p.getAmount() %></b></td>
            <td><%= p.getPaymentDate() %></td>
            <td><%= p.getSemester() %></td>
            <td><%= p.getPhone() %></td>
            <td><%= p.getPaymentMethod() %></td>
            <td style="font-size:11px; font-family:monospace;"><%= p.getTransactionCode() %></td>
            <td class="<%= p.getStatus() %>"><%= p.getStatus() %></td>
          </tr>
          <%
              }
            } else {
          %>
          <tr>
            <td colspan="8" style="padding:30px; color:rgba(255,255,255,0.4); text-align:center;">
              No payment records found.
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
<a href="${pageContext.request.contextPath}/DownloadPaymentPDFServlet"
   class="btn btn-secondary">

   📄 Download PDF

</a>
</div>

</body>
</html>
