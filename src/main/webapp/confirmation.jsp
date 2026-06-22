<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Booking Confirmation</title>

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

.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
}

.icon {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    border: 3px solid #7c3aed;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40px;
    margin-bottom: 15px;
    box-shadow: 0 0 25px rgba(124,58,237,0.6);
}

.title {
    font-size: 20px;
    margin-bottom: 5px;
}

.subtitle {
    color: #aaa;
    font-size: 14px;
    margin-bottom: 25px;
}

.ticket {
    width: 350px;
    background: linear-gradient(135deg, #0f0f1f, #151530);
    border-radius: 18px;
    padding: 20px;
    box-shadow: 0 0 25px rgba(124,58,237,0.2);
}

.movie {
    font-weight: bold;
    margin-bottom: 15px;
}

.row {
    display: flex;
    justify-content: space-between;
    margin: 8px 0;
    font-size: 14px;
}

.label {
    color: #888;
}

.seats {
    margin-top: 10px;
}

.tag {
    background: #1a1a2e;
    padding: 6px 10px;
    border-radius: 8px;
    margin: 4px;
    display: inline-block;
}

.divider {
    border-top: 1px dashed #444;
    margin: 15px 0;
}

.btn {
    width: 300px;
    padding: 14px;
    border-radius: 12px;
    text-align: center;
    margin-top: 20px;
    text-decoration: none;
    display: block;
    font-weight: bold;
}

.primary {
    background: linear-gradient(45deg, #7c3aed, #ec4899);
}

.secondary {
    border: 1px solid #555;
    color: white;
}

.btn:hover {
    transform: scale(1.05);
}
</style>

</head>

<body>

<%@ include file="header.jsp" %>

<div class="container">

```
<div class="icon">✔</div>

<div class="title">BOOKING CONFIRMED</div>
<div class="subtitle">Your ticket has been successfully booked</div>

<div class="ticket">

    <div class="movie">${movie}</div>

    <div class="row">
        <span class="label">Date</span>
        <span>${date}</span>
    </div>

    <div class="row">
        <span class="label">Time</span>
        <span>${time}</span>
    </div>

    <div class="row">
        <span class="label">Theatre</span>
        <span>${theatre}</span>
    </div>

    <div class="row">
        <span class="label">Seats</span>
    </div>

    <div class="seats">
    <%
        String seatsStr = (String) request.getAttribute("seats");

        if (seatsStr != null && !seatsStr.isEmpty()) {
            String[] arr = seatsStr.split(",");

            for (String s : arr) {
    %>
        <span class="tag"><%= s.trim() %></span>
    <%
            }
        } else {
    %>
        <span class="tag">N/A</span>
    <%
        }
    %>
    </div>

    <div class="divider"></div>

    <div class="row">
        <span class="label">Amount</span>
        <span>
            <%= (request.getAttribute("totalAmount") != null)
                    ? request.getAttribute("totalAmount")
                    : (request.getParameter("amount") != null
                        ? request.getParameter("amount")
                        : "0") %>
        </span>
    </div>

</div>

<a href="history" class="btn primary">🎟 View Tickets</a>
<a href="movies" class="btn secondary">🏠 Back to Home</a>
```

</div>

</body>
</html>
