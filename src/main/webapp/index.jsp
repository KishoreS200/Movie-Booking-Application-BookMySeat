<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>BookWithMe</title>

<link rel="stylesheet"
href="<%= request.getContextPath() %>/css/style.css">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">
<style>

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#050510;
    color:white;
    overflow-x:hidden;
}


.hero{
    height:95vh;

    position:relative;

    overflow:hidden;

    background:
    linear-gradient(
        to right,
        rgba(0,0,0,0.92),
        rgba(0,0,0,0.55),
        rgba(0,0,0,0.75)
    ),
    url('images/banners/interstellar-banner.jpg');

    background-size:cover;
    background-position:center;

    display:flex;
    align-items:center;

    padding:0 90px;

    animation:zoomHero 18s infinite alternate;
}


.hero::before{
    content:'';

    position:absolute;
    inset:0;

    background:
    radial-gradient(circle at center,
    rgba(124,58,237,0.12),
    transparent 60%);

    z-index:1;
}


.hero::after{
    content:'';

    position:absolute;

    width:700px;
    height:700px;

    right:-200px;
    top:-120px;

    background:
    radial-gradient(circle,
    rgba(236,72,153,0.18),
    transparent 70%);

    filter:blur(30px);
}


.hero-content{
    position:relative;

    z-index:5;

    max-width:700px;

    animation:fadeUp 1s ease;
}

.hero-content h1{
    font-size:78px;

    line-height:1.05;

    margin-bottom:22px;

    font-weight:800;

    letter-spacing:-2px;
}

.hero-content span{
    background:
    linear-gradient(45deg,#a855f7,#ec4899);

    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.hero-content p{
    color:#d1d5db;

    font-size:20px;

    line-height:1.8;

    margin-bottom:40px;

    max-width:620px;
}

.buttons{
    display:flex;
    gap:18px;
}

.btn{
    padding:16px 34px;

    border-radius:14px;

    text-decoration:none;

    font-size:16px;

    font-weight:600;

    transition:0.35s ease;

    position:relative;

    overflow:hidden;
}

.primary{
    background:
    linear-gradient(45deg,#7c3aed,#ec4899);

    color:white;

    box-shadow:
    0 0 25px rgba(236,72,153,0.35);
}

.primary:hover{
    transform:
    translateY(-4px)
    scale(1.04);

    box-shadow:
    0 0 40px rgba(236,72,153,0.55);
}

.secondary{
    border:1px solid rgba(255,255,255,0.12);

    background:rgba(255,255,255,0.06);

    color:white;

    backdrop-filter:blur(8px);
}

.secondary:hover{
    background:rgba(255,255,255,0.12);

    transform:translateY(-3px);
}


.trending{
    padding:80px;
}

.section-title{
    font-size:38px;
    margin-bottom:35px;
}


.trending-row{
    display:flex;
    gap:25px;

    overflow-x:auto;

    padding-bottom:15px;

    scrollbar-width:none;
}

.trending-row::-webkit-scrollbar{
    display:none;
}


.trending-row img{
    width:220px;
    height:320px;

    object-fit:cover;

    border-radius:20px;

    transition:0.35s;

    flex-shrink:0;
}

.trending-row img:hover{
    transform:
    scale(1.06)
    translateY(-8px);

    box-shadow:
    0 0 35px rgba(124,58,237,0.4);
}


.features{
    padding:90px 80px;
    background:#070713;
}

.feature-grid{
    display:grid;

    grid-template-columns:
    repeat(auto-fit,minmax(250px,1fr));

    gap:30px;
}

.feature-card{
    background:
    linear-gradient(135deg,#101024,#16162f);

    border-radius:24px;

    padding:38px 28px;

    transition:0.35s;

    border:1px solid rgba(255,255,255,0.05);
}

.feature-card:hover{
    transform:
    translateY(-10px);

    box-shadow:
    0 0 35px rgba(124,58,237,0.25);
}

.icon{
    font-size:46px;
    margin-bottom:22px;
}

.feature-card h3{
    margin-bottom:14px;
    font-size:24px;
}

.feature-card p{
    color:#b8bfd1;
    line-height:1.8;
    font-size:15px;
}


.stats{
    padding:80px;

    display:flex;

    justify-content:center;

    gap:100px;

    flex-wrap:wrap;
}

.stat{
    text-align:center;
}

.stat h2{
    font-size:50px;

    margin-bottom:10px;

    background:
    linear-gradient(45deg,#7c3aed,#ec4899);

    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.stat p{
    color:#aaa;
    font-size:16px;
}



.footer{
    text-align:center;

    padding:35px;

    border-top:
    1px solid rgba(255,255,255,0.08);

    color:#888;
}

/* ANIMATIONS */

@keyframes fadeUp{

    from{
        opacity:0;
        transform:translateY(40px);
    }

    to{
        opacity:1;
        transform:translateY(0);
    }
}

@keyframes zoomHero{

    from{
        background-size:100%;
    }

    to{
        background-size:110%;
    }
}



@media(max-width:768px){

    .hero{
        padding:0 30px;
        height:88vh;
    }

    .hero-content h1{
        font-size:48px;
    }

    .hero-content p{
        font-size:16px;
    }

    .buttons{
        flex-direction:column;
        align-items:flex-start;
    }

    .trending,
    .features{
        padding:60px 30px;
    }

    .stats{
        gap:45px;
    }
}

</style>
</head>

<body>

<%@ include file="header.jsp" %>


<section class="hero">

    <div class="hero-content">

        <h1>

            Experience Movies Like Never Before with

            <span>BookMySeat</span>

        </h1>

        <p>

            Discover trending movies, explore premium theatres,
            select seats visually, and enjoy a futuristic
            cinematic booking experience.

        </p>

        <div class="buttons">

            <a href="movies"
               class="btn primary">

                🎬 Explore Movies

            </a>

            <a href="history"
               class="btn secondary">

                🎟 My Bookings

            </a>

        </div>

    </div>

</section>


<section class="trending">

    <h2 class="section-title">

        🔥 Trending Now

    </h2>

    <div class="trending-row">

        <img src="images/interstellar.jpg">

        <img src="images/inception.jpg">

        <img src="images/darkknight.jpg">

        <img src="images/avatar.jpg">

        <img src="images/joker.jpg">

    </div>

</section>


<section class="features">

    <h2 class="section-title">

        Why Choose BookMySeat?

    </h2>

    <div class="feature-grid">

        <div class="feature-card">

            <div class="icon">🎟</div>

            <h3>Instant Booking</h3>

            <p>

                Book tickets seamlessly with
                fast and smooth performance.

            </p>

        </div>

        <div class="feature-card">

            <div class="icon">💺</div>

            <h3>Live Seat Selection</h3>

            <p>

                Select your favorite seats with
                real-time availability.

            </p>

        </div>

        <div class="feature-card">

            <div class="icon">🏢</div>

            <h3>Premium Theatres</h3>

            <p>

                Explore multiple theatres,
                formats, and premium experiences.

            </p>

        </div>

        <div class="feature-card">

            <div class="icon">⚡</div>

            <h3>Fast & Secure</h3>

            <p>

                Secure booking workflow with
                responsive modern UI.

            </p>

        </div>

    </div>

</section>

<!-- STATS -->

<section class="stats">

    <div class="stat">

        <h2>30+</h2>

        <p>Theatres</p>

    </div>

    <div class="stat">

        <h2>100+</h2>

        <p>Daily Shows</p>

    </div>

    <div class="stat">

        <h2>15K+</h2>

        <p>Bookings</p>

    </div>

    <div class="stat">

        <h2>4DX</h2>

        <p>Premium Experience</p>

    </div>

</section>

<!-- FOOTER -->

<div class="footer">

    © 2026 BookMySeat • Designed by Kishore

</div>

</body>
</html>