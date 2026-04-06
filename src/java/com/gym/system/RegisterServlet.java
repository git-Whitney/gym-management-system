/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String regNo = request.getParameter("regNo");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
System.out.println("servlet HIT!!");
        // Simple validation
        if (name != null && email != null && regNo != null && phone != null) {

            try {
    Connection conn = DBConnection.getConnection();

    String sql = "INSERT INTO Member (name, registration_number, phone, email) VALUES (?, ?, ?, ?)";

    PreparedStatement ps = conn.prepareStatement(sql);

    ps.setString(1, name);
    ps.setString(2, regNo);
    ps.setString(3, phone);
    ps.setString(4, email);

    ps.executeUpdate();

    ps.close();
    conn.close();

    HttpSession session = request.getSession();
    session.setAttribute("name", name);
session.setAttribute("message", "Registration successful!");

response.sendRedirect("frontend/register.jsp");

   } catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("error", "Database error: " + e.getMessage());
    request.getRequestDispatcher("frontend/register.jsp").forward(request, response);
}
} else {
            request.setAttribute("error", "Please fill all fields");
            request.getRequestDispatcher("frontend/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // optional: handle GET same as POST
    }
}