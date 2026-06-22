# 🎬 Movie Booking Web Application (BOOKMYSEAT)

A full-stack Movie Booking Web Application built using Java, JSP, Servlets, JDBC, MySQL, HTML, CSS, and JavaScript. The application allows users to browse movies, select theatres and show timings, book seats, complete payments, and manage booking history through a modern and responsive interface.

---

## 🚀 Features

### 👤 User Management
- User Registration
- User Login & Authentication
- Session Management
- Logout Functionality

### 🎥 Movie Management
- Browse Available Movies
- Movie Details Display
- Dynamic Movie Posters & Hero Slider
- Movie-wise Show Listings

### 🏢 Theatre & Show Management
- Multiple Theatres and Screens
- Dynamic Show Timings
- Date-wise Show Filtering
- Real-Time Show Availability

### 💺 Seat Booking
- Interactive Seat Selection
- Real-Time Seat Availability
- Booking Confirmation
- Prevention of Double Booking

### 💳 Payment Module
- Multiple Payment Options UI
- Booking Summary
- Payment Confirmation Flow

### 📜 Booking History
- View Previous Bookings
- Booking Status Tracking
- Booking Cancellation Support

### 📱 Responsive Design
- Mobile Friendly UI
- Responsive Layouts
- Modern Dark Theme Design

---

## 🛠️ Tech Stack

### Frontend
- HTML5
- CSS3
- JavaScript
- JSP

### Backend
- Java
- Servlets
- JDBC

### Database
- MySQL

### Server
- Apache Tomcat

### IDE
- Eclipse IDE

---

## 🏗️ Architecture

The project follows the MVC (Model-View-Controller) architecture.

### Model
- Movie.java
- Show.java
- Seat.java
- User.java

### View
- JSP Pages
- CSS
- JavaScript

### Controller
- LoginServlet
- RegisterServlet
- MovieServlet
- ShowServlet
- BookingServlet
- PaymentServlet
- ConfirmationServlet
- BookingHistoryServlet

### DAO Layer
- MovieDAO
- ShowDAO
- SeatDAO
---

## 📂 Database Tables

- users
- movies
- theatres
- screens
- shows
- seats
- bookings
- booking_seats

---

## 🔒 Security Features

- Session-Based Authentication
- PreparedStatement Usage
- Transaction Management
- Row-Level Locking for Seat Booking
- Prevention of Double Booking

---

## 🔄 Booking Workflow

1. User logs into the system.
2. Selects a movie.
3. Chooses date and theatre.
4. Selects available seats.
5. Proceeds to payment.
6. Booking is stored in the database.
7. Confirmation page is displayed.
8. Booking appears in booking history.

---

## ⚡ Key Highlights

- MVC Architecture
- DAO Design Pattern
- JDBC Integration
- Dynamic Show Scheduling
- Responsive UI
- Real-Time Seat Availability
- Transaction Handling
- Booking History Management

---

## 📸 Screens

- Login Page
- Registration Page
- Movies Page
- Show Selection Page
- Seat Selection Page
- Payment Page
- Confirmation Page
- Booking History Page

---

## 🎯 Future Enhancements

- Razorpay/Stripe Integration
- Email Ticket Generation
- QR Code Tickets
- Admin Dashboard
- Movie Search & Filters
- Recommendation System
- Live Seat Updates

---

## 👨‍💻 Author

**Kishore S**

Java Full Stack Developer

---
