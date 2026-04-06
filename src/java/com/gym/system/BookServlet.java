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


@WebServlet(name = "BookServlet", urlPatterns = {"/BookServlet"})

public class BookServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       int sessionId = Integer.parseInt(request.getParameter("session_id"));
       System.out.println("Booking session ID: " + sessionId);
       System.out.println("🔥 BookServlet is running");
       
Connection conn = null;
        try {
    conn = DBConnection.getConnection();

            String sql = "UPDATE gymsession SET booked_count = booked_count + 1 " +
                         "WHERE session_id = ? AND booked_count < max_capacity";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, sessionId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("LoadSessions?success=1");
            } else {
                response.sendRedirect("LoadSessions?error=full");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
    DBConnection.closeConnection(conn); // ✅ IMPORTANT
}
    }
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);
}
}