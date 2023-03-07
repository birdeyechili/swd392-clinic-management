<%--
  Created by IntelliJ IDEA.
  User: long
  Date: 2023-03-08
  Time: 12:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<html>
<head>
    <title>User Profile</title>
    <%@include file="../home/HeaderLink.jsp" %>
</head>
<body class="layout-top-nav sidebar-closed sidebar-collapse">
<%@include file="../home/Header.jsp" %>
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6 card-header">
                    <h1 class="text-uppercase card-title">My Profile</h1>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-10">
                    <div class="card card-primary">
                        <span style="color: red">${sessionScope.error}</span>
                        <form action="UserProfileServlet" method="post" id="form">
                            <div class="card-body">
                                <div class="row">
                                    <input value="${user.userId}" name="userId" hidden/>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label>Name</label>
                                        <input readonly type="text" class="form-control" id="name"
                                               placeholder="Enter you full name" value="${user.fullName}"
                                               name="fullName"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label>Email</label>
                                        <input readonly class="form-control" id="email"
                                               placeholder="Enter your email address" value="${user.email}"
                                               name="email"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label>Age</label>
                                        <input readonly class="form-control" id="age"
                                               placeholder="Enter your age" type="number" min="1" max="120" step="1"
                                               oninput="this.value = Math.round(this.value)"
                                               value="${user.age}" name="age"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <a class="btn btn-success" href="${pageContext.request.contextPath}/#">
                                            <i class="fa-solid fa-backward"></i> &nbsp; Back
                                        </a>
                                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/UserProfileEditServlet">
                                            <i class="fa-solid fa-pen-to-square"></i> &nbsp; Edit
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@include file="../home/Footer.jsp" %>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.2/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.js"></script>

</body>
</html>
