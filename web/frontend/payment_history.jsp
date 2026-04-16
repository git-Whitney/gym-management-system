<%@ page import="java.util.*, com.gym.system.Payment" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment History</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        .SUCCESS { color: green; font-weight: bold; }
        .FAILED { color: red; font-weight: bold; }
        .PENDING { color: orange; font-weight: bold; }
    </style>
</head>

<body>
<div class="payment-container">
<h2 class="class="payment-title"">💳 Payment History</h2>

<table class="payment-table">
    <tr>
        <th>ID</th>
        <th>Amount</th>
        <th>Date</th>
        <th>Semester</th>
        <th>Phone</th>
        <th>Method</th>
        <th>Transaction Code</th>
        <th>Status</th>
    </tr>

<%
    List<Payment> payments = (List<Payment>) request.getAttribute("payments");

    if (payments != null) {
        for (Payment p : payments) {
%>

<tr>
    <td><%= p.getPaymentId() %></td>
    <td><%= p.getAmount() %></td>
    <td><%= p.getPaymentDate() %></td>
    <td><%= p.getSemester() %></td>
    <td><%= p.getPhone() %></td>
    <td><%= p.getPaymentMethod() %></td>
    <td><%= p.getTransactionCode() %></td>
    <td class="<%= p.getStatus() %>">
        <%= p.getStatus() %>
    </td>
</tr>

<%
        }
    }
%>

</table>
</div>
</body>
</html>