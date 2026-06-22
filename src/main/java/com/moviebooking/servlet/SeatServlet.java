package com.moviebooking.servlet;

import com.moviebooking.dao.SeatDAO;
import com.moviebooking.model.Seat;
import com.moviebooking.util.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/seats")
public class SeatServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String showParam = request.getParameter("showId");

        if (showParam == null || showParam.isEmpty()) {
            response.sendRedirect("movies");
            return;
        }

        int showId = 0;

        try {
            showId = Integer.parseInt(showParam);
        } catch (Exception e) {
            response.getWriter().write("Invalid show ID ❌");
            return;
        }

        int screenId = 0;

        try (Connection con = DBConnection.getConnection()) {

            String query = "SELECT screen_id FROM shows WHERE show_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, showId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                screenId = rs.getInt("screen_id");
            } else {
                response.getWriter().write("Invalid show ❌");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("DB Error ❌");
            return;
        }

        SeatDAO dao = new SeatDAO();
        List<Seat> seats = dao.getSeatsByShow(showId,screenId);

        System.out.println("Screen ID: " + screenId);
        System.out.println("Seats loaded: " + seats.size());

        request.setAttribute("seats", seats);
        request.setAttribute("showId", showId);

        request.getRequestDispatcher("seats.jsp").forward(request, response);
    }
}