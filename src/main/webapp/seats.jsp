<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.moviebooking.model.Seat" %>

<html>
<head>
<title>Select Seats</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">
<style>

body {
    margin: 0;
    background: #050505;
    color: white;
    font-family: 'Poppins', sans-serif;
}

.title {
    padding: 30px 60px;
    font-size: 34px;
    font-weight: 700;
}


.main {
    display: flex;
    gap: 40px;
    padding: 20px 60px 60px;
    flex-wrap: wrap;
}


.left {
    flex: 2;
    text-align: center;
    background: #0f0f1f;
    border-radius: 18px;
    padding: 30px;
}


.screen {
    width: 75%;
    height: 10px;
    margin: 20px auto;
    border-radius: 20px;
    background: linear-gradient(90deg, #7c3aed, #ec4899);
}

.screen-text {
    color: #999;
    margin-bottom: 30px;
    letter-spacing: 2px;
    font-size: 13px;
}

.legend {
    margin-bottom: 35px;
    color: #aaa;
    font-size: 13px;
}


.row {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 12px;
}

.row-gap {
    height: 24px;
}

.seat-gap {
    width: 45px;
}


.seat {
    width: 42px;
    height: 42px;

    margin: 5px;

    display: inline-flex;
    align-items: center;
    justify-content: center;

    border-radius: 8px;

    font-size: 11px;
    font-weight: 600;

    cursor: pointer;

    transition: 0.25s;
}

.seat:hover {
    transform: scale(1.08);
}


.silver {
    background: #64748b;
}


.gold {
    background: #f59e0b;
}

.vip {
    background: linear-gradient(45deg, #7c3aed, #ec4899);
}

.booked {
    background: #ef4444 !important;
    cursor: not-allowed;
    opacity: 0.7;
}

.selected {
    background: #22c55e !important;
}

.right {
    flex: 1;
}

.summary {
    background: #111827;
    padding: 25px;
    border-radius: 18px;
}

.summary-item {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

.total {
    margin-top: 20px;
    font-size: 24px;
    color: #22c55e;
    font-weight: bold;
}

.pay-btn {
    margin-top: 20px;
    width: 100%;
    padding: 14px;

    border: none;
    border-radius: 12px;

    background: linear-gradient(45deg, #7c3aed, #ec4899);

    color: white;
    font-size: 15px;
    font-weight: bold;

    cursor: pointer;
}

.pay-btn:hover {
    opacity: 0.9;
}

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="title">🎟 Select Your Seats</div>

<div class="main">

<div class="left">

<div class="screen"></div>
<div class="screen-text">SCREEN THIS WAY</div>

<div class="legend">
    🟪 VIP &nbsp;
    🟧 GOLD &nbsp;
    ⬜ SILVER &nbsp;
    🟥 BOOKED &nbsp;
    🟩 SELECTED
</div>

<%

List<Seat> seats =
    (List<Seat>) request.getAttribute("seats");

if (seats == null || seats.isEmpty()) {

%>

<h3>No seats available ❌</h3>

<%

} else {

    Map<String, List<Seat>> groupedSeats =
        new LinkedHashMap<>();

    for (Seat s : seats) {

        String row =
            s.getSeatNumber().substring(0, 1);

        groupedSeats
            .computeIfAbsent(row,
                k -> new ArrayList<>())
            .add(s);
    }

    String[] order = {
        "A", "B",
        "C", "D", "E",
        "F", "G", "H"
    };

    for (String row : order) {

        if (!groupedSeats.containsKey(row)) {
            continue;
        }

        List<Seat> rowSeats =
            groupedSeats.get(row);

  
        Collections.sort(rowSeats,
            (s1, s2) -> {

            int n1 = Integer.parseInt(
                s1.getSeatNumber()
                    .substring(1)
            );

            int n2 = Integer.parseInt(
                s2.getSeatNumber()
                    .substring(1)
            );

            return Integer.compare(n1, n2);
        });

%>

<div class="row">

<%

        for (int i = 0;
             i < rowSeats.size();
             i++) {

            Seat seat =
                rowSeats.get(i);

         
            if (i == 3 || i == 7) {

%>

<div class="seat-gap"></div>

<%

            }

            int id =
                seat.getSeatId();

            String number =
                seat.getSeatNumber();

            boolean isBooked =
                seat.getStatus() != null &&
                seat.getStatus()
                    .equalsIgnoreCase(
                        "BOOKED"
                    );

            String type =
                seat.getType() != null
                ? seat.getType()
                    .toLowerCase()
                : "silver";

            double price =
                seat.getPrice();

            String cls =
                "seat " + type;

            if (isBooked) {
                cls += " booked";
            }

%>

<div class="<%= cls %>"
     data-id="<%= id %>"
     data-number="<%= number %>"
     data-price="<%= price %>">

    <%= number %>

</div>

<%
        }
%>

</div>

<%

        if (row.equals("B")
            || row.equals("E")) {

%>

<div class="row-gap"></div>

<%

        }

    }

}
%>


<div class="right">

<div class="summary">

    <h3>🎫 Summary</h3>

    <div id="selectedList"></div>

    <div class="total">
        Total: ₹<span id="total">0</span>
    </div>

    <button id="payBtn"
            class="pay-btn">

        Proceed to Pay

    </button>

</div>

</div>

</div>

<script>

document.addEventListener(
"DOMContentLoaded",
function () {

    let selectedSeats = [];

    let total = 0;

    function updateUI() {

        document.getElementById("total")
            .innerText = total;

        let list =
            document.getElementById(
                "selectedList"
            );

        list.innerHTML = "";

        selectedSeats.forEach(s => {

            let div =
                document.createElement("div");

            div.className =
                "summary-item";

            div.innerHTML =
                "🎟 " + s.number +
                " <span>₹" +
                s.price +
                "</span>";

            list.appendChild(div);
        });
    }

    document
        .querySelectorAll(".seat")
        .forEach(seat => {

        seat.addEventListener(
        "click",
        function () {

            if (
                this.classList.contains(
                    "booked"
                )
            ) return;

            let id =
                parseInt(this.dataset.id);

            let number =
                this.dataset.number;

            let price =
                parseFloat(
                    this.dataset.price
                );

            this.classList.toggle(
                "selected"
            );

            let index =
                selectedSeats.findIndex(
                    s => s.id === id
                );

            if (index !== -1) {

                total -=
                    selectedSeats[index]
                        .price;

                selectedSeats.splice(
                    index,
                    1
                );

            } else {

                selectedSeats.push({
                    id,
                    number,
                    price
                });

                total += price;
            }

            updateUI();
        });

    });

    document
        .getElementById("payBtn")
        .addEventListener(
        "click",
        function () {

        if (
            selectedSeats.length === 0
        ) {

            alert("Select seats");

            return;
        }

        let showId =
            "<%= request.getAttribute("showId") %>";

        let ids =
            selectedSeats
                .map(s => s.id)
                .join(",");

        window.location.href =
            '<%= request.getContextPath() %>/payment.jsp'
            + '?showId=' + showId
            + '&seats=' + ids
            + '&amount=' + total;

    });

});

</script>

</body>
</html>