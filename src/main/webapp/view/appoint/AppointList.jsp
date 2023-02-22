<%--
  Created by IntelliJ IDEA.
  User: KHANHHERE
  Date: 2/22/2023
  Time: 11:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Appointment List</title>
    <%@include file="../home/HeaderLink.jsp" %>
</head>
<body class="layout-top-nav sidebar-closed sidebar-collapse">
<%@include file="../home/Header.jsp" %>
<div class="content-wrapper">
    <!-- jQuery -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title text-uppercase"><strong>All Appointment</strong></h2>
                        </div>
                        <div class="card-body">
                            <form action="class" method="get">
                                <div class="row">
                                    <select class="form-control selectpicker col-2" name="search_status"
                                            onchange="this.form.submit()" style="height: 40px;margin-right: 3px;">
                                        <option value="">All Role</option>
                                        <jsp:useBean id="c" class="com.example.swd392_clinic_management.util.Config"/>
                                        <c:set var="listStatus" value="${c.listAppointStatus}"/>
                                        <c:forEach items="${listStatus}" var="s" begin="0" varStatus="i">
                                            <option value="${i.count}">${s}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="text" style="margin-right: 3px;"
                                           value="${requestScope.search_value==null?"":requestScope.search_value}"
                                           size="30%" placeholder="Type ... to search"
                                           name="search_value"/>
                                    <button style="margin-right: 3px;" type="submit" class="btn btn-primary">Search
                                    </button>

                                </div>
                            </form>
                            <br/>
                            <table class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Doctor</th>
                                        <th>Patient</th>
                                        <th>Time</th>
                                        <th>Status</th>
                                        <th>Detail</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${requestScope.listPerPage}" var="l">
                                        <tr>
                                            <td>${l.id}</td>
                                            <td>${l.doctor}</td>
                                            <td>${l.patient}</td>
                                            <td>${l.time}</td>
                                            <td>${l.status}</td>
                                            <td>
                                                <a class="btn btn-info btn-sm" style="margin-right:10%;"
                                                   href="class?tag=update&id=${l.classId}"><i
                                                        class="fas fa-pencil-alt"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@include file="../home/Footer.jsp" %>
</body>
</html>
