<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin</title>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />

        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="topnav">
                <button class="btnNew" onclick="location.href = 'MainController?statusRequest=New'">New</button>
                <button class="btnAccept" onclick="location.href = 'MainController?statusRequest=Accept'">Accepted</button>
                <button class="btnDelete" onclick="location.href = 'MainController?statusRequest=Delete'">Deleted</button>
                <div class="search-container">
                    <form action="MainController" method="get">
                        <input name="action" value="searchNameAdmin" type="hidden">
                        <input name="statusRequest" value="New" type="hidden">
                        <input type="text" value="${param.nameAdmin}" placeholder="Search item.." name="nameAdmin">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>
                <div class="search-container">
                    <form action="MainController" method="post">
                        <input name="action" value="searchDateAdmin" type="hidden">
                        <input name="statusRequest" value="New" type="hidden">
                        To: <input type="date" name="dateFrom" value="${param.dateFrom}" required>
                        From: <input type="date" name="dateTo" value="${param.dateTo}" required>
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div> 
            </div>
            <div class="row">
                <script src="https://use.fontawesome.com/c560c025cf.js"></script>
                <div class="container">
                    <div class="card shopping-cart">
                        <div class="card-header bg-dark text-light">
                            <c:if test="${empty param.statusRequest}">New</c:if>
                            ${param.statusRequest}
                            <div class="clearfix"></div>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty requestScope.listItemAdmin}">
                                <i><h3><font color="red">Không có sản phẩm tương thích</font></h3></i>
                                    </c:if>
                                    <c:forEach items="${requestScope.listItemAdmin}" var="itemAdmin">
                                <!-- PRODUCT -->
                                <div class="row">
                                    <div class="col-12 col-sm-12 col-md-2 text-center">
                                        <img class="img-responsive" src="image/${itemAdmin.image}" alt="prewiew" width="120" height="80">
                                    </div>
                                    <div class="col-12 text-sm-center col-sm-12 text-md-left col-md-6">
                                        <h4 class="product-name"><strong>${itemAdmin.itemName}</strong></h4>
                                        <font color="Blue">Color: </font>${itemAdmin.color}
                                        <font color="Blue">Quantity: </font>${itemAdmin.quantity}
                                        <font color="Blue">Date borrow: </font>${itemAdmin.dateBorrow}
                                        <font color="Blue">Status request: </font>${itemAdmin.statusRequest}
                                        <br>
                                        <font color="Blue">ID: </font>${itemAdmin.bookingDetailID}
                                        <font color="Blue">Date booking: </font>${itemAdmin.date}
                                        <br>
                                        <font color="Blue">Email: </font>${itemAdmin.userID}
                                        <font color="Blue">User name: </font>${itemAdmin.userName}
                                        <font color="Blue">Role: </font>${itemAdmin.roleName}
                                    </div>
                                    <div class="col-12 col-sm-12 text-sm-center col-md-4 text-md-right row">
                                        <div class="col-2 col-sm-2 col-md-2 text-right">
                                            <c:if test="${requestScope.dateNow gt itemAdmin.dateBorrow}">
                                                <button class="btnOutDate" onclick="location.href = '#'" disabled>Out Date</button>
                                            </c:if>
                                            <c:if test="${requestScope.dateNow le itemAdmin.dateBorrow}">
                                                <c:if test="${itemAdmin.statusRequest eq 'Accept'}">
                                                    <button class="btnDelete" onclick="location.href = 'MainController?statusRequest=${param.statusRequest}&action=deleteRequest&bookingDetailID=${itemAdmin.bookingDetailID}'">Delete</button>
                                                </c:if>
                                                <c:if test="${itemAdmin.statusRequest eq 'Delete'}">
                                                    <button class="btnAccept" onclick="location.href = 'MainController?statusRequest=${param.statusRequest}&action=acceptRequest&bookingDetailID=${itemAdmin.bookingDetailID}&itemID=${itemAdmin.itemID}&dateBorrow=${itemAdmin.dateBorrow}&quantity=${itemAdmin.quantity}'">Accept</button>
                                                </c:if>
                                                <c:if test="${itemAdmin.statusRequest eq 'New'}">
                                                    <button class="btnAccept" onclick="location.href = 'MainController?statusRequest=${param.statusRequest}&action=acceptRequest&bookingDetailID=${itemAdmin.bookingDetailID}&itemID=${itemAdmin.itemID}&dateBorrow=${itemAdmin.dateBorrow}&quantity=${itemAdmin.quantity}'">Accept</button>
                                                    <button class="btnDelete" onclick="location.href = 'MainController?statusRequest=${param.statusRequest}&action=deleteRequest&bookingDetailID=${itemAdmin.bookingDetailID}'">Delete</button>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                            </c:forEach>
                            <div class="pagination">
                                <c:if test="${requestScope.numberOfPage>1}">
                                    <c:if test="${requestScope.pageNumber!=1}">
                                        <c:url var="paginationLink" value="MainController">
                                            <c:param name="pageNumber" value="${requestScope.pageNumber-1}"/>
                                            <c:if test="${not empty param.statusRequest}">
                                                <c:param name="statusRequest" value="${param.statusRequest}"/>
                                            </c:if>
                                            <c:if test="${not empty param.action}">
                                                <c:if test="${param.action eq 'searchNameAdmin'}">
                                                    <c:param name="action" value="searchNameAdmin"/>
                                                    <c:param name="nameAdmin" value="${param.nameAdmin}"/>
                                                </c:if>
                                                <c:if test="${param.action eq 'searchDateAdmin'}">
                                                    <c:param name="action" value="searchDateAdmin"/>
                                                    <c:param name="dateFrom" value="${param.dateFrom}"/>
                                                    <c:param name="dateTo" value="${param.dateTo}"/>
                                                </c:if>
                                            </c:if>
                                        </c:url>
                                        <a href="${paginationLink}">&laquo;</a>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${requestScope.numberOfPage}">
                                        <c:url var="paginationLink" value="MainController">
                                            <c:param name="pageNumber" value="${i}"/>
                                            <c:if test="${not empty param.statusRequest}">
                                                <c:param name="statusRequest" value="${param.statusRequest}"/>
                                            </c:if>
                                            <c:if test="${not empty param.action}">
                                                <c:if test="${param.action eq 'searchNameAdmin'}">
                                                    <c:param name="action" value="searchNameAdmin"/>
                                                    <c:param name="nameAdmin" value="${param.nameAdmin}"/>
                                                </c:if>
                                                <c:if test="${param.action eq 'searchDateAdmin'}">
                                                    <c:param name="action" value="searchDateAdmin"/>
                                                    <c:param name="dateFrom" value="${param.dateFrom}"/>
                                                    <c:param name="dateTo" value="${param.dateTo}"/>
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
                                            <c:if test="${not empty param.statusRequest}">
                                                <c:param name="statusRequest" value="${param.statusRequest}"/>
                                            </c:if>
                                            <c:if test="${not empty param.action}">
                                                <c:if test="${param.action eq 'searchNameAdmin'}">
                                                    <c:param name="action" value="searchNameAdmin"/>
                                                    <c:param name="nameAdmin" value="${param.nameAdmin}"/>
                                                </c:if>
                                                <c:if test="${param.action eq 'searchDateAdmin'}">
                                                    <c:param name="action" value="searchDateAdmin"/>
                                                    <c:param name="dateFrom" value="${param.dateFrom}"/>
                                                    <c:param name="dateTo" value="${param.dateTo}"/>
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
            </div>
        </div>
        <c:if test="${not empty requestScope.successMessage}">
            <script> swal("Đã accept yêu cầu!", "", "success");</script>
        </c:if>
        <c:if test="${not empty requestScope.failureMessage}">
            <script> swal("Không thể accept yêu cầu!", "Lý do: sản phẩm còn lại không đủ!", "warning");</script>
        </c:if>
        <c:if test="${not empty requestScope.deleteMessage}">
            <script> swal("Đã delete yêu cầu!", "", "success");</script>
        </c:if>
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Vinh SE140313</p></div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>