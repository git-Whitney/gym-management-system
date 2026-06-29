<%-- 
    Document   : editProfile
    Created on : Jun 24, 2026, 3:55:25 PM
    Author     : san
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>edit profile page</title>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/EditProfileServlet" method="post">

    <div class="form-group">
        <label>Full Name</label>
        <input type="text"
               name="name"
               value="<%= session.getAttribute("name") %>"
               required>
    </div>

    <div class="form-group">
        <label>Email</label>
        <input type="email"
               name="email"
               value="<%= session.getAttribute("email") %>"
               required>
    </div>

    <div class="form-group">
        <label>Phone</label>
        <input type="text"
               name="phone"
               value="<%= session.getAttribute("phone") %>"
               required>
    </div>

    <button type="submit" class="btn btn-primary">
        Save Changes
    </button>

</form>
    </body>
</html>
