<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="405687524425-qvsif465v942gb7elgr1643nqtteqdk2.apps.googleusercontent.com">

        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src='https://www.google.com/recaptcha/api.js?hl=vi'></script>
        <script src="https://apis.google.com/js/platform.js" async defer></script>

        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
            }
            #login .container #login-row #login-column #login-box {
                margin-top: 120px;
                max-width: 600px;
                height: 500px;
                border: 1px solid #9C9C9C;
                background-color: #EAEAEA;
            }
            #login .container #login-row #login-column #login-box #login-form {
                padding: 20px;
            }
            #login .container #login-row #login-column #login-box #login-form #register-link {
                margin-top: -245px;
            }
            footer {
                position:absolute;
                bottom:0;
                width:100%;
                height:60px;   /* Height of the footer */
                background:#6cf;
            }
        </style>
        <script>
            function onSignIn(googleUser) {
                var profile = googleUser.getBasicProfile();
                document.getElementById("email").value = profile.getEmail();
                var form = document.getElementById("sendServlet");
                googleUser.disconnect();
                form.submit();
            }
        </script>
    </script>
</head>
<body> 
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <h1 class="navbar-brand">Resource Sharing</h1>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
            </div>
        </div>
    </nav>
    <div id="login">
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form" action="LoginController" method="post">
                            <c:if test="${not empty requestScope.error}">
                                <script> swal("Lỗi đăng nhập!", "Username hoặc password không đúng!", "warning");</script>
                            </c:if>
                            <h3 class="text-center text-info">Login</h3>
                            <div class="form-group">
                                <label for="username" class="text-info">Email:</label><br>
                                <input type="text" name="userID" value="${param.userID}" id="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Password:</label><br>
                                <input type="password" name="password" value="${param.password}" id="password" class="form-control" required>
                            </div>
                            <div class="g-recaptcha"
                                 data-sitekey="6LcoHdcaAAAAAN5lis4iE-OxFalg_jdyx_2O1yi5"></div>
                            <c:if test="${not empty requestScope.errorVerify}">
                                <script> swal("Bạn đã bỏ lỡ Captcha!", "", "warning");</script>
                            </c:if>
                            <div class="form-group">
                                <br><input type="submit" name="submit" class="btn btn-info btn-md" value="Submit">
                                <br><br><hr>
                                <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
                                <c:if test="${not empty requestScope.errorLoginGoogle}">
                                    <script> swal("Tài khoản không được phép truy cập hệ thống!", "", "warning");</script>
                                </c:if>
                                <c:if test="${not empty requestScope.errorAccount}">
                                    <script> swal("Tài khoản chưa được kích hoạt!", "", "warning");</script>
                                </c:if>
                            </div>
                            <div id="register-link" class="text-right">
                                <a href="register.jsp" class="text-info">Register here</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form id="sendServlet" action="LoginController" method="post">
        <input type="hidden" id="email" name="email" value="">
    </form>
    <footer class="py-5 bg-dark">
        <div class="container">
            <p class="m-0 text-center text-white">Copyright &copy; Vinh SE140313</p>
        </div>
    </footer>

    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>