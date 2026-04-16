package com.gym.system;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Payment> recentPayments = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM payment ORDER BY payment_date DESC LIMIT 5";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Payment p = new Payment();

                p.setPaymentId(rs.getInt("payment_id"));
                p.setAmount(rs.getDouble("amount"));
                p.setPaymentDate(rs.getString("payment_date"));
                p.setStatus(rs.getString("status"));

                recentPayments.add(p);
            }

            request.setAttribute("recentPayments", recentPayments);

            request.getRequestDispatcher("frontend/dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}