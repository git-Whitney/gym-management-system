/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gym.system;
import org.json.JSONObject;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Scanner;
import java.io.InputStream;
public class MpesaAuth {
   public static String getToken() {
        try {
            String consumerKey = "DI5Xgz2bdXAGnAL5P0TG3ZfnmoBhwek8yS1vg2sp04cZ88W2";
            String consumerSecret = "aqPeIGaGTyPGmT2Y2U2ixSZdvGgP04ajS7DmbQcEetyeXrHjUyZvOmYvX5xHmCNz";

            String auth = consumerKey + ":" + consumerSecret;

            // 🔥 Encode to Base64
            String encodedAuth = java.util.Base64.getEncoder().encodeToString(auth.getBytes());

            URL url = new URL("https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials");

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Basic " + encodedAuth);

            int responseCode = conn.getResponseCode();
            System.out.println("🔐 TOKEN RESPONSE CODE: " + responseCode);

            java.io.InputStream is = conn.getInputStream();
            java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\A");
            String response = s.hasNext() ? s.next() : "";

            System.out.println("🔐 TOKEN RESPONSE: " + response);

            
            // 🔥 CLEAN RESPONSE
            response = response.replaceAll("\\s+", "");

            // 🔥 EXTRACT TOKEN
            String token = response.split("\"access_token\":\"")[1].split("\"")[0];

            token = token.trim();

            System.out.println("🔑 CLEAN TOKEN: [" + token + "]");
            System.out.println("TOKEN LENGTH: " + token.length());

            return token;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
