package com.moviebooking.servlet;

import com.moviebooking.dao.ShowDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet(
    urlPatterns = "/init",
    loadOnStartup = 1
)
public class StartupServlet extends HttpServlet {

    @Override
    public void init() {

        try {

            ShowDAO dao = new ShowDAO();

            if (dao.getTotalShows() == 0) {

                dao.generateShows();

                System.out.println(
                    "✅ Shows generated"
                );

            } else {

                System.out.println(
                    "✅ Shows already exist"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}