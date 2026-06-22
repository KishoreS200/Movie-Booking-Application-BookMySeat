<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Login • BookMySeat</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet">

<style>


*{
    box-sizing:border-box;
}

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    min-height:100vh;
    overflow:hidden;
    background:
        linear-gradient(
            rgba(0,0,0,0.75),
            rgba(0,0,0,0.88)
        ),
        url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=1974&auto=format&fit=crop')
        center/cover no-repeat;

    position:relative;
    color:white;
}


body::before{
    content:"";

    position:absolute;
    inset:0;

    background:
        radial-gradient(
            circle at top right,
            rgba(236,72,153,0.22),
            transparent 30%
        ),

        radial-gradient(
            circle at bottom left,
            rgba(124,58,237,0.25),
            transparent 35%
        );

    pointer-events:none;
}


.container{
    position:relative;
    z-index:2;

    min-height:100vh;

    display:flex;
    justify-content:center;
    align-items:center;

    padding:20px;
}


.card{
    width:100%;
    max-width:430px;

    padding:40px;

    border-radius:28px;

    background:
        rgba(12,12,25,0.72);

    backdrop-filter:blur(20px);

    border:
        1px solid rgba(255,255,255,0.08);

    box-shadow:
        0 0 50px rgba(124,58,237,0.35);

    position:relative;

    overflow:hidden;
}


.card::before{
    content:"";

    position:absolute;
    width:240px;
    height:240px;

    background:
        radial-gradient(
            circle,
            rgba(124,58,237,0.28),
            transparent
        );

    top:-120px;
    right:-100px;

    filter:blur(20px);
}


.logo{
    font-size:34px;
    font-weight:800;

    margin-bottom:8px;

    background:
        linear-gradient(
            45deg,
            #c084fc,
            #ec4899
        );

    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}


.title{
    font-size:30px;
    font-weight:700;

    margin-top:10px;
}

.subtitle{
    color:#b5b5c3;
    font-size:14px;

    line-height:1.7;

    margin-bottom:30px;
}

.input-box{
    position:relative;
    margin-bottom:18px;
}

.input{
    width:100%;

    padding:16px 18px 16px 50px;

    border-radius:16px;

    border:
        1px solid rgba(255,255,255,0.08);

    background:
        rgba(255,255,255,0.04);

    color:white;

    font-size:15px;

    transition:0.3s;
}

.input:focus{
    outline:none;

    border:
        1px solid #c084fc;

    box-shadow:
        0 0 20px rgba(192,132,252,0.2);
}

.input::placeholder{
    color:#8f8f9f;
}


.icon{
    position:absolute;

    top:50%;
    left:18px;

    transform:translateY(-50%);

    font-size:16px;

    opacity:0.8;
}

.btn{
    width:100%;

    padding:15px;

    border:none;

    border-radius:18px;

    background:
        linear-gradient(
            45deg,
            #7c3aed,
            #ec4899
        );

    color:white;

    font-size:15px;
    font-weight:700;

    cursor:pointer;

    margin-top:8px;

    transition:0.3s;
}

.btn:hover{
    transform:
        translateY(-2px)
        scale(1.01);

    box-shadow:
        0 10px 30px rgba(236,72,153,0.3);
}

.divider{
    display:flex;
    align-items:center;

    gap:10px;

    margin:24px 0;

    color:#999;
    font-size:13px;
}

.divider::before,
.divider::after{
    content:"";
    flex:1;
    height:1px;
    background:#2a2a3d;
}

.link{
    text-align:center;
    font-size:14px;
    color:#aaa;
}

.link a{
    color:#c084fc;
    text-decoration:none;
    font-weight:600;
}

.error,
.success{
    margin-top:18px;
    padding:12px;
    border-radius:12px;
    font-size:14px;
}

.error{
    background:rgba(239,68,68,0.15);
    color:#ff6b6b;
}

.success{
    background:rgba(34,197,94,0.15);
    color:#4ade80;
}

@media(max-width:600px){

    .card{
        padding:30px 22px;
        border-radius:22px;
    }

    .title{
        font-size:24px;
    }

    .subtitle{
        font-size:13px;
    }

    .logo{
        font-size:28px;
    }
}

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="container">

<div class="card">

    <div class="logo">🎬 BookMySeat</div>

    <div class="title">
        Welcome Back
    </div>

    <div class="subtitle">
        Login to continue your cinematic journey.<br>
        Book premium movie experiences instantly.
    </div>

    <form action="<%= request.getContextPath() %>/login"
          method="post"
          onsubmit="handleLogin()">

        <div class="input-box">

            <span class="icon">📧</span>

            <input
                class="input"
                type="email"
                name="email"
                placeholder="Enter your email"
                required>

        </div>

        <div class="input-box">

            <span class="icon">🔒</span>

            <input
                class="input"
                type="password"
                name="password"
                placeholder="Enter password"
                required>

        </div>

        <button class="btn"
                id="loginBtn">

            LOGIN TO CONTINUE

        </button>

    </form>

    <div class="divider">
        CINEMA • EXPERIENCE • BOOKING
    </div>

    <div class="link">
        New here?
        <a href="register.jsp">
            Create Account
        </a>
    </div>

    <%
        String error =
                request.getParameter("error");

        String success =
                request.getParameter("success");

        if ("invalid".equals(error)) {
    %>

        <div class="error">
            Invalid credentials ❌
        </div>

    <%
        } else if ("server".equals(error)) {
    %>

        <div class="error">
            Server error ❌
        </div>

    <%
        }

        if ("1".equals(success)) {
    %>

        <div class="success">
            Account created successfully 🎉
        </div>

    <%
        }
    %>

</div>

</div>

<script>

function handleLogin(){

    let btn =
        document.getElementById("loginBtn");

    btn.innerText =
        "CONNECTING...";

    btn.disabled = true;
}

</script>

</body>
</html>