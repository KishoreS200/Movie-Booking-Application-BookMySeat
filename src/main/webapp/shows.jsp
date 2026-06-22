<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.moviebooking.model.Show, java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<html>
<head>
<title>Available Shows</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">
<style>
body {
    margin: 0;
    background: radial-gradient(circle at top, #0a0a1a, #050505);
    color: white;
    font-family: 'Poppins', sans-serif;
}

.date-bar {
    padding: 20px 80px;
}

.date-btn {
    display: inline-block;
    padding: 12px 16px;
    margin-right: 10px;
    border-radius: 12px;
    background: #111;
    text-decoration: none;
    color: white;
}

.date-btn.active {
    background: linear-gradient(45deg, #7c3aed, #ec4899);
}

.section {
    padding: 20px 80px;
}

.card {
    background: linear-gradient(135deg, #0f0f1f, #151530);
    border-radius: 16px;
    padding: 20px;
    margin-bottom: 20px;
}

.theatre-title {
    font-size: 20px;
    font-weight: bold;
}

.location {
    color: #aaa;
    font-size: 13px;
}

.times {
    margin-top: 15px;
}

.time-btn {
    display: inline-block;
    padding: 10px 16px;
    margin: 5px;
    border-radius: 20px;
    background: #1a1a2e;
    color: white;
    text-decoration: none;
}

.time-btn:hover {
    background: linear-gradient(45deg, #7c3aed, #ec4899);
}

.format {
    font-size: 10px;
    margin-left: 5px;
    color: #aaa;
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<%
String selectedDate = (String) request.getAttribute("selectedDate");

SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat display = new SimpleDateFormat("EEE dd");


if (selectedDate == null) {
    selectedDate = df.format(new java.util.Date());
}
%>



<div class="date-bar">

<%
DateTimeFormatter queryFormat =
        DateTimeFormatter.ofPattern("yyyy-MM-dd");

DateTimeFormatter displayFormat =
        DateTimeFormatter.ofPattern("EEE dd");

LocalDate today = LocalDate.now();

for(int i = 0; i < 5; i++) {

    LocalDate d = today.plusDays(i);

    String dateVal =
            d.format(queryFormat);

    String label =
            d.format(displayFormat);

    String active =
            dateVal.equals(selectedDate)
            ? "active"
            : "";
%>

<a class="date-btn <%= active %>"

   href="shows?movieId=<%= request.getAttribute("movieId") %>&date=<%= dateVal %>">

    <%= label %>

</a>

<%
}
%>

</div>

<div class="section">

<%
List<Show> shows = (List<Show>) request.getAttribute("shows");
SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");

if (shows != null && !shows.isEmpty()) {

    Map<String, List<Show>> grouped = new LinkedHashMap<>();

    for (Show s : shows) {
        grouped.computeIfAbsent(s.getTheatreName(), k -> new ArrayList<>()).add(s);
    }

    for (String theatre : grouped.keySet()) {
        List<Show> theatreShows = grouped.get(theatre);
%>

<div class="card">

    <div class="theatre-title"><%= theatre %></div>
    <div class="location">📍 <%= theatreShows.get(0).getLocation() %></div>

    <div class="times">
        <% for (Show s : theatreShows) { %>

        <a class="time-btn"
           href="<%= request.getContextPath() %>/seats?showId=<%= s.getShowId() %>">

            <%= timeFormat.format(s.getShowTime()) %>
            <span class="format"><%= s.getFormat() %></span>

        </a>

        <% } %>
    </div>

</div>

<%
    }

} else {
%>

<h3 style="text-align:center;">No shows available ❌</h3>

<%
}
%>

</div>

</body>
</html>