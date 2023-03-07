/<%--
  Created by IntelliJ IDEA.
  User: KHANHHERE
  Date: 2/22/2023
  Time: 10:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add User</title>
    <%@include file="../home/HeaderLink.jsp" %>
</head>
<body class="layout-top-nav sidebar-closed sidebar-collapse">
<%@include file="../home/Header.jsp" %>
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6 card-header">
                    <h1 class="text-uppercase card-title">Add User </h1>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- left column -->
                <div class="col-md-10">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <!-- /.card-header -->
                        <!-- form start -->
                        <span style="color: red">${error}</span>
                        <form action="registration" method="post" id="form">
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Account</label>
                                        <input type="text" class="form-control" id="account" name="account" value="${account}"
                                               style="background: white;" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Email</label>
                                        <input type="email" class="form-control" id="email" value="${email}"
                                               name="email" style="background: white;" required>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Full Name</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" value="${fullName}"
                                               style="background: white;" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Password</label>
                                        <input type="password" class="form-control" id="password"
                                               name="password" style="background: white;" required>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Re-enter Password</label>
                                        <input class="form-control" id="rePassword" name="rePassword"
                                               type="password" style="background: white;" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Date of Birth</label>
                                        <input id="dob" class="form-control" type="date" value="${dob}"
                                               name="dob" style="background: white;" required>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Position</label>
                                        <input type="text" class="form-control" id="position" name="position" value="${position}"
                                               style="background: white;" required>
                                    </div>
                                </div>
                            </div>
                            <!-- /.card-body -->

                            <div class="card-footer">
                                <button class="btn btn-primary" type="reset">Reset</button>
                                <button id="btn" type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@include file="../home/Footer.jsp" %>
</body>
</html>
