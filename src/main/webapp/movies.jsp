<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.moviebooking.model.Movie" %>

<html>
<head>
<title>Movies</title>

<link rel="stylesheet"
href="<%= request.getContextPath() %>/css/style.css">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">
<style>

body{
    margin:0;
    background: radial-gradient(circle at top,#0a0a1a,#050505);
    color:white;
    font-family:'Poppins',sans-serif;
}


.hero-slider{
    position: relative;

    width: calc(100% - 40px);

    height: 92vh;

    margin: 20px auto;

    border-radius: 28px;

    overflow: hidden;

    background: #000;
}



.hero-slide{
    position: absolute;
    inset: 0;

    opacity: 0;

    transition: opacity 1s ease;
}

.hero-slide.active{
    opacity: 1;
    z-index: 2;
}



.hero-image{

    width:100%;
    height:100%;

    object-fit:cover;

    object-position:center top;

    transform:scale(1.02);

    filter:
    brightness(0.82)
    contrast(1.15)
    saturate(1.15);
}



.hero-overlay{

    position:absolute;
    inset:0;

    background:
    linear-gradient(
        to right,
        rgba(0,0,0,0.75) 0%,
        rgba(0,0,0,0.35) 35%,
        rgba(0,0,0,0.15) 70%,
        rgba(0,0,0,0.25) 100%
    );
}


.hero-content{

    position:absolute;

    left:80px;
    bottom:120px;

    z-index:5;

    max-width:600px;
}

.hero-content h1{

    font-size:90px;

    margin-bottom:18px;

    line-height:1;

    font-weight:800;

    background:
    linear-gradient(
        90deg,
        #d8b4fe,
        #f472b6
    );

    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.hero-content p{

    font-size:22px;

    color:#f3f4f6;

    margin-bottom:35px;

    letter-spacing:0.5px;
}



.hero-book-btn{

    display:inline-flex;

    align-items:center;
    justify-content:center;

    padding:16px 36px;

    border-radius:14px;

    background:
    linear-gradient(
        45deg,
        #7c3aed,
        #ec4899
    );

    color:white;

    text-decoration:none;

    font-size:18px;
    font-weight:700;

    box-shadow:
        0 10px 30px rgba(236,72,153,0.35);

    transition:0.3s;
}

.hero-book-btn:hover{

    transform:translateY(-3px) scale(1.03);

    box-shadow:
        0 15px 40px rgba(236,72,153,0.5);
}



.movies-section{
    padding:40px;
}


.movies-section h2{
    font-size:42px;
    margin-bottom:25px;
}


.categories{
    display:flex;
    gap:15px;
    margin-bottom:35px;
}

.category{
    padding:10px 22px;
    border-radius:30px;
    background:#101830;
    cursor:pointer;
    transition:0.3s;
}

.category.active{
    background:
    linear-gradient(45deg,#7c3aed,#ec4899);
}



.movies-grid{
    display:grid;

    grid-template-columns:
    repeat(auto-fit,minmax(250px,1fr));

    gap:30px;
}


.movie-card{
    background:#101325;

    border-radius:18px;

    overflow:hidden;

    transition:0.3s;

    display:flex;
    flex-direction:column;

    height:100%;
}

.movie-card:hover{
    transform:translateY(-10px);

    box-shadow:
    0 0 25px rgba(236,72,153,0.3);
}



.poster{
    width:100%;
    height:380px;
    object-fit:cover;
}



.movie-info{
    padding:20px;

    display:flex;
    flex-direction:column;

    flex:1;
}


.movie-info h3{
    margin:0 0 15px;

    font-size:30px;

    min-height:72px;
}



.movie-meta{
    color:#bbb;
    line-height:1.8;

    margin-bottom:25px;
}



.book-btn{
    display:flex;
    justify-content:center;
    align-items:center;

    width:100%;

    padding:14px 0;

    border-radius:12px;

    background:
    linear-gradient(45deg,#7c3aed,#ec4899);

    color:white;
    text-decoration:none;
    font-weight:600;

    transition:0.3s;

    margin-top:auto;
}

.book-btn:hover{
    transform:scale(1.03);
}

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<%
List<Movie> list =
(List<Movie>) request.getAttribute("movieList");
%>


<div class="hero-slider">

<%
if(list != null && !list.isEmpty()){

    for(int i=0; i<Math.min(5, list.size()); i++){

        Movie movie = list.get(i);
%>

<div class="hero-slide <%= i == 0 ? "active" : "" %>">

    <img
    src="<%= request.getContextPath() + "/" + movie.getBannerUrl() %>"
    class="hero-image">

    <div class="hero-overlay"></div>

    <div class="hero-content">

        <h1><%= movie.getTitle() %></h1>

        <p>

            🎭 <%= movie.getGenre() %>

            • 🌐 <%= movie.getLanguage() %>

            • ⏱ <%= movie.getDuration() %> mins

        </p>

        <a
        class="hero-book-btn"

        href="<%= request.getContextPath() %>/shows?movieId=<%= movie.getMovieId() %>">

            🎟 Book Tickets

        </a>

    </div>

</div>

<%
    }
}
%>

</div>



<div class="movies-section">

    <h2>🔥 Now Showing</h2>

    <div class="categories">

        <span class="category active">All</span>
        <span class="category">Action</span>
        <span class="category">Sci-Fi</span>
        <span class="category">Thriller</span>
        <span class="category">Drama</span>

    </div>

    <div class="movies-grid">

<%
if(list != null && !list.isEmpty()){

    for(Movie movie : list){
%>

        <div class="movie-card">

            <img
                class="poster"

                src="<%= request.getContextPath() + "/" + movie.getPosterUrl() %>"

                onerror="this.src='https://via.placeholder.com/300x450?text=No+Image'"
            >

            <div class="movie-info">

                <h3><%= movie.getTitle() %></h3>

                <div class="movie-meta">

                    🌐 <%= movie.getLanguage() %><br>

                    🎭 <%= movie.getGenre() %><br>

                    ⏱ <%= movie.getDuration() %> mins

                </div>

                <a
                class="book-btn"

                href="<%= request.getContextPath() %>/shows?movieId=<%= movie.getMovieId() %>">

                    Book Now 🎟

                </a>

            </div>

        </div>

<%
    }

}else{
%>

<h3>No movies available ❌</h3>

<%
}
%>

    </div>

</div>

<script>

const slides =
document.querySelectorAll(".hero-slide");

let currentSlide = 0;

setInterval(() => {

    slides[currentSlide]
    .classList.remove("active");

    currentSlide++;

    if(currentSlide >= slides.length){
        currentSlide = 0;
    }

    slides[currentSlide]
    .classList.add("active");

}, 4000);

</script>

</body>
</html>