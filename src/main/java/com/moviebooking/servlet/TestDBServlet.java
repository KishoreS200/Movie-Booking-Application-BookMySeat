package com.moviebooking.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import com.moviebooking.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        long startTime = System.currentTimeMillis();

        try (Connection conn = DBConnection.getConnection()) {

            long endTime = System.currentTimeMillis();
            long timeTaken = endTime - startTime;

            out.println("<html><head><title>DB Test</title></head><body style='font-family:Arial;'>");

            if (conn != null) {
                out.println("<h2 style='color:green;'>✅ Database Connected Successfully</h2>");
                out.println("<p>⏱ Connection Time: " + timeTaken + " ms</p>");
            } else {
                out.println("<h2 style='color:red;'>❌ Database Connection Failed</h2>");
            }

            out.println("</body></html>");

        } catch (Exception e) {

            out.println("<html><body style='font-family:Arial;'>");
            out.println("<h2 style='color:red;'>❌ Error Connecting to Database</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            out.println("</body></html>");
        }
    }
}