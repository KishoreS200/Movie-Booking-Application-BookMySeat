package com.moviebooking.servlet;

import com.moviebooking.util.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/history")
public class BookingHistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        List<Map<String, String>> history = new ArrayList<>();

        String query =
        	    "SELECT b.booking_id, " +
        	    "m.title, " +
        	    "m.poster_url, " +
        	    "t.name AS theatre, " +
        	    "s.show_time, " +

        	    "GROUP_CONCAT(se.seat_number ORDER BY se.seat_number SEPARATOR ', ') AS seats, " +

        	    "b.total_amount, b.status " +

        	    "FROM bookings b " +

        	    "LEFT JOIN shows s ON b.show_id = s.show_id " +
        	    "LEFT JOIN movies m ON s.movie_id = m.movie_id " +
        	    "LEFT JOIN screens sc ON s.screen_id = sc.screen_id " +
        	    "LEFT JOIN theatres t ON sc.theatre_id = t.theatre_id " +

        	    "LEFT JOIN booking_seats bs ON b.booking_id = bs.booking_id " +
        	    "LEFT JOIN seats se ON bs.seat_id = se.seat_id " +

        	    "WHERE b.user_id = ? " +

        	    "GROUP BY b.booking_id " +

        	    "ORDER BY b.booking_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, String> map = new HashMap<>();

                // ✅ bookingId SAFE
                String bookingId = rs.getString("booking_id");
                if (bookingId != null) {
                    map.put("bookingId", bookingId);
                }

                map.put("movie", rs.getString("title"));
                map.put("poster", rs.getString("poster_url"));
                map.put("theatre", rs.getString("theatre"));

            
                Timestamp ts = rs.getTimestamp("show_time");
                if (ts != null) {
                    map.put("time", new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a").format(ts));
                } else {
                    map.put("time", "N/A");
                }

                map.put("seats", rs.getString("seats"));
                map.put("amount", rs.getString("total_amount"));

                String status = rs.getString("status");
                map.put("status", status != null ? status : "CONFIRMED");

                history.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("history", history);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}