<%--
  Created by IntelliJ IDEA.
  User: KHANHHERE
  Date: 2/22/2023
  Time: 11:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Appointment Detail</title>
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
                    <h1 class="text-uppercase card-title">Appointment detail </h1>
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
                        <form action="appointment?tag=update" method="post" id="form">
                            <div class="card-body">
                                <div class="row">
                                    <input name="id" value="${appointment.appointId}" name="id" hidden/>
                                    <div class="form-group col-md-4" \>
                                        <label>Patient</label>
                                        <input type="text" class="form-control" id="patient"
                                               title="Name must be contains a-z" value="${appointment.patientName}"
                                               name="patient"
                                               style="background: white;" readonly/>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Doctor</label>
                                        <select class="form-control selectpicker" id="roleId" name="doctor"
                                                style="width: 100%; margin-left: 0px">
                                            <c:forEach items="${doctorList}" var="s" begin="0" varStatus="i">
                                                <option value="${s.userId}" ${s.fullName == appointment.doctorName ? "selected":""}>
                                                        ${s.fullName} - ${s.position} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Time</label>
                                        <input class="form-control" id="time"
                                               title="Age must >0" type="text" placeholder="HH:mm dd-MM-yyyy"
                                               value="<fmt:formatDate value="${appointment.time}" pattern="HH:mm dd-MM-yyyy" />"
                                               name="time" style="background: white;"/>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Note</label>
                                        <textarea class="form-control" id="note"
                                                  title="Age must >0" type="text"
                                                  name="note" style="background: white;">${appointment.note}</textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-8 ">
                                        <label>Status</label> <br/>
                                        <select class="form-control selectpicker col-2" name="status"
                                                style="height: 40px;margin-right: 3px;">
                                            <jsp:useBean id="c"
                                                         class="com.example.swd392_clinic_management.util.Config"/>
                                            <c:set var="listStatus" value="${c.listAppointStatus}"/>
                                            <c:forEach items="${listStatus}" var="s" begin="0" varStatus="i">
                                                <option value="${i.count - 1}" ${appointment.status == i.count - 1 ? "selected":""}>${s}</option>
                                            </c:forEach>
                                        </select>
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
