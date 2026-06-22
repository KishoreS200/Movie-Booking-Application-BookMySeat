package com.moviebooking.servlet;

import com.moviebooking.util.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); 

            String checkQuery = "SELECT * FROM bookings WHERE booking_id=? AND user_id=?";
            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setInt(1, bookingId);
            checkPs.setInt(2, userId);

            ResultSet rs = checkPs.executeQuery();

            if (!rs.next()) {
                con.rollback();
                response.getWriter().write("Unauthorized ❌");
                return;
            }

            String updateQuery = "UPDATE bookings SET status='CANCELLED' WHERE booking_id=?";
            PreparedStatement ps = con.prepareStatement(updateQuery);
            ps.setInt(1, bookingId);
            ps.executeUpdate();

            con.commit();

            response.sendRedirect("history");

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