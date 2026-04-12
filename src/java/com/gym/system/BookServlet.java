/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "BookServlet", urlPatterns = {"/BookServlet"})

public class BookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       int sessionId = Integer.parseInt(request.getParameter("session_id"));
       int userId = (int) request.getSession().getAttribute("user_id");
       
       
Connection conn = null;
        try {
    conn = DBConnection.getConnection();
    // 🔍 Check if user already booked TODAY
String checkSql = "SELECT * FROM booking " +
                  "WHERE member_id=? AND session_id=? " +
                  "AND DATE(booking_date)=CURDATE()";

PreparedStatement checkPs = conn.prepareStatement(checkSql);
checkPs.setInt(1, userId);
checkPs.setInt(2, sessionId);

ResultSet rs = checkPs.executeQuery();

if (rs.next()) {
    // ❌ Already booked today
    response.sendRedirect("LoadSessions?error=already");
    return;
}
  // 2. CHECK CAPACITY
    String capSql =
        "SELECT max_capacity FROM gymsession WHERE session_id=?";

    PreparedStatement capPs = conn.prepareStatement(capSql);
    capPs.setInt(1, sessionId);

    ResultSet capRs = capPs.executeQuery();

    if (!capRs.next()) {
        response.sendRedirect("LoadSessions?error=fail");
        return;
    }

    int capacity = capRs.getInt(1);
//count todays bookings(only once)
    String countSql =
        "SELECT COUNT(*) FROM booking " +
        "WHERE session_id=? AND DATE(booking_date)=CURDATE()";

    PreparedStatement countPs = conn.prepareStatement(countSql);
    countPs.setInt(1, sessionId);

    ResultSet countRs = countPs.executeQuery();
    countRs.next();

    int bookedToday = countRs.getInt(1);

    if (bookedToday >= capacity) {
        response.sendRedirect("LoadSessions?error=full");
        return;
    }
     

            if (bookedToday >= capacity) {
                response.sendRedirect("LoadSessions?error=full");
                return;
            }
// 4. INSERT BOOKING (ONLY ONCE)
    String insertSql =
        "INSERT INTO booking (member_id, session_id) VALUES (?, ?)";

    PreparedStatement insertPs = conn.prepareStatement(insertSql);
    insertPs.setInt(1, userId);
    insertPs.setInt(2, sessionId);
    insertPs.executeUpdate();

    response.sendRedirect("LoadSessions?success=1");
           
        } catch (Exception e) {
            e.printStackTrace();
             response.sendRedirect("LoadSessions?error=fail");
        }finally {
    DBConnection.closeConnection(conn); 
        }
    }
}



   
