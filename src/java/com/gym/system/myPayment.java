/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.io.IOException;
import java.sql.Connection;
import org.json.JSONObject;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet(name = "myPayment", urlPatterns = {"/myPayment"})
public class myPayment extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession().getAttribute("user_id");

        try {
            Connection conn = DBConnection.getConnection();

            String sql =
                "SELECT amount, semester, status, transaction_code " +
                "FROM payment WHERE user_id = ? ORDER BY payment_date DESC LIMIT 1";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            Payment payment = null;

            if (rs.next()) {
                payment = new Payment();
                payment.setAmount(rs.getInt("amount"));
                payment.setSemester(rs.getString("semester"));
                payment.setStatus(rs.getString("status"));
                payment.setTransactionCode(rs.getString("transaction_code"));
            }

            request.setAttribute("payment", payment);

            request.getRequestDispatcher("frontend/payment.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
