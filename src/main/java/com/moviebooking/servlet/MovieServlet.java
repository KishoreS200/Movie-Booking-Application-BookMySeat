package com.moviebooking.servlet;

import java.io.IOException;
import java.util.List;

import com.moviebooking.dao.MovieDAO;
import com.moviebooking.model.Movie;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String language = request.getParameter("language");

        MovieDAO dao = new MovieDAO();
        List<Movie> movies = null;

        try {
            if (language != null && !language.trim().isEmpty()) {
                movies = dao.getMoviesByLanguage(language.trim());
            } else {
                movies = dao.getAllMovies();
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load movies ❌");
        }

        request.setAttribute("movieList", movies);

        RequestDispatcher rd = request.getRequestDispatcher("movies.jsp");
        rd.forward(request, response);
    }
}