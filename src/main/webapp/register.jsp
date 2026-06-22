<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Register • BookMySeat</title>

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
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{

    font-family:'Poppins',sans-serif;

    background:
        linear-gradient(
            rgba(0,0,0,0.78),
            rgba(0,0,0,0.88)
        ),

        url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=1974&auto=format&fit=crop')
        center/cover no-repeat fixed;

    color:white;

    min-height:100vh;

    overflow-x:hidden;
    overflow-y:auto;

    position:relative;
}

body::before{

    content:"";

    position:fixed;
    inset:0;

    background:
        radial-gradient(
            circle at top right,
            rgba(236,72,153,0.18),
            transparent 30%
        ),

        radial-gradient(
            circle at bottom left,
            rgba(124,58,237,0.22),
            transparent 35%
        );

    pointer-events:none;

    z-index:0;
}

.container{

    position:relative;
    z-index:2;

    min-height:calc(100vh - 80px);

    display:flex;
    justify-content:center;
    align-items:center;

    padding:60px 20px;
}

.card{

    width:100%;
    max-width:470px;

    background:
        rgba(10,10,25,0.82);

    border:
        1px solid rgba(255,255,255,0.08);

    backdrop-filter:blur(18px);

    border-radius:30px;

    padding:40px;

    box-shadow:
        0 0 60px rgba(124,58,237,0.35);

    overflow:hidden;

    position:relative;
}

.card::before{

    content:"";

    position:absolute;

    width:260px;
    height:260px;

    background:
        radial-gradient(
            circle,
            rgba(124,58,237,0.28),
            transparent
        );

    top:-120px;
    right:-80px;

    filter:blur(20px);
}

.logo{

    font-size:34px;
    font-weight:800;

    margin-bottom:10px;

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

    font-size:36px;
    font-weight:700;

    line-height:1.1;

    margin-bottom:10px;
}

.subtitle{

    color:#b7b7c9;

    font-size:14px;

    line-height:1.8;

    margin-bottom:30px;
}

.input-group{

    margin-bottom:18px;
}

.input-group label{

    display:block;

    margin-bottom:8px;

    font-size:13px;

    color:#d4d4df;
}

.input-box{

    position:relative;
}

.icon{

    position:absolute;

    top:50%;
    left:16px;

    transform:translateY(-50%);

    font-size:15px;

    opacity:0.85;
}

.input{

    width:100%;

    padding:15px 18px 15px 50px;

    border-radius:18px;

    border:
        1px solid rgba(255,255,255,0.08);

    background:
        rgba(255,255,255,0.05);

    color:white;

    font-size:14px;

    transition:0.3s;
}

.input::placeholder{

    color:#9a9ab0;
}

.input:focus{

    outline:none;

    border:
        1px solid #c084fc;

    box-shadow:
        0 0 20px rgba(192,132,252,0.18);
}


.toggle{

    position:absolute;

    top:50%;
    right:16px;

    transform:translateY(-50%);

    font-size:13px;

    color:#c084fc;

    cursor:pointer;
}

.btn{

    width:100%;

    padding:16px;

    border:none;

    border-radius:18px;

    margin-top:8px;

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

    transition:0.3s;
}


.btn:hover{

    transform:
        translateY(-2px)
        scale(1.01);

    box-shadow:
        0 10px 30px rgba(236,72,153,0.35);
}


.footer{

    margin-top:22px;

    text-align:center;

    color:#aaa;

    font-size:14px;
}

.footer a{

    color:#c084fc;

    text-decoration:none;

    font-weight:600;
}

.error{

    margin-top:18px;

    padding:12px;

    border-radius:12px;

    background:
        rgba(239,68,68,0.14);

    color:#ff7272;

    font-size:14px;
}

@media(max-width:700px){

    .container{

        align-items:flex-start;

        padding-top:120px;
        padding-bottom:40px;
    }

    .card{

        padding:28px 22px;

        border-radius:24px;
    }

    .title{

        font-size:28px;
    }

    .logo{

        font-size:28px;
    }

    .subtitle{

        font-size:13px;
    }
}

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="container">

<div class="card">

    <div class="logo">
        🎬 BookMySeat
    </div>

    <div class="title">
        Create<br>
        Account
    </div>

    <div class="subtitle">

        Join BookMySeat and unlock a futuristic
        cinematic ticket booking experience.

    </div>


    <form action="register"
          method="post"
          onsubmit="return handleRegister()">

        <div class="input-group">

            <label>Full Name</label>

            <div class="input-box">

                <span class="icon">👤</span>

                <input
                    class="input"
                    type="text"
                    name="name"
                    placeholder="Enter your name"
                    required>

            </div>

        </div>

 
        <div class="input-group">

            <label>Email Address</label>

            <div class="input-box">

                <span class="icon">📧</span>

                <input
                    class="input"
                    type="email"
                    name="email"
                    placeholder="Enter your email"
                    required>

            </div>

        </div>

 
        <div class="input-group">

            <label>Password</label>

            <div class="input-box">

                <span class="icon">🔒</span>

                <input
                    class="input"
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Create password"
                    required>

                <span class="toggle"
                      onclick="togglePassword()">

                    Show

                </span>

            </div>

        </div>

     
        <div class="input-group">

            <label>Phone Number</label>

            <div class="input-box">

                <span class="icon">📱</span>

                <input
                    class="input"
                    type="text"
                    name="phone"
                    placeholder="Enter phone number">

            </div>

        </div>

       
        <button
            type="submit"
            class="btn"
            id="registerBtn">

            CREATE ACCOUNT

        </button>

    </form>


    <div class="footer">

        Already have an account?

        <a href="login.jsp">

            Login

        </a>

    </div>


    <%
        String error =
                (String) request.getAttribute("error");

        if(error != null){
    %>

        <div class="error">

            <%= error %>

        </div>

    <%
        }
    %>

</div>

</div>

<script>

function togglePassword(){

    let input =
        document.getElementById("password");

    if(input.type === "password"){

        input.type = "text";

    }else{

        input.type = "password";
    }
}

function handleRegister(){

    let btn =
        document.getElementById("registerBtn");

    btn.innerText =
        "CREATING ACCOUNT...";

    btn.disabled = true;

    return true;
}

</script>

</body>
</html>