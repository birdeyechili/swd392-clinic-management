<%--
  Created by IntelliJ IDEA.
  User: KHANHHERE
  Date: 2/23/2023
  Time: 10:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Request Appointment</title>
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
                    <h1 class="text-uppercase card-title">Request Appointment</h1>
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
                        <form action="request" method="post" id="form">
                            <div class="card-body">
                                <div class="row">
                                    <input value="${sessionScope.loggedUser.userId}" name="patientId" hidden/>
                                    <div class="form-group col-md-8">
                                        <label>Doctor</label>
                                        <select class="form-control selectpicker" id="roleId" name="doctorId"
                                                style="width: 100%; margin-left: 0px">
                                            <c:forEach items="${doctorList}" var="s" begin="0" varStatus="i">
                                                <option value="${s.userId}" ${s.userId == doctorId ? "selected":""}>
                                                        ${s.fullName} - ${s.position} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Time</label>
                                        <input class="form-control" id="time"
                                               placeholder="HH:mm dd-MM-yyyy" type="text" value="${time}" name="time"
                                               style="background: white;"/>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-8">
                                        <label>Note</label>
                                        <textarea class="form-control" id="note" name="note" type="text" rows="3"
                                                  cols="8" style="background: white; justify-content:left;">
                                            ${note}
                                        </textarea>
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
