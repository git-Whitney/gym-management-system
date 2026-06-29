/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;

/**
 *
 * @author san
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    //same hash function as register
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

        String regNo = request.getParameter("regNo").trim();
        String password = request.getParameter("password").trim();
        
       if (regNo == null || password == null) {
            request.setAttribute("error", "Please fill all fields");
            request.getRequestDispatcher("frontend/login.jsp").forward(request, response);
            return;
        }

        String hashedPassword = hashPassword(password);

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM Member WHERE registration_number=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);

             ps.setString(1, regNo);
            ps.setString(2, hashedPassword);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // USER FOUND
             int userId = rs.getInt("member_id");

                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("name", rs.getString("name"));
                session.setMaxInactiveInterval(900); // 15 mins (better security)

                System.out.println("LOGIN SUCCESS");

                response.sendRedirect(request.getContextPath() + "/frontend/dashboard.jsp");


            } else {
                // USER NOT FOUND

                request.setAttribute("error", "Invalid registration number or password!");
                request.getRequestDispatcher("frontend/login.jsp").forward(request, response);
            
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
             request.setAttribute("error", "Server error. Try again later.");
            request.getRequestDispatcher("frontend/login.jsp").forward(request, response);
        }
    }
}