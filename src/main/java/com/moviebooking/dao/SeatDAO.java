package com.moviebooking.dao;

import com.moviebooking.model.Seat;
import com.moviebooking.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO {

    public List<Seat> getSeatsByShow(int showId, int screenId) {

        List<Seat> list = new ArrayList<>();

        String query =

        	    "SELECT s.*, " +

        	    "CASE " +
        	    "   WHEN EXISTS ( " +
        	    "       SELECT 1 " +
        	    "       FROM booking_seats bs " +
        	    "       JOIN bookings b " +
        	    "           ON bs.booking_id = b.booking_id " +
        	    "       WHERE bs.seat_id = s.seat_id " +
        	    "       AND b.show_id = ? " +
        	    "   ) " +
        	    "   THEN 'BOOKED' " +
        	    "   ELSE 'AVAILABLE' " +
        	    "END AS booking_status " +

        	    "FROM seats s " +

        	    "WHERE s.screen_id = ? " +

        	    "ORDER BY s.seat_id";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, showId);
            ps.setInt(2, screenId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Seat s = new Seat();

                  
                    s.setSeatId(rs.getInt("seat_id"));
                    s.setSeatNumber(rs.getString("seat_number"));
                    s.setScreenId(rs.getInt("screen_id"));

                    String type = rs.getString("type");
                    s.setType(type != null ? type : "SILVER");

                    String status = rs.getString("booking_status");
                    s.setStatus(status != null ? status : "AVAILABLE");

                    s.setPrice(rs.getDouble("price"));

                    list.add(s);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}