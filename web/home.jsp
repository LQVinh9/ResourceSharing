<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
                        <c:url var="historyLink" value="MainController">
                            <c:param name="action" value="history"/>
                        </c:url>
                        <li class="nav-item">
                            <a class="nav-link" href="${historyLink}">History</a>
                        </li>
                        <c:url var="logoutLink" value="LoginController">
                            <c:param name="actionLogin" value="logout"/>
                        </c:url>
                        <li class="nav-item">
                            <a class="nav-link" href="${logoutLink}">Logout</a>
                        </li>
                        <li class="nav-item">
                            <i class="fa fa-user" style="font-size:40px;color:white"></i>
                        </li>
                        <li class="nav-item">
                            <p class="nav-link">${requestScope.userName} (${requestScope.roleName})<p>
                        </li>
                        <button class="btn37" onclick="location.href = 'MainController?action=showCart'"><i class="fa fa-shopping-cart" style="font-size:20px;color:white"></i> Cart (${requestScope.numberOfItem})</button>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <h1 class="my-4">Shop Name</h1>
                    <div class="topnav">
                        <div class="search-container">
                            <form action="MainController" method="get">
                                <input name="action" value="search" type="hidden">
                                <input type="text" value="${param.searchContext}" placeholder="Search item.." name="searchContext">
                                <button type="submit"><i class="fa fa-search"></i></button>
                            </form>
                        </div>
                    </div>
                    <hr>
                    <div class="topnav">
                        <div class="search-container">
                            <form action="MainController" method="post">
                                <input name="action" value="searchDate" type="hidden">
                                <input type="date" name="dateSearch" value="${param.dateSearch}" min="${requestScope.today}" required>
                                <button type="submit"><i class="fa fa-search"></i></button>
                            </form>
                        </div>
                    </div>
                    <br>
                    <div class="list-group">
                        <c:url var="homeLink" value="MainController"/>
                        <a class="list-group-item" href="${homeLink}">ALL CATEGORY</a>
                        <c:forEach items="${requestScope.listCategory}" var="category">
                            <c:url var="paginationLink" value="MainController">
                                <c:param name="categoryID" value="${category.categoryID}"/>
                            </c:url>
                            <a class="list-group-item" href="${paginationLink}">${category.categoryName}</a>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-lg-9">
                    <c:if test="${empty requestScope.listItem}">
                        <i><h3><font color="red">Không có sản phẩm tương thích</font></h3></i>
                            </c:if>
                    <div class="row">
                        <c:forEach items="${requestScope.listItem}" var="item">
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100">
                                    <a href="#!"><img class="card-img-top" src="image/${item.image}" alt="..." /></a>
                                    <div class="card-body">
                                        <h4 class="card-title"><a href="#!">${item.itemName}</a></h4>
                                    </div>
                                    <button class="card_button" onclick="location.href = 'MainController?action=addToCart&itemID=${item.itemID}'">Booking now</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="pagination">
                        <c:if test="${requestScope.numberOfPage>1}">
                            <c:if test="${requestScope.pageNumber!=1}">
                                <c:url var="paginationLink" value="MainController">
                                    <c:param name="pageNumber" value="${requestScope.pageNumber-1}"/>
                                    <c:if test="${not empty requestScope.categoryID}">
                                        <c:param name="categoryID" value="${requestScope.categoryID}"/>
                                    </c:if>
                                    <c:if test="${not empty param.action}">
                                        <c:if test="${param.action eq 'search'}">
                                            <c:param name="action" value="search"/>
                                            <c:param name="searchContext" value="${param.searchContext}"/>
                                        </c:if>
                                        <c:if test="${param.action eq 'searchDate'}">
                                            <c:param name="action" value="searchDate"/>
                                            <c:param name="dateSearch" value="${param.dateSearch}"/>
                                        </c:if>
                                    </c:if>
                                </c:url>
                                <a href="${paginationLink}">&laquo;</a>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${requestScope.numberOfPage}">
                                <c:url var="paginationLink" value="MainController">
                                    <c:param name="pageNumber" value="${i}"/>
                                    <c:if test="${not empty requestScope.categoryID}">
                                        <c:param name="categoryID" value="${requestScope.categoryID}"/>
                                    </c:if>
                                    <c:if test="${not empty param.action}">
                                        <c:if test="${param.action eq 'search'}">
                                            <c:param name="action" value="search"/>
                                            <c:param name="searchContext" value="${param.searchContext}"/>
                                        </c:if>
                                        <c:if test="${param.action eq 'searchDate'}">
                                            <c:param name="action" value="searchDate"/>
                                            <c:param name="dateSearch" value="${param.dateSearch}"/>
                                        </c:if>
                                    </c:if>
                                </c:url>
                                <c:if test="${i==requestScope.pageNumber}">
                                    <a href="${paginationLink}" class="active">${i}</a>
                                </c:if>
                                <c:if test="${i!=requestScope.pageNumber}">
                                    <a href="${paginationLink}">${i}</a>
                                </c:if>
                            </c:forEach>
                            <c:if test="${requestScope.pageNumber!=requestScope.numberOfPage}">
                                <c:url var="paginationLink" value="MainController">
                                    <c:param name="pageNumber" value="${requestScope.pageNumber+1}"/>
                                    <c:if test="${not empty requestScope.categoryID}">
                                        <c:param name="categoryID" value="${requestScope.categoryID}"/>
                                    </c:if>
                                    <c:if test="${not empty param.action}">
                                        <c:if test="${param.action eq 'search'}">
                                            <c:param name="action" value="search"/>
                                            <c:param name="searchContext" value="${param.searchContext}"/>
                                        </c:if>
                                        <c:if test="${param.action eq 'searchDate'}">
                                            <c:param name="action" value="searchDate"/>
                                            <c:param name="dateSearch" value="${param.dateSearch}"/>
                                        </c:if>
                                    </c:if>
                                </c:url>
                                <a href="${paginationLink}">&raquo;</a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${not empty param.notification}">
            <script>swal("Đặt sản phẩm thành công!", "", "success");</script>
        </c:if>                
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Vinh SE140313</p></div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>