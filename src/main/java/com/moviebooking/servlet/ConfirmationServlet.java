package com.moviebooking.servlet;

import com.moviebooking.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;

@WebServlet("/confirmation")
public class ConfirmationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        String movie = "";
        String theatre = "";
        String time = "";
        String seats = "";
        String status = "";
        double totalAmount = 0;

        String query =
                "SELECT m.title, t.name AS theatre, s.show_time, b.total_amount, b.status, " +
                "GROUP_CONCAT(se.seat_number ORDER BY se.seat_number) AS seats " +
                "FROM bookings b " +
                "JOIN shows s ON b.show_id = s.show_id " +
                "JOIN movies m ON s.movie_id = m.movie_id " +
                "JOIN screens sc ON s.screen_id = sc.screen_id " +
                "JOIN theatres t ON sc.theatre_id = t.theatre_id " +
                "JOIN booking_seats bs ON b.booking_id = bs.booking_id " +
                "JOIN seats se ON bs.seat_id = se.seat_id " +
                "WHERE b.booking_id = ? " +
                "GROUP BY b.booking_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, bookingId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                movie = rs.getString("title");
                theatre = rs.getString("theatre");

                Timestamp ts = rs.getTimestamp("show_time");
                if (ts != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
                    time = sdf.format(ts);
                }

                totalAmount = rs.getDouble("total_amount");
                status = rs.getString("status");
                seats = rs.getString("seats");

            } else {
                response.getWriter().write("Invalid Booking ❌");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookingId", bookingId);
        request.setAttribute("movie", movie);
        request.setAttribute("theatre", theatre);
        request.setAttribute("time", time);
        request.setAttribute("seats", seats);
        request.setAttribute("totalAmount", "₹" + totalAmount);
        request.setAttribute("status", status);

        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
    }
}