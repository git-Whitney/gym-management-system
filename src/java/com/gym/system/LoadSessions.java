/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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


@WebServlet(name = "LoadSessions", urlPatterns = {"/LoadSessions"})

public class LoadSessions extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Loading sessions...");
         try {
            Connection conn = DBConnection.getConnection();

           
            // 🔐 Get logged-in user
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("user_id");
            if (userId == null) {
                response.sendRedirect("frontend/dashboard.jsp");
                return;
            }
             // 💳 CHECK IF USER HAS PAID THIS SEMESTER
            String checkPaymentSql = "SELECT * FROM payment WHERE user_id=? AND semester=?";
            PreparedStatement checkPs = conn.prepareStatement(checkPaymentSql);
            checkPs.setInt(1, userId);
            checkPs.setString(2, "2026-Sem1");
            ResultSet paymentRs = checkPs.executeQuery();

            //if (!paymentRs.next()) {
                // ❌ NOT PAID → redirect to payment page
            //    response.sendRedirect(request.getContextPath() + "/frontend/payment.jsp");
            //    return;
           // }
             // ✅ PAID → load sessions
            String sql = "SELECT * FROM gymsession";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            List<Map<String, String>> sessions = new ArrayList<>();


            while (rs.next()) {
                Map<String, String> sessionData = new HashMap<>();
                sessionData.put("id", rs.getString("session_id"));
                sessionData.put("time", rs.getString("session_time"));
                sessionData.put("capacity", rs.getString("max_capacity"));
                
                String countSql =
    "SELECT COUNT(*) FROM booking " +
    "WHERE session_id=? AND DATE(booking_date)=CURDATE()";

PreparedStatement countPs = conn.prepareStatement(countSql);
countPs.setString(1, rs.getString("session_id"));

ResultSet countRs = countPs.executeQuery();
countRs.next();

int bookedToday = countRs.getInt(1);

sessionData.put("booked", String.valueOf(bookedToday));

                sessions.add(sessionData);
            }

            request.setAttribute("sessions", sessions);
            request.getRequestDispatcher("/frontend/booking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);
}
}