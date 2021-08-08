<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Cart</title>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />

        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

        <style>
            .card{
                margin-bottom: 600px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="MainController">Resource Sharing</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="MainController">
                                Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <script src="https://use.fontawesome.com/c560c025cf.js"></script>
                <div class="container">
                    <div class="card shopping-cart">
                        <div class="card-header bg-dark text-light">
                            <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                            Cart
                            <a href="MainController" class="btn btn-outline-info btn-sm pull-right">Continue booking</a>
                            <div class="clearfix"></div>
                        </div>
                        <div class="card-body">
                            <form action="MainController?action=booking" method="post">
                                <c:forEach items="${requestScope.listItems}" var="itemOrder">
                                    <!-- PRODUCT -->
                                    <div class="row">
                                        <div class="col-12 col-sm-12 col-md-2 text-center">
                                            <img class="img-responsive" src="image/${itemOrder.item.image}" alt="prewiew" width="120" height="80">
                                        </div>
                                        <div class="col-12 text-sm-center col-sm-12 text-md-left col-md-6">
                                            <h4 class="product-name"><strong>${itemOrder.item.itemName}</strong></h4>
                                            <input type="date" value="${itemOrder.date}" name="dateBooking" min="${requestScope.today}" required>
                                            <i><font color="red"> ${itemOrder.error}</font></i>
                                        </div>
                                        <div class="col-12 col-sm-12 text-sm-center col-md-4 text-md-right row">
                                            <div class="col-4 col-sm-4 col-md-4">
                                                <div class="quantity">
                                                    <input type="number" step="1" max="99" min="1" value="${itemOrder.quantity}" title="Qty" class="qty"
                                                           size="4" name="quantity" required>
                                                </div>
                                            </div>
                                            <div class="col-2 col-sm-2 col-md-2 text-right">
                                                <button type="button" class="btn btn-outline-danger btn-xs" onclick="location.href = 'MainController?action=deleteItemCart&itemID=${itemOrder.item.itemID}'">
                                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                </c:forEach>
                                <div class="pull-right" style="margin: 10px">
                                    <c:if test="${not empty requestScope.listItems}">
                                        <input type="submit" value="Checkout" class="btn btn-success pull-right">
                                    </c:if>
                                    <c:if test="${empty requestScope.listItems}">
                                        <input type="submit" value="Checkout" class="btn btn-success pull-right" disabled> 
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
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
