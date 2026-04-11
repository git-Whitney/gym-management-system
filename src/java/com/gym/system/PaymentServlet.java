/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
public class PaymentServlet extends HttpServlet {

   
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
System.out.println("This is running!");
       
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;

        try {
           conn = DBConnection.getConnection();

            // 🔐 Get logged-in user
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("user_id");

            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String semester = "2026-Sem1";

            // 🚫 CHECK IF USER ALREADY PAID
            String checkSql = "SELECT * FROM payment WHERE user_id=? AND semester=?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, userId);
            checkPs.setString(2, semester);

            var rs = checkPs.executeQuery();

            if (rs.next()) {
                // Already paid
                response.sendRedirect("LoadSessions?payment=already_paid");
                return;
            }

            // 💳 INSERT PAYMENT
            String sql = "INSERT INTO payment (user_id, semester, amount, status) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, semester);
            ps.setDouble(3, amount);
            ps.setString(4, "PAID");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("🔥 Payment recorded successfully");
                response.sendRedirect("LoadSessions?payment=success");
            } else {
                response.sendRedirect("LoadSessions?payment=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}