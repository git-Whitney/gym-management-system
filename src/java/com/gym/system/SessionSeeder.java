package com.gym.system;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;

public class SessionSeeder {

    public static void main(String[] args) {

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO gymsession (session_date, session_time, max_capacity, booked_count) VALUES (?, ?, 20, 0)";
            PreparedStatement ps = conn.prepareStatement(sql);

            LocalDate today = LocalDate.now();

            for (int hour = 6; hour < 22; hour++) {
                ps.setDate(1, java.sql.Date.valueOf(today));
                ps.setTime(2, java.sql.Time.valueOf(String.format("%02d:00:00", hour)));

                ps.executeUpdate();
            }

            System.out.println("Sessions created successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
