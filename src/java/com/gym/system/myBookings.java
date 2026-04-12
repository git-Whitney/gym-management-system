/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author san
 */
@WebServlet(name = "myBookings", urlPatterns = {"/myBookings"})
public class myBookings extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         System.out.println("🔥 MyBookings servlet HIT");

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();

            HttpSession session = request.getSession();
Integer userId = (Integer) session.getAttribute("user_id");

if (userId == null) {
    System.out.println("❌ No user in session");
    response.sendRedirect("frontend/login.jsp");
    return;
}

           String sql =
    "SELECT b.booking_date, g.session_time, b.payment_status " +
    "FROM booking b " +
    "JOIN gymsession g ON b.session_id = g.session_id " +
    "WHERE b.member_id = ? " +
    "AND DATE(b.booking_date) = CURDATE() " +
    "ORDER BY b.booking_date DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            List<Map<String, String>> bookings = new ArrayList<>();

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();

                map.put("date", rs.getString("booking_date"));
                map.put("time", rs.getString("session_time"));
                map.put("payment_status",
                        rs.getString("payment_status") != null ? rs.getString("payment_status") : "Pending");

                bookings.add(map);
            }

            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/frontend/mybookings.jsp")
                   .forward(request, response);

        } catch (Exception e) {
             e.printStackTrace();
    response.setContentType("text/plain");
    response.getWriter().println("ERROR LOADING BOOKINGS: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}