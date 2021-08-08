<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>History</title>

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
                <a class="navbar-brand" href="ProductManagement">Resource Sharing</a>
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
            <div class="topnav">
                <div class="search-container">
                    <form action="MainController" method="get">
                        <input name="action" value="searchNameHistory" type="hidden">
                        <input type="text" value="${param.nameHistory}" placeholder="Search item.." name="nameHistory">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>
                <div class="search-container">
                    <form action="MainController" method="post">
                        <input name="action" value="searchDateHistory" type="hidden">
                        From: <input type="date" name="dateHistoryFrom" value="${param.dateHistoryFrom}" required>
                        <button type="submit"><i class="fa fa-search"></i></button>
                        To: <input type="date" name="dateHistoryTo" value="${param.dateHistoryTo}" required>
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>
            </div>
            <div class="row">
                <script src="https://use.fontawesome.com/c560c025cf.js"></script>
                <div class="container">
                    <div class="card shopping-cart">
                        <div class="card-header bg-dark text-light">
                            <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                            History
                            <a href="MainController" class="btn btn-outline-info btn-sm pull-right">Continue booking</a>
                            <div class="clearfix"></div>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty requestScope.listItemHistory}">
                                <i><h3><font color="red">Không có sản phẩm tương thích</font></h3></i>
                                    </c:if>
                                    <c:forEach items="${requestScope.listItemHistory}" var="itemHistory">
                                <div class="row">
                                    <div class="col-12 col-sm-12 col-md-2 text-center">
                                        <img class="img-responsive" src="image/${itemHistory.image}" alt="prewiew" width="120" height="80">
                                    </div>
                                    <div class="col-12 text-sm-center col-sm-12 text-md-left col-md-6">
                                        <h4 class="product-name"><strong>${itemHistory.itemName}</strong></h4>
                                        <font color="Blue">Color: </font>${itemHistory.color}
                                        <font color="Blue">Quantity: </font>${itemHistory.quantity}
                                        <font color="Blue">Date borrow: </font>${itemHistory.dateBorrow}
                                        <font color="Blue">Status request: </font>${itemHistory.statusRequest}
                                        <br>
                                        <font color="Blue">ID: </font>${itemHistory.bookingDetailID}
                                        <font color="Blue">Date booking: </font>${itemHistory.date}
                                    </div>
                                    <div class="col-12 col-sm-12 text-sm-center col-md-4 text-md-right row">
                                        <div class="col-2 col-sm-2 col-md-2 text-right">
                                            <button type="button" class="btn btn-outline-danger btn-xs" onclick="location.href = 'MainController?action=deleteHistory&bookingDetailID=${itemHistory.bookingDetailID}'">
                                                <i class="fa fa-trash" aria-hidden="true"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                            </c:forEach>
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
