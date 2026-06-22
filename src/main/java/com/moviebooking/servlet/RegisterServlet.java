package com.moviebooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

import com.moviebooking.util.DBConnection;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        name = name != null ? name.trim() : "";
        email = email != null ? email.trim() : "";
        password = password != null ? password.trim() : "";
        phone = phone != null ? phone.trim() : "";

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            String checkQuery = "SELECT user_id FROM users WHERE email=?";
            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setString(1, email);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            String insertQuery = "INSERT INTO users (name, email, password, phone) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertQuery);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone.isEmpty() ? null : phone); 

            ps.executeUpdate();

            response.sendRedirect("login.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();

            response.sendRedirect("register.jsp?error=server");
        }
    }
}