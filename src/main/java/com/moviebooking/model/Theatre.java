package com.moviebooking.model;

public class Theatre {

    private int theatreId;
    private String name;
    private String location;     
    private double rating;       

    private int totalScreens;    

    private String distance;     
    private boolean hasIMAX;
    private boolean hasDolby;
    private boolean hasRecliner;


    public int getTheatreId() {
        return theatreId;
    }

    public void setTheatreId(int theatreId) {
        this.theatreId = theatreId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public int getTotalScreens() {
        return totalScreens;
    }

    public void setTotalScreens(int totalScreens) {
        this.totalScreens = totalScreens;
    }

    public String getDistance() {
        return distance;
    }

    public void setDistance(String distance) {
        this.distance = distance;
    }

    public boolean isHasIMAX() {
        return hasIMAX;
    }

    public void setHasIMAX(boolean hasIMAX) {
        this.hasIMAX = hasIMAX;
    }

    public boolean isHasDolby() {
        return hasDolby;
    }

    public void setHasDolby(boolean hasDolby) {
        this.hasDolby = hasDolby;
    }

    public boolean isHasRecliner() {
        return hasRecliner;
    }

    public void setHasRecliner(boolean hasRecliner) {
        this.hasRecliner = hasRecliner;
    }
}