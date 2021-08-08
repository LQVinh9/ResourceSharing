<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Register</title>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
            }
            #login .container #login-row #login-column #login-box {
                margin-top: 120px;
                max-width: 600px;
                height: 700px;
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
                        <form id="login-form" class="form" action="RegisterController" method="post">
                            <h3 class="text-center text-info">Register</h3>
                            <div class="form-group">
                                <label class="text-info">Email: <i><font color="red"> ${requestScope.userError.email}</font></i></label><br>
                                <input type="text" name="email" value="${param.email}" id="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="text-info">Password: <i><font color="red"> ${requestScope.userError.password}</font></i></label><br>
                                <input type="password" name="pass" value="${param.pass}" id="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="text-info">Confirm password: <i><font color="red"> ${requestScope.userError.passwordConfirm}</font></i></label><br>
                                <input type="password" name="passwordConfirm" value="${param.passwordConfirm}" id="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="text-info">Name: <i><font color="red"> ${requestScope.userError.name}</font></i></label><br>
                                <input type="text" name="name" value="${param.name}" id="password" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="text-info">Phone: <i><font color="red"> ${requestScope.userError.phone}</font></i></label><br>
                                <input type="text" name="phone" value="${param.phone}" id="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="text-info">Address: <i><font color="red"> ${requestScope.userError.address}</font></i></label><br>
                                <input type="text" name="address" value="${param.address}" id="password" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <c:if test="${empty param.role}">
                                    <input type="radio" name="role" value="E" checked>Employee
                                    <input type="radio" name="role" value="L">Leader
                                </c:if>
                                <c:if test="${param.role eq 'E'}">
                                    <input type="radio" name="role" value="E" checked>Employee
                                    <input type="radio" name="role" value="L">Leader
                                </c:if>
                                <c:if test="${param.role eq 'L'}">
                                    <input type="radio" name="role" value="E">Employee
                                    <input type="radio" name="role" value="L" checked>Leader
                                </c:if>
                            </div>
                            <div class="form-group">
                                <br><input type="submit" name="submit" class="btn btn-info btn-md" value="Submit">
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