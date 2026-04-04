<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Session page</title>

    <link rel="stylesheet" href="css/style.css">
</head>
<body>

   <h2>Book a Session</h2>

<form action="BookingServlet" method="post">
    <label>Select Session:</label>
    <select name="session_id">
        <option value="1">Morning</option>
        <option value="2">Afternoon</option>
        <option value="3">Evening</option>
    </select><br><br>

    <button type="submit">Book</button>
</form>
    <script src="js/script.js"></script>
</body>
</html>
