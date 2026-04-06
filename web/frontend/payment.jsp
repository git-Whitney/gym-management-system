<!DOCTYPE html>
<html>
<head>
    <title>Payment page</title>
    <link rel="stylesheet" href="/GymManagementSystem2/frontend/css/style2.css">
</head>
    <body>
       <h2>Record Payment</h2>

<form action="PaymentServlet" method="post">
    <input type="text" name="member_id" placeholder="Member ID" required><br><br>

    <input type="number" name="amount" placeholder="Amount" required><br><br>

    <select name="payment_type">
        <option value="membership">Membership</option>
        <option value="walk-in">Walk-in</option>
    </select><br><br>

    <button type="submit">Record Payment</button>
</form>
       <script src="js/script.js"></script>
    </body>
</html>
