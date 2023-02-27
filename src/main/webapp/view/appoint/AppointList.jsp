<%--
  Created by IntelliJ IDEA.
  User: KHANHHERE
  Date: 2/22/2023
  Time: 11:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                            <form action="appointment" method="get">
                                <div class="row">
                                    <select class="form-control selectpicker col-2" name="searchStatus"
                                            onchange="this.form.submit()" style="height: 40px;margin-right: 3px;">
                                        <option value="">All Status</option>
                                        <jsp:useBean id="c" class="com.example.swd392_clinic_management.util.Config"/>
                                        <c:set var="listStatus" value="${c.listAppointStatus}"/>
                                        <c:forEach items="${listStatus}" var="s" begin="0" varStatus="i">
                                            <option value="${i.count - 1}" ${searchStatus == i.count - 1 ? "selected":""}>${s}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="text" style="margin-right: 3px;"
                                           value="${searchKey==null?"":searchKey}"
                                           size="30%" placeholder="Search by doctor or patient's name..."
                                           name="searchKey"/>
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
                                <c:forEach items="${list}" var="l">
                                    <tr>
                                        <td>${l.appointId}</td>
                                        <td>${l.doctorName}</td>
                                        <td>${l.patientName}</td>
                                        <td><fmt:formatDate value="${l.time}" pattern="HH:mm dd-MM-yyyy"/></td>
                                        <td>${listStatus[l.status]}</td>
                                        <td>
                                            <a class="btn btn-info btn-sm" style="margin-right:10%;"
                                               href="appointment?tag=update&id=${l.appointId}"><i
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
    <c:set var="curPage" value="${requestScope.curPage}"/>
    <c:set var="NoPage" value="${requestScope.num}"/>
    <c:if test="${! empty requestScope.list}">
        <nav aria-label="..." id="paging">
            <ul class="pagination d-flex justify-content-center">
                <li class="page-item disabled">
                    <c:if test="${curPage!=1}">
                <li class="page-item">
                    <a class="page-link"
                       href="appointment?curPage=${1}&searchKey=${searchKey}&searchStatus=${searchStatus}">Begin</a>
                </li>
                <li class="page-item">
                    <a class="page-link"
                       href="appointment?curPage=${curPage - 1}&searchKey=${searchKey}&searchStatus=${searchStatus}">Previous</a>
                </li>
                </c:if>
                <c:forEach begin="${curPage>=2?curPage-1:curPage}" end="${curPage+2>NoPage?NoPage:curPage+2}" var="i">
                    <li class="page-item ${i==curPage?"active":""}">
                        <a class="page-link"
                           href="appointment?curPage=${i}&searchKey=${searchKey}&searchStatus=${searchStatus}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${curPage!=NoPage}">
                    <li class="page-item">
                        <a class="page-link"
                           href="appointment?curPage=${curPage + 1}&searchKey=${searchKey}&searchStatus=${searchStatus}">Next</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link"
                           href="appointment?curPage=${NoPage}&searchKey=${searchKey}&searchStatus=${searchStatus}">End</a>
                    </li>
                </c:if>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<%@include file="../home/Footer.jsp" %>
</body>
</html>
