package com.moviebooking.dao;

import com.moviebooking.model.Show;
import com.moviebooking.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Collections;
import java.util.Arrays;
import java.time.LocalDate;

public class ShowDAO {

    public List<Show> getShowsByMovieAndDate(
            int movieId,
            String date) {

        List<Show> list = new ArrayList<>();

        String query =
                "SELECT s.*, t.name AS theatre_name, t.location " +
                "FROM shows s " +
                "JOIN screens sc ON s.screen_id = sc.screen_id " +
                "JOIN theatres t ON sc.theatre_id = t.theatre_id " +
                "WHERE s.movie_id = ? " +
                "AND DATE(s.show_time) = ? " +

                "AND (" +
                "DATE(s.show_time) > CURDATE() " +
                "OR TIME(s.show_time) >= CURTIME()" +
                ") " +

                "ORDER BY s.show_time";

        try (
            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query)
        ) {

            ps.setInt(1, movieId);
            ps.setString(2, date);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Show s = new Show();

                s.setShowId(
                        rs.getInt("show_id"));

                s.setMovieId(
                        rs.getInt("movie_id"));

                s.setScreenId(
                        rs.getInt("screen_id"));

                s.setShowTime(
                        rs.getTimestamp("show_time"));

                s.setFormat(
                        rs.getString("format"));

                s.setTheatreName(
                        rs.getString("theatre_name"));

                s.setLocation(
                        rs.getString("location"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Show> getShowsByMovie(int movieId) {

        List<Show> list = new ArrayList<>();

        String query =
                "SELECT s.*, t.name AS theatre_name, t.location " +
                "FROM shows s " +
                "JOIN screens sc ON s.screen_id = sc.screen_id " +
                "JOIN theatres t ON sc.theatre_id = t.theatre_id " +
                "WHERE s.movie_id = ? " +
                "ORDER BY s.show_time";

        try (
            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query)
        ) {

            ps.setInt(1, movieId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Show s = new Show();

                s.setShowId(
                        rs.getInt("show_id"));

                s.setMovieId(
                        rs.getInt("movie_id"));

                s.setScreenId(
                        rs.getInt("screen_id"));

                s.setShowTime(
                        rs.getTimestamp("show_time"));

                s.setFormat(
                        rs.getString("format"));

                s.setTheatreName(
                        rs.getString("theatre_name"));

                s.setLocation(
                        rs.getString("location"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void generateShows() {

        String[] formats = {
                "2D",
                "3D",
                "IMAX",
                "4DX"
        };

        String[] timings = {
                "11:00:00",
                "14:00:00",
                "17:00:00",
                "20:00:00"
        };

        try (
            Connection con =
                    DBConnection.getConnection()
        ) {

            Statement st =
                    con.createStatement();

            st.executeUpdate(
                    "DELETE FROM booking_seats");

            st.executeUpdate(
                    "DELETE FROM bookings");

            st.executeUpdate(
                    "DELETE FROM shows");

            PreparedStatement moviePs =
                    con.prepareStatement(
                            "SELECT movie_id FROM movies"
                    );

            ResultSet movieRs =
                    moviePs.executeQuery();

            PreparedStatement screenPs =
                    con.prepareStatement(
                            "SELECT DISTINCT screen_id FROM seats"
                    );

            ResultSet screenRs =
                    screenPs.executeQuery();

            List<Integer> screens =
                    new ArrayList<>();

            while (screenRs.next()) {

                screens.add(
                        screenRs.getInt("screen_id")
                );
            }

            Random random =
                    new Random();

            while (movieRs.next()) {

                int movieId =
                        movieRs.getInt("movie_id");

                for (int d = 0; d < 5; d++) {

                    LocalDate date =
                            LocalDate.now()
                                    .plusDays(d);

                
                    Collections.shuffle(screens);

                    int theatreCount =
                            Math.min(
                                    3 + random.nextInt(2),
                                    screens.size()
                            );

                    for (int t = 0;
                         t < theatreCount;
                         t++) {

                        int screenId =
                                screens.get(t);

                
                        List<String> showTimes =
                                new ArrayList<>(
                                        Arrays.asList(
                                                timings
                                        )
                                );

                        Collections.shuffle(showTimes);

                        int showsPerTheatre =
                                2 + random.nextInt(2);

                        for (int s = 0;
                             s < showsPerTheatre;
                             s++) {

                            String showDateTime =
                                    date + " " +
                                    showTimes.get(s);

                            PreparedStatement insert =
                                    con.prepareStatement(

                                    "INSERT INTO shows " +
                                    "(movie_id, screen_id, show_time, format) " +
                                    "VALUES (?, ?, ?, ?)"
                            );

                            insert.setInt(
                                    1,
                                    movieId
                            );

                            insert.setInt(
                                    2,
                                    screenId
                            );

                            insert.setTimestamp(
                                    3,
                                    Timestamp.valueOf(
                                            showDateTime
                                    )
                            );

                            insert.setString(
                                    4,
                                    formats[
                                            random.nextInt(
                                                    formats.length
                                            )
                                    ]
                            );

                            insert.executeUpdate();
                        }
                    }
                }
            }

            System.out.println(
                    "✅ Dynamic shows generated"
            );

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    public int getTotalShows() {

        int count = 0;

        String query =
                "SELECT COUNT(*) FROM shows";

        try (
            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query)
        ) {

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                count =
                        rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }
}