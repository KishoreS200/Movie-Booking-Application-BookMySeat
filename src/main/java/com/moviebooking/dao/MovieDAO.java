package com.moviebooking.dao;

import java.sql.*;
import java.util.*;
import java.sql.Date;

import com.moviebooking.model.Movie;
import com.moviebooking.util.DBConnection;

public class MovieDAO {

    private Movie mapMovie(ResultSet rs) throws SQLException {
        Movie m = new Movie();

        m.setMovieId(rs.getInt("movie_id"));
        m.setTitle(rs.getString("title"));
        m.setLanguage(rs.getString("language"));
        m.setGenre(rs.getString("genre"));
        m.setDuration(rs.getInt("duration"));

        m.setRating(rs.getDouble("rating"));
        m.setDescription(rs.getString("description"));
        m.setPosterUrl(rs.getString("poster_url"));
        m.setBannerUrl(rs.getString("banner_url"));

        Date sqlDate = rs.getDate("release_date");
        if (sqlDate != null) {
            m.setReleaseDate(new java.util.Date(sqlDate.getTime()));
        }

        return m;
    }

    public List<Movie> getAllMovies() {

        List<Movie> list = new ArrayList<>();

        String query = "SELECT * FROM movies ORDER BY release_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapMovie(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

 
    public List<Movie> getMoviesByLanguage(String language) {

        List<Movie> list = new ArrayList<>();

        String query = "SELECT * FROM movies WHERE language = ? ORDER BY release_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, language);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapMovie(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Movie getMovieById(int movieId) {

        String query = "SELECT * FROM movies WHERE movie_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, movieId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapMovie(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}