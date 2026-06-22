package com.moviebooking.model;

import java.sql.Timestamp;

public class Show {

    private int showId;
    private int movieId;
    private int screenId;

    private Timestamp showTime;   
    private String format;        

    private String theatreName;   
    private String location;     
    private String screenName;    

    private double price;         

    // ✅ Getters & Setters

    public int getShowId() {
        return showId;
    }

    public void setShowId(int showId) {
        this.showId = showId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getScreenId() {
        return screenId;
    }

    public void setScreenId(int screenId) {
        this.screenId = screenId;
    }

    public Timestamp getShowTime() {
        return showTime;
    }

    public void setShowTime(Timestamp showTime) {
        this.showTime = showTime;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public String getTheatreName() {
        return theatreName;
    }

    public void setTheatreName(String theatreName) {
        this.theatreName = theatreName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getScreenName() {
        return screenName;
    }

    public void setScreenName(String screenName) {
        this.screenName = screenName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}