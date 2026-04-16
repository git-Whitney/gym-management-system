package com.gym.system;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class MpesaClient {

    public static String sendStkPush(String json, String accessToken) {
        try {
            URL url = new URL("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest");

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            System.out.println("🚀 USING TOKEN: [" + accessToken + "]");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            OutputStream os = conn.getOutputStream();
            os.write(json.getBytes("UTF-8"));
            os.flush();
            os.close();

            int responseCode = conn.getResponseCode();
            System.out.println("STK Push Response Code: " + responseCode);
            //read response code
            java.io.InputStream is;
            if (responseCode >= 200 && responseCode < 300) {
            is = conn.getInputStream(); // success
        } else {
            is = conn.getErrorStream(); // error
        }

        java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\A");
        String response = s.hasNext() ? s.next() : "";

        System.out.println("📩 FULL RESPONSE: " + response);

        return response;
            

        } catch (Exception e) {
            e.printStackTrace();
            return "Error" + e.getMessage();
        }
    }
}