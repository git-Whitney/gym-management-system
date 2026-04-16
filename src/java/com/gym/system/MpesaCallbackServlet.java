/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gym.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import org.json.JSONObject;
import java.io.BufferedReader;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author san
 */
@WebServlet("/mpesa/callback")
public class MpesaCallbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("🔥 CALLBACK RECEIVED FROM M-PESA");

        StringBuilder responseData = new StringBuilder();
        String line;

        BufferedReader reader = request.getReader();

        // ✅ STEP 1: READ JSON FIRST
        while ((line = reader.readLine()) != null) {
            responseData.append(line);
        }

        System.out.println("📩 RAW CALLBACK: " + responseData.toString());

        try {
            // ✅ STEP 2: PARSE JSON
            JSONObject json = new JSONObject(responseData.toString());

            JSONObject stkCallback = json
                    .getJSONObject("Body")
                    .getJSONObject("stkCallback");

            int resultCode = stkCallback.getInt("ResultCode");
            String resultDesc = stkCallback.getString("ResultDesc");
            String checkoutRequestId = stkCallback.getString("CheckoutRequestID");

            String status = (resultCode == 0) ? "SUCCESS" : "FAILED";

            String receipt = null;
            double amount = 0;
            String phone = null;

            // ✅ STEP 3: EXTRACT METADATA (ONLY IF SUCCESS)
            if (resultCode == 0) {

                JSONObject metadata = stkCallback.getJSONObject("CallbackMetadata");
                var items = metadata.getJSONArray("Item");

                for (int i = 0; i < items.length(); i++) {

                    JSONObject item = items.getJSONObject(i);
                    String name = item.getString("Name");

                    switch (name) {
                        case "Amount":
                            amount = item.getDouble("Value");
                            break;

                        case "MpesaReceiptNumber":
                            receipt = item.getString("Value");
                            break;

                        case "PhoneNumber":
                            phone = item.get("Value").toString();
                            break;
                    }
                }
            }

            // ✅ STEP 4: UPDATE DATABASE
            Connection conn = DBConnection.getConnection();

            String sql = "UPDATE payment SET "
                    + "amount = ?, "
                    + "status = ?, "
                    + "transaction_code = ?, "
                    + "result_code = ?, "
                    + "result_desc = ? "
                    + "WHERE checkout_request_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, status);
            ps.setString(3, receipt);
            ps.setInt(4, resultCode);
            ps.setString(5, resultDesc);
            ps.setString(6, checkoutRequestId);

            int updated = ps.executeUpdate();

            System.out.println("💾 Payment updated: " + updated);

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ STEP 5: RESPOND TO SAFARICOM
        response.setStatus(HttpServletResponse.SC_OK);
    }
}