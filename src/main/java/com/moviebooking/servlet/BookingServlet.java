package com.moviebooking.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;

import com.moviebooking.util.DBConnection;

@WebServlet("/bookSeats")
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int showId = Integer.parseInt(request.getParameter("showId"));
        String seats = request.getParameter("seats"); // "1,2,3"

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.getWriter().write("Please login first ❌");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); 

            String[] seatArray = seats.split(",");

           
            String seatIds = seats;

            String lockQuery = "SELECT seat_id, price FROM seats " +
                               "WHERE seat_id IN (" + seatIds + ") FOR UPDATE";

            PreparedStatement lockPs = con.prepareStatement(lockQuery);
            ResultSet lockRs = lockPs.executeQuery();

            double baseAmount = 0;

            int count = 0;
            while (lockRs.next()) {
            	baseAmount += lockRs.getDouble("price");
                count++;
            }
           
            if (count != seatArray.length) {
                con.rollback();
                response.getWriter().write("Invalid seats ❌");
                return;
            }
            double fee = 20;
            double totalAmount = baseAmount + fee;

            String checkQuery = "SELECT bs.seat_id FROM booking_seats bs " +
                                "JOIN bookings b ON bs.booking_id = b.booking_id " +
                                "WHERE b.show_id = ? AND bs.seat_id IN (" + seatIds + ")";

            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setInt(1, showId);

            ResultSet checkRs = checkPs.executeQuery();

            if (checkRs.next()) {
                con.rollback();
                response.getWriter().write("Seats already booked ❌");
                return;
            }

            String bookingQuery =
                    "INSERT INTO bookings (user_id, show_id, total_amount, status) VALUES (?, ?, ?, ?)";

            PreparedStatement bookingPs =
                    con.prepareStatement(bookingQuery, Statement.RETURN_GENERATED_KEYS);

            bookingPs.setInt(1, userId);
            bookingPs.setInt(2, showId);
            bookingPs.setDouble(3, totalAmount);
            bookingPs.setString(4, "CONFIRMED");

            bookingPs.executeUpdate();

            ResultSet keyRs = bookingPs.getGeneratedKeys();
            int bookingId = 0;

            if (keyRs.next()) {
                bookingId = keyRs.getInt(1);
            }

            String insertSeats = "INSERT INTO booking_seats (booking_id, seat_id) VALUES (?, ?)";
            PreparedStatement seatPs = con.prepareStatement(insertSeats);

            for (String s : seatArray) {
                seatPs.setInt(1, bookingId);
                seatPs.setInt(2, Integer.parseInt(s));
                seatPs.addBatch();
            }

            seatPs.executeBatch();

            con.commit();

            response.getWriter().write("SUCCESS|" + bookingId);

        } catch (Exception e) {

            try {
                if (con != null) con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
            response.getWriter().write("FAILED ❌");

        } finally {
            try {
                if (con != null) con.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}