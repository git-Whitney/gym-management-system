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

/**
 *
 * @author san
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String regNo = request.getParameter("regNo");
        
        response.getWriter().println("LOGIN WORKING");

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM Member WHERE email=? AND registration_number=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, regNo);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ USER FOUND
            int userId = rs.getInt("member_id");
                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("name", rs.getString("name"));
                System.out.println("LOGIN SUCCESS");
                // 🔥 REDIRECT TO DASHBOARD
                //response.sendRedirect("LoadSessions");
               response.sendRedirect(request.getContextPath() + "/frontend/dashboard.jsp");

            } else {
                // ❌ USER NOT FOUND

                request.setAttribute("error", "Invalid login details");
                request.getRequestDispatcher("frontend/dashboard.jsp").forward(request, response);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
             response.sendRedirect("frontend/login.jsp?error=server");
        }
    }
}