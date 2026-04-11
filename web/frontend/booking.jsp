<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
String payment = request.getParameter("payment");

if ("success".equals(payment)) {
%>
    <p style="color:green;">Payment successful!</p>
<%
} else if ("fail".equals(payment)) {
%>
    <p style="color:red;">Payment failed!</p>
<%
}
%>
<%
String success = request.getParameter("success");
String error = request.getParameter("error");

if ("1".equals(success)) {
%>
    <p style="color:green;">Booking successful!</p>
<%
} else if ("full".equals(error)) {
%>
    <p style="color:red;">Session is full!</p>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
    
    <title>Booking Session page</title>

    <link rel="stylesheet" href="/GymManagementSystem2/frontend/css/style2.css">
</head>
<body>
<div class="container">
   <h2>Book a Session</h2>

<%
List<Map<String, String>> sessions = 
    (List<Map<String, String>>) request.getAttribute("sessions");

if (sessions != null) {
    for (Map<String, String> s : sessions) {
        int booked = Integer.parseInt(s.get("booked"));
        int capacity = Integer.parseInt(s.get("capacity"));

        if (booked < capacity) {
%>
<%
if (sessions == null) {
    out.println("<p style='color:red;'>NO SESSIONS FOUND — Servlet not working</p>");
}
%>

<form action="${pageContext.request.contextPath}/BookServlet" method="post">
    <input type="hidden" name="session_id" value="<%= s.get("id") %>">
    
    <button type="submit" class="card">
        <%= s.get("time") %> ( <%= booked %>/<%= capacity %> )
    </button>
</form>

<%
        } else {
%>

<button class="card" disabled>
    <%= s.get("time") %> (FULL)
</button>

<%
        }
    }
}
%>
</div>
</body>
</html>
