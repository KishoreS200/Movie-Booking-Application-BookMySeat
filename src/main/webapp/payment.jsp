<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.moviebooking.util.DBConnection" %>
<html>
<head>
<title>Payment</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">
<style>

body {
    margin: 0;
    background: radial-gradient(circle at top, #0a0a1a, #050505);
    font-family: 'Poppins', sans-serif;
    color: white;
}

.container{
    display:flex;
    gap:40px;

    padding:50px 80px;

    align-items:stretch;
}

.left{
    flex:2;

    background:linear-gradient(135deg,#0f0f1f,#151530);

    padding:40px;

    border-radius:24px;

    border:1px solid rgba(124,58,237,0.2);

    display:flex;
    flex-direction:column;
    justify-content:center;
}

.right{
    flex:1;

    display:flex;
}


.title {
    font-size: 32px;
    margin-bottom: 10px;
}

.subtitle {
    color: #aaa;
    margin-bottom: 30px;
}


.grid{
    display:flex;
    flex-direction:column;
    gap:18px;

    margin-top:30px;
}


.card{
    background:linear-gradient(135deg,#111122,#18183a);

    padding:22px 25px;

    border-radius:18px;

    cursor:pointer;

    transition:0.3s;

    border:1px solid rgba(255,255,255,0.05);

    display:flex;
    align-items:center;
    justify-content:space-between;
}

.card:hover{
    transform:translateY(-3px);

    border-color:#7c3aed;
}

.card.active{
    border:2px solid #7c3aed;

    box-shadow:
    0 0 25px rgba(124,58,237,0.25);
}


.card-title {
    font-size: 14px;
    margin-bottom: 10px;
    color: #aaa;
}


.pay-btn {
    width: 100%;
    margin-top: 30px;
    padding: 14px;
    border-radius: 12px;
    border: none;
    background: linear-gradient(45deg, #7c3aed, #ec4899);
    color: white;
    font-weight: bold;
    cursor: pointer;
}

.pay-btn:hover {
    transform: scale(1.05);
}


.summary{
    background:linear-gradient(135deg,#0f0f1f,#151530);

    padding:20px;

    border-radius:24px;

    width:100%;

    border:1px solid rgba(124,58,237,0.2);

    display:flex;
    flex-direction:column;
}

.poster{
    width:100%;
    height:420px;

    object-fit:cover;

    border-radius:16px;

    margin-bottom:20px;
}


.row {
    display: flex;
    justify-content: space-between;
    margin: 10px 0;
    color: #aaa;
}


.total {
    font-size: 20px;
    font-weight: bold;
    color: #ec4899;
}

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<%
String showId = request.getParameter("showId");
String seats = request.getParameter("seats");
String amountStr = request.getParameter("amount");

double amount = 0;
try {
    amount = amountStr != null ? Double.parseDouble(amountStr) : 0;
} catch(Exception e) {}
%>

<div class="container">

<div class="left">

    <div class="title">Payment Methods</div>
    <div class="subtitle">Securely finalize your booking.</div>

    <div class="grid">

    <div class="card active"
         onclick="selectMethod(this, 'CARD')">

        <div class="card-left">

            <div class="card-title">
                CREDIT / DEBIT CARD
            </div>

            <div class="card-text">
                💳 Card Payment
            </div>

        </div>

        <div class="arrow">›</div>

    </div>

    <div class="card"
         onclick="selectMethod(this, 'UPI')">

        <div class="card-left">

            <div class="card-title">
                UPI / WALLET
            </div>

            <div class="card-text">
                📱 GPay / PhonePe
            </div>

        </div>

        <div class="arrow">›</div>

    </div>

    <div class="card"
         onclick="selectMethod(this, 'APPLE')">

        <div class="card-left">

            <div class="card-title">
                APPLE PAY
            </div>

            <div class="card-text">
                🍎 Apple Pay
            </div>

        </div>

        <div class="arrow">›</div>

    </div>

    <div class="card"
         onclick="selectMethod(this, 'NETBANKING')">

        <div class="card-left">

            <div class="card-title">
                NET BANKING
            </div>

            <div class="card-text">
                🏦 Bank Transfer
            </div>

        </div>

        <div class="arrow">›</div>

    </div>

</div>

    <button class="pay-btn" onclick="payNow()">PAY NOW</button>

</div>

<!-- RIGHT -->
<div class="right">

    <div class="summary">

        <%

String movieTitle = "Movie";
String poster = "https://via.placeholder.com/300x450";

try{

    Connection con =
        DBConnection.getConnection();

    String q =
        "SELECT m.title, m.poster_url " +
        "FROM shows s " +
        "JOIN movies m " +
        "ON s.movie_id = m.movie_id " +
        "WHERE s.show_id=?";

    PreparedStatement ps =
        con.prepareStatement(q);

    ps.setInt(1,
        Integer.parseInt(showId));

    ResultSet rs =
        ps.executeQuery();

    if(rs.next()){

        movieTitle =
            rs.getString("title");

        poster =
            request.getContextPath()
            + "/"
            + rs.getString("poster_url");
    }

}catch(Exception e){
    e.printStackTrace();
}

%>

<img class="poster"
     src="<%= poster %>">

<div><b>Now Booking</b></div>

<h3><%= movieTitle %></h3>

        <div class="row">
            <span>Date & Time</span>
            <span>Today</span>
        </div>

        <div class="row">
            <span>Seats</span>
            <span><%= seats %></span>
        </div>

        <hr style="border-color:#333; margin:15px 0;">

        <div class="row">
            <span>Subtotal</span>
            <span>₹<%= amount %></span>
        </div>

        <div class="row">
            <span>Fee</span>
            <span>₹20</span>
        </div>

        <div class="row total">
            <span>Total</span>
            <span>₹<%= amount + 20 %></span>
        </div>

    </div>

</div>

</div>

<script>

let selectedMethod = "CARD";

function selectMethod(el, method) {
    document.querySelectorAll(".card").forEach(c => c.classList.remove("active"));
    el.classList.add("active");
    selectedMethod = method;
}

function payNow() {

    let btn = document.querySelector(".pay-btn");
    btn.disabled = true;
    btn.innerText = "Processing...";

    fetch("bookSeats", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "showId=<%= showId %>&seats=<%= seats %>&method=" + selectedMethod
    })
    .then(res => res.text())
    .then(data => {
        if (data.startsWith("SUCCESS|")) {
            let id = data.split("|")[1];
            window.location.href = "confirmation?bookingId=" + id;
        } else {
            alert("Payment Failed");
            btn.disabled = false;
            btn.innerText = "PAY NOW";
        }
    })
    .catch(() => {
        alert("Server Error");
        btn.disabled = false;
        btn.innerText = "PAY NOW";
    });
}

</script>

</body>
</html>