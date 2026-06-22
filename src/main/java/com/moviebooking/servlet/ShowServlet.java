package com.moviebooking.servlet;

import com.moviebooking.dao.ShowDAO;
import com.moviebooking.model.Show;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/shows")
public class ShowServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        String movieParam =
                request.getParameter("movieId");

        if (movieParam == null ||
            movieParam.isEmpty()) {

            response.sendRedirect("movies");
            return;
        }

        int movieId =
                Integer.parseInt(movieParam);

       
        String dateParam =
                request.getParameter("date");

        if (dateParam == null ||
            dateParam.isEmpty()) {

            dateParam =
                new SimpleDateFormat("yyyy-MM-dd")
                        .format(new Date());
        }

        ShowDAO dao = new ShowDAO();

  
        List<Show> shows =
                dao.getShowsByMovieAndDate(
                        movieId,
                        dateParam
                );


        List<Show> allShows =
                dao.getShowsByMovie(movieId);

        request.setAttribute("shows", shows);

        request.setAttribute(
                "allShows",
                allShows
        );

        request.setAttribute(
                "movieId",
                movieId
        );

        request.setAttribute(
                "selectedDate",
                dateParam
        );

        request.getRequestDispatcher("shows.jsp")
                .forward(request, response);
    }
}