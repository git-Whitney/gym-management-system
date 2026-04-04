/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.io.PrintWriter;
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
        String password = request.getParameter("password");

        // TEMP LOGIN (replace with DB later)
        if(email.equals("admin@gmail.com") && password.equals("1234")) {

            HttpSession session = request.getSession();
            session.setAttribute("user", email);

            response.sendRedirect("admin.jsp");

        } else {
            request.setAttribute("error", "Invalid login details");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}