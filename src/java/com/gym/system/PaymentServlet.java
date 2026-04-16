/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import org.json.JSONObject;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
public class PaymentServlet extends HttpServlet {

   
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int amount = 300;
        int userId = (int) request.getSession().getAttribute("user_id");
        String phone = request.getParameter("phone");
        System.out.println("📞 RAW PHONE: " + phone);
        if (phone.startsWith("0")) {
       phone = "254" + phone.substring(1);
}     System.out.println("📞 FORMATTED PHONE: " + phone);

        try {
            Connection conn = DBConnection.getConnection();
       String accessToken = MpesaAuth.getToken();
       System.out.println("🔑 TOKEN: " + accessToken);
        String json = MpesaSTKRequest.build(phone, amount);
        System.out.println("📦 JSON REQUEST: " + json);
        String result = MpesaClient.sendStkPush(json, accessToken);
        System.out.println("📩 SAFARICOM RESPONSE: " + result);
        // DB insert here
           JSONObject res = new JSONObject(result);

String checkoutRequestId = res.optString("CheckoutRequestID");
String merchantRequestId = res.optString("MerchantRequestID");
       
            String sql = "INSERT INTO payment "
        + "(amount, payment_date, semester, user_id, payment_method, "
        + "transaction_code, status, phone, checkout_request_id, merchant_request_id) "
        + "VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?)";

PreparedStatement ps = conn.prepareStatement(sql);

ps.setDouble(1, amount);
ps.setString(2, "2026 SEM");
ps.setInt(3, userId);
ps.setString(4, "M-PESA");

ps.setString(5, "PENDING"); // transaction_code
ps.setString(6, "PENDING"); // status
ps.setString(7, phone);
ps.setString(8, checkoutRequestId);
ps.setString(9, merchantRequestId);
            

            ps.executeUpdate();
            conn.close();
             response.sendRedirect("frontend/payment.jsp?msg=check_phone");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("frontend/payment.jsp?error=fail");
        }
    }
}