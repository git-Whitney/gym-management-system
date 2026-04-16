/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import org.json.JSONObject;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author san
 */
@WebServlet(name = "stkpush", urlPatterns = {"/stkpush"})
public class stkpush extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("🔥 STK PUSH TRIGGERED");

        String phone = request.getParameter("phone"); // 2547...
        int amount = 300;

        try {

            // 1. Generate Access Token (we simplify here)
            String accessToken = MpesaAuth.getToken();

            // 2. Build STK Push request JSON
            String json = MpesaSTKRequest.build(phone, amount);

            // 3. Send request to Safaricom API
            String result = MpesaClient.sendStkPush(json, accessToken);
            Connection conn = DBConnection.getConnection();

int userId = (int) request.getSession().getAttribute("user_id");

String sql = "INSERT INTO payment (user_id, amount, semester, payment_method, status) VALUES (?, ?, ?, ?, ?)";

PreparedStatement ps = conn.prepareStatement(sql);

ps.setInt(1, userId);
ps.setDouble(2, 300);
ps.setString(3, "2026-Sem1");
ps.setString(4, "M-PESA");
ps.setString(5, "PENDING"); // will change later

ps.executeUpdate();

conn.close();

            System.out.println(result);

            response.sendRedirect("frontend/payment.jsp?msg=check_phone");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("frontend/payment.jsp?error=fail");
        }
     
    }
    
}