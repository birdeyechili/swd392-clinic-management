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
    <title>User Details</title>
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
                    <h1 class="text-uppercase card-title">User details </h1>
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
                        <span style="color: red">${sessionScope.error}</span>
                        <form action="userlist?tag=update" method="post" id="form">
                            <div class="card-body">
                                <div class="row">
                                    <input value="${user.userId}" name="userId" hidden/>
                                    <div class="form-group col-md-4">
                                        <label>Account</label>
                                        <input type="text" class="form-control" id="account"
                                               title="Name must be contains a-z" value="${user.account}" name="account"
                                               style="background: white;"/>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Password</label>
                                        <input class="form-control" id="password" value="${user.password}"
                                               name="password"
                                               style="background: white;"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Name</label>
                                        <input type="text" class="form-control" id="name"
                                               title="Name must be contains a-z" value="${user.fullName}" name="name"
                                               style="background: white;"/>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Email</label>
                                        <input class="form-control" id="email" value="${user.email}" name="email"
                                               style="background: white;"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Age</label>
                                        <input class="form-control" id="age"
                                               title="Age must >0" type="text"
                                               value="${user.age}" name="age" style="background: white;"/>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Position</label>
                                        <input id="position" class="form-control" type="text"
                                               value="${user.position}" name="position" style="background: white;"/>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Role</label>
                                        <select class="form-control selectpicker" id="role" name="role"
                                                style="width: 40%; margin-left: 0px">
                                            <jsp:useBean id="c"
                                                         class="com.example.swd392_clinic_management.util.Config"/>
                                            <c:set var="listRole" value="${c.listRole}"/>
                                            <c:forEach items="${listRole}" var="s" begin="0" varStatus="i">
                                                <option value="${i.count - 1}" ${user.role == i.count - 1 ? "selected":""}>${s}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="form-group col-md-8 ">
                                        <label>Status</label> <br/>
                                        <input type="radio" name="status" id="s1"
                                               value="1" ${user.status==true ? 'checked':''}>
                                        <label for="s1" style="font-weight: 500;">Active</label> &nbsp;&nbsp;

                                        <input type="radio" name="status" id="s2"
                                               value="0" ${user.status==false ? 'checked':''}>
                                        <label for="s2" style="font-weight: 500;">Inactive</label>
                                        &nbsp;&nbsp;
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
