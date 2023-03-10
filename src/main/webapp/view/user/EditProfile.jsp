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
    <title>Edit Profile</title>
    <%@include file="../home/HeaderLink.jsp" %>
</head>
<body class="layout-top-nav sidebar-closed sidebar-collapse">
<%@include file="../home/Header.jsp" %>
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6 card-header">
                    <h1 class="text-uppercase card-title">Edit Profile</h1>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6"  style="margin: 0 auto;">
                    <div class="card card-primary">
                        <span style="color: red">${sessionScope.error}</span>
                        <form action="UserProfileEditServlet" method="post" id="form">
                            <div class="card-body">
                                <div class="row">
                                    <input value="${user.userId}" name="userId" hidden/>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label>Name</label>
                                        <input required type="text" class="form-control" id="name"
                                               placeholder="Enter you full name" value="${user.fullName}"
                                               name="fullName"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label>Email</label>
                                        <input required class="form-control" id="email"
                                               placeholder="Enter your email address" value="${user.email}"
                                               name="email"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label>Age</label>
                                        <input required class="form-control" id="age"
                                               placeholder="Enter your age" type="number" min="1" max="120" step="1"
                                               value="${user.age}" name="age"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <button class="btn btn-warning" type="reset">
                                            <i class="fa-solid fa-rotate-left"></i> &nbsp; Reset
                                        </button>
                                        <button class="btn btn-success"
                                                onclick="return confirm('Save change!?')"
                                                type="submit">
                                            <i class="fa-solid fa-circle-check"></i> &nbsp; Update
                                        </button>
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
<script>
    let message = "${param.message}";
    if(message!=="") alert(message);
</script>
</body>
</html>
