<%@ page contentType="text/html;charset=UTF-8" %>

<style>

.navbar {
    background: linear-gradient(to right, #050505, #0a0a1a);
    padding: 16px 60px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 100;
    border-bottom: 1px solid rgba(255,255,255,0.05);
}


.logo {
    font-size: 20px;
    font-weight: 600;
    letter-spacing: 1px;
    color: #c084fc;
}


.nav-links {
    display: flex;
    align-items: center;
    gap: 28px;
}

.nav-links a {
    color: #aaa;
    text-decoration: none;
    font-size: 14px;
    transition: 0.3s;
    position: relative;
}

.nav-links a:hover {
    color: white;
}


.active {
    color: #c084fc !important;
}

.user {
    color: #888;
    font-size: 14px;
}

.login-btn {
    padding: 6px 14px;
    border-radius: 8px;
    background: linear-gradient(45deg, #7c3aed, #ec4899);
    color: white !important;
    font-size: 13px;
}

/* LOGOUT */
.logout {
    color: #ef4444 !important;
}

</style>

<%
    String uri = request.getRequestURI();
%>

<div class="navbar">

    <div class="logo">
        BookMySeat
    </div>

    <div class="nav-links">
        <a href="movies" class="<%= uri.contains("movies") ? "active" : "" %>">Movies</a>
        <a href="#">Cinemas</a>
        <a href="history" class="<%= uri.contains("history") ? "active" : "" %>">Booking</a>
    </div>

    <div class="nav-links">

        <%
            HttpSession userSession = request.getSession(false);

            if (userSession != null && userSession.getAttribute("userName") != null) {
        %>

            <span class="user">👤 <%= userSession.getAttribute("userName") %></span>

            <a href="logout" class="logout">Logout</a>

        <%
            } else {
        %>

            <a href="login.jsp" class="login-btn">Login</a>

        <%
            }
        %>

    </div>

</div>