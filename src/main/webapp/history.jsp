<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<html>
<head>
<title>My Bookings</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">
<style>


body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: radial-gradient(circle at top, #0a0a1a, #050505);
    color: white;
}

.header {
    padding: 40px 80px 20px;
}

.title {
    font-size: 40px;
    font-weight: bold;
}

.subtitle {
    color: #aaa;
    margin-top: 5px;
}

.list {
    padding: 20px 80px 60px;
}
.card {
    display: flex;
    align-items: center;

    background:
        linear-gradient(145deg, #0f0f1f, #151530);

    padding: 22px;

    border-radius: 22px;

    margin-bottom: 24px;

    transition: 0.3s;

    border:
        1px solid rgba(124,58,237,0.16);

    backdrop-filter: blur(10px);

    position: relative;

    overflow: hidden;
}


.card::before {
    content: "";

    position: absolute;
    inset: 0;

    background:
        linear-gradient(
            135deg,
            rgba(124,58,237,0.08),
            rgba(236,72,153,0.05)
        );

    pointer-events: none;
}

.card:hover {
    transform:
        translateY(-6px)
        scale(1.01);

    box-shadow:
        0 0 30px rgba(124,58,237,0.28);
}


.poster {
    width: 95px;
    height: 135px;

    border-radius: 14px;

    object-fit: cover;

    margin-right: 24px;

    box-shadow:
        0 6px 18px rgba(0,0,0,0.35);
}

.info {
    flex: 1;
}

.movie {
    font-size: 24px;
    font-weight: 700;

    margin-bottom: 6px;
}

.meta {
    color: #aaa;
    font-size: 13px;
    margin-top: 5px;
}

.seats {
    margin-top: 8px;
    font-size: 14px;
}

.badge {
    padding: 7px 14px;

    border-radius: 30px;

    font-size: 12px;

    font-weight: 600;

    letter-spacing: 0.5px;
}

.upcoming {
    background: #4c1d95;
    color: #c4b5fd;
}

.completed {
    background: #1f2937;
    color: #9ca3af;
}

.cancelled {
    background: #7f1d1d;
    color: #ef4444;
}


.right {
    text-align: right;
}

.cancel-btn {
    margin-top: 10px;
    padding: 8px 12px;
    border-radius: 8px;
    border: none;
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
    cursor: pointer;
}

.cancel-btn:hover {
    transform: scale(1.05);
}


.empty {
    text-align: center;
    margin-top: 50px;
    font-size: 18px;
}

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="header">
    <div class="title">MY BOOKINGS</div>
    <div class="subtitle">Archive & Active Tickets</div>
</div>

<div class="list">

<%
List<Map<String, String>> history = (List<Map<String, String>>) request.getAttribute("history");

if (history != null && !history.isEmpty()) {

    for (Map<String, String> h : history) {

        String status = h.get("status") != null ? h.get("status") : "CONFIRMED";

        String badgeClass = "upcoming";
        if ("CANCELLED".equals(status)) badgeClass = "cancelled";
        else if ("COMPLETED".equals(status)) badgeClass = "completed";
%>

<div class="card">

   <img class="poster"

     src="<%= request.getContextPath() + "/" + h.get("poster") %>"

     onerror="this.src='https://via.placeholder.com/300x450?text=No+Image'">

    <div class="info">

        <div class="movie"><%= h.get("movie") %></div>

        <div class="meta">📅 <%= h.get("time") %></div>
        <div class="meta">🏢 <%= h.get("theatre") %></div>

        <div class="seats">
            💺 <%= h.get("seats") %>
        </div>

    </div>

    <div class="right">

        <div class="badge <%= badgeClass %>">
            <%= status %>
        </div>

        <div style="margin-top:10px; font-weight:bold;">
            ₹ <%= h.get("amount") %>
        </div>

        <% if (!"CANCELLED".equals(status)) { %>
        <form method="post" action="cancelBooking">
            
            <input type="hidden" name="bookingId"
       value="<%= h.get("bookingId") != null ? h.get("bookingId") : h.get("booking_id") %>">

            <button class="cancel-btn">Cancel</button>
        </form>
        <% } %>

    </div>

</div>

<%
    }

} else {
%>

<div class="empty">No bookings found ❌</div>

<%
}
%>

</div>

</body>
</html>