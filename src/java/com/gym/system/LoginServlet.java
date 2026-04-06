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

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM Member WHERE email=? AND registration_number=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, regNo);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ USER FOUND

                HttpSession session = request.getSession();
                session.setAttribute("name", rs.getString("name"));

                // 🔥 REDIRECT TO DASHBOARD
                response.sendRedirect("frontend/dashboard.jsp");

            } else {
                // ❌ USER NOT FOUND

                request.setAttribute("error", "Invalid login details");
                request.getRequestDispatcher("frontend/login.jsp").forward(request, response);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}