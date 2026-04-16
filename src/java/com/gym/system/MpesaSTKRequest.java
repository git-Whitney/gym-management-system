/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gym.system;
import org.json.JSONObject;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

/**
 *
 * @author san
 */
public class MpesaSTKRequest {
     public static String build(String phone, int amount) {
// 🔑 CONSTANTS (MOVE TO CONFIG LATER IF NEEDED)
        String shortcode = "174379";
        String passkey = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919";

        // ⏱️ STEP 1: Generate timestamp (ALWAYS FRESH)
        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        // 🔐 STEP 2: Generate password correctly
        String password = Base64.getEncoder().encodeToString(
                (shortcode + passkey + timestamp)
                        .getBytes(StandardCharsets.UTF_8)
        );

        // 📦 STEP 3: Build JSON payload
        JSONObject json = new JSONObject();

        json.put("BusinessShortCode", shortcode);
        json.put("Password", password);
        json.put("Timestamp", timestamp);
        json.put("TransactionType", "CustomerPayBillOnline");
        json.put("Amount", amount);
        json.put("PartyA", phone);
        json.put("PartyB", shortcode);
        json.put("PhoneNumber", phone);
        json.put("CallBackURL", "https://shallow-scraggly-geiger.ngrok-free.dev/GymManagementSystem2/mpesa/callback");
        json.put("AccountReference", "Gym Payment");
        json.put("TransactionDesc", "Gym Fee");
System.out.println("Timestamp: " + timestamp);
System.out.println("Password: " + password);
        return json.toString();
    }
}