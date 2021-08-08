<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Welcome</title>
        
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet"/>

        <style>
            .hero-image {
                background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url("image/welcome.jpg");
                height: 50%;
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                position: inherit;
            }

            .hero-text {
                text-align: center;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: white;
            }

            .hero-text button {
                border: 2px salmon;
                outline: 0;
                display: inline-block;
                padding: 10px 25px;
                color: black;
                background-color: #4CAF50;
                text-align: center;
                cursor: pointer;
            }

            .hero-text button:hover {
                background-color: #555;
                color: white;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <h1 class="navbar-brand">Resource Sharing</h1>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                    </ul>
                </div>
            </div>
        </nav>
        <img src="image/welcome.jpg" width="100%" height="1000">
        <div class="container">
            <div class="hero-image">
                <div class="hero-text">
                    <button onclick="location.href='MainController'"><h3>Continue</h3></button>
                </div>
            </div>
        </div>
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Vinh SE140313</p></div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>