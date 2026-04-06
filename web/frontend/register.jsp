<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register page</title>
    <link rel="stylesheet" href="/GymManagementSystem2/frontend/css/style2.css">
</head>
<body>
<%
   String message = (String) session.getAttribute("message");
    if (message != null) {
     session.removeAttribute("message");//clear after use
%>
    <p style="color: green; font-weight: bold;"><%= message %> Redirecting to Login...</p>

    <script>
        setTimeout(function() {
            window.location.href = "login.jsp";
        }, 2000); // 2 seconds
    </script>
<%
    }
%>
    <h2>Register</h2>

<form action="/GymManagementSystem2/RegisterServlet" method="post">
    <input type="text" name="name" placeholder="Full Name" required><br><br>
    <input type="text" name="regNo" placeholder="Registration Number" required><br><br>
    <input type="email" name="email" placeholder="Email" required><br><br>
    <input type="text" name="phone" placeholder="Phone" required><br><br>
    <button type="submit">Register</button>
</form>
<p>Already have an account?</p>
<a href="login.jsp">Login here</a>
    
   <script src="/GymManagementSystem2/frontend/js/script.js"></script>
</body>
</html>
