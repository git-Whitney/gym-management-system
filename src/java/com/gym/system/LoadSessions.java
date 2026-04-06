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


@WebServlet(name = "LoadSessions", urlPatterns = {"/LoadSessions"})

public class LoadSessions extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Loading sessions...");
         try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM gymsession";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            List<Map<String, String>> sessions = new ArrayList<>();

            while (rs.next()) {
                Map<String, String> session = new HashMap<>();
                session.put("id", rs.getString("session_id"));
                session.put("time", rs.getString("session_time"));
                session.put("booked", rs.getString("booked_count"));
                session.put("capacity", rs.getString("max_capacity"));

                sessions.add(session);
            }

            request.setAttribute("sessions", sessions);
            request.getRequestDispatcher("frontend/booking.jsp").forward(request, response);

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