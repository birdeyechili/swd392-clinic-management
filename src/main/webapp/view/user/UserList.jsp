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
                                    <select id="role" name="role" class="form-control selectpicker col-2"
                                            onchange="this.form.submit()" style="height: 40px; margin-right: 3px;">
                                        <option value="">All Role</option>
                                        <jsp:useBean id="c" class="com.example.swd392_clinic_management.util.Config"/>
                                        <c:set var="listRole" value="${c.listRole}"/>
                                        <c:forEach items="${listRole}" var="s" begin="0" varStatus="i">
                                            <option value="${i.count - 1}" ${role == i.count - 1 ? "selected":""}>${s}</option>
                                        </c:forEach>

                                    </select>
                                    <input type="text" style="margin-right: 3px;"
                                           value="${searchName==null?"":searchName}" placeholder="Type name to search"
                                           name="searchName" size="30%"/>
                                    <button style="margin-right: 3px;" type="submit" class="btn btn-primary">Search
                                    </button>
                                    <a href="userlist" style=" margin-right: 3px;">
                                        <button style="height: 40px;" type="button" class="btn btn-default">Reset
                                        </button>
                                    </a>

                                    <a href="userlist?tag=add" style="margin-left: 200px; padding-top: 5px;"><i
                                            class="fa fa-plus"></i> Add new</a>
                                </div>
                            </form>
                            <br/>
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
                                <c:if test="${userList != null}">
                                    <c:forEach items="${userList}" var="l">
                                        <c:forEach items="${listRole}" var="s" begin="0" varStatus="i">
                                            <c:if test="${l.role == i.count - 1}">
                                                <%--                                                <c:if test="${i.count == l.role}">--%>
                                                <tr class="text-center">
                                                    <td>${l.userId}</td>
                                                    <td>${l.fullName}</td>
                                                    <td>${l.email}</td>
                                                    <td>${s}</td>
                                                    <td style="color: ${l.status==true?"green":"red"};">${l.status?"Active":"Inactive"}</td>
                                                    <td>
                                                        <a class="btn btn-info btn-sm" style="margin-right:10%;"
                                                           href="?id=${l.userId}&tag=update"><i
                                                                class="fas fa-pencil-alt"></i></a>
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
    <c:set var="curPage" value="${requestScope.curPage}"/>
    <c:set var="NoPage" value="${requestScope.num}"/>
    <c:if test="${! empty requestScope.userList}">
        <nav aria-label="..." id="paging">
            <ul class="pagination d-flex justify-content-center">
                <li class="page-item disabled">
                    <c:if test="${curPage!=1}">
                <li class="page-item">
                    <a class="page-link" href="userlist?curPage=${1}&searchName=${searchName}&role=${role}">Begin</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="userlist?curPage=${curPage-1}&searchName=${searchName}&role=${role}">Previous</a>
                </li>
                </c:if>
                <c:forEach begin="${curPage>=2?curPage-1:curPage}" end="${curPage+2>NoPage?NoPage:curPage+2}" var="i">
                    <li class="page-item ${i==curPage?"active":""}">
                        <a class="page-link" href="userlist?curPage=${i}&searchName=${searchName}&role=${role}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${curPage!=NoPage}">
                    <li class="page-item">
                        <a class="page-link"
                           href="userlist?curPage=${curPage + 1}&searchName=${searchName}&role=${role}">Next</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link"
                           href="userlist?curPage=${NoPage}&searchName=${searchName}&role=${role}">End</a>
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
