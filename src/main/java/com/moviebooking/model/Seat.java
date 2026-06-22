package com.moviebooking.model;

public class Seat {

    private int seatId;
    private String seatNumber;
    private String type;     
    private String status;   
    private int screenId;
    private double price;

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getSeatId() { return seatId; }
    public void setSeatId(int seatId) { this.seatId = seatId; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getScreenId() { return screenId; }
    public void setScreenId(int screenId) { this.screenId = screenId; }
}