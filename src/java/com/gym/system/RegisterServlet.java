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
import java.security.MessageDigest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
     // 🔐 PASSWORD HASHING (SHA-256)
    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes("UTF-8"));

            StringBuilder hexString = new StringBuilder();
            for (byte b : hashedBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String regNo = request.getParameter("regNo");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        System.out.println("servlet HIT!!");
        
        
        
        // Simple validation
        if (name == null || email == null || regNo == null || phone == null ||
            password == null || confirmPassword == null){
            request.setAttribute("error", "Please fill all fields");
            request.getRequestDispatcher("frontend/register.jsp").forward(request, response);
            return;
        }
        //password validation
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{11,}$";

        if (!password.matches(passwordPattern)) {
        request.setAttribute("error",
        "Password must be at least 11 characters and include uppercase, lowercase, number, and special character.");
        request.getRequestDispatcher("frontend/register.jsp").forward(request, response);
    return;
}
        //password check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("frontend/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters");
            request.getRequestDispatcher("frontend/register.jsp").forward(request, response);
            return;
        }
        
            try {
    Connection conn = DBConnection.getConnection();
    //hash password before saving
    String hashedPassword = hashPassword(password);

    String sql = "INSERT INTO Member (name, registration_number, phone, email,password) VALUES (?, ?, ?, ?,?)";

    PreparedStatement ps = conn.prepareStatement(sql);

    ps.setString(1, name);
    ps.setString(2, regNo);
    ps.setString(3, phone);
    ps.setString(4, email);
    ps.setString(5, hashedPassword);

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
} 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // optional: handle GET same as POST
    }
}