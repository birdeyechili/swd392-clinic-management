<%--
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
    <title>User List</title>
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
                                <h2 class="card-title text-uppercase"><strong>User List</strong></h2>
                            </div>
                            <div class="card-body">
                                <form action="userlist" method="get">
                                    <div class="row">
                                        <select id="roleId" name="roleId" class="form-control selectpicker col-2"  onchange="this.form.submit()" style="height: 40px; margin-right: 3px;">
                                            <option value="">All Role</option>
                                            <jsp:useBean id="c" class="com.example.swd392_clinic_management.util.Config" />
                                            <c:set var="listRole" value="${c.listRole}" />
                                            <c:forEach items="${listRole}" var="s" begin="0" varStatus="i" >
                                                <option value="${i.count}" >${s}</option>
                                            </c:forEach>

                                        </select>
                                        <input type="text" style="margin-right: 3px;" value="${requestScope.name==null?"":requestScope.name}" placeholder="Type name to search" name="name" size="30%"/>
                                        <button style="margin-right: 3px;" type="submit" class="btn btn-primary" >Search</button>
                                        <a href="userlist" style=" margin-right: 3px;"><button style="height: 40px;" type="button" class="btn btn-default">Reset </button></a>

                                        <a href="userlist?tag=add" style="margin-left: 200px; padding-top: 5px;"><i class="fa fa-plus"></i> Add new</a>
                                    </div>
                                </form><br/>
                                <table class="table table-bordered table-hover">
                                    <thead>
                                    <tr class="text-center">
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th style="width: 130px;">Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${!empty list}">
                                        <c:forEach items="${list}" var="l">
                                            <c:forEach items="${listRole}" var = "s" begin="0" varStatus ="i" end="4">
                                                <c:if test="${l.roleId == i.count}">
                                                    <tr class="text-center">
                                                        <td>${l.userId}</td>
                                                        <td>${l.fullName}</td>
                                                        <td>${l.email}</td>
                                                        <td>${s}</td>
                                                        <td style="color: ${l.status==true?"green":"red"};">${l.status==true?"Active":"Inactive"}</td>
                                                        <td>
                                                            <a class="btn btn-info btn-sm" style="margin-right:10%;" href="?id=${l.userId}&tag=update"><i class="fas fa-pencil-alt"></i></a>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>

                                        </c:forEach>
                                    </c:if>
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
