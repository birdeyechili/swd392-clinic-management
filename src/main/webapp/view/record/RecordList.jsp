<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 3/5/2023
  Time: 10:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Record List</title>
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
                            <h2 class="card-title text-uppercase"><strong>Patient Record List</strong></h2>
                        </div>
                        <div class="card-body">
                            <form action="recordservlet" method="get">
                                <div class="row">
                                    <select id="searchCategory" name="searchCategory"
                                            class="form-control selectpicker col-2"
                                            style="height: 40px; margin-right: 3px;">
                                        <option value="PatientID">PatientID</option>
                                    </select>
                                    <input type="text" style="margin-right: 3px;"
                                           value="${searchInput}" placeholder="Type to search"
                                           name="searchInput" size="30%"/>
                                    <button style="margin-right: 3px;" type="submit" class="btn btn-primary">Search
                                    </button>
                                    <a href="recordservlet" style=" margin-right: 3px;">
                                        <button style="height: 40px;" type="button" class="btn btn-default">Reset
                                        </button>
                                    </a>

                                    <a href="recordservlet?tag=add" style="margin-left: 200px; padding-top: 5px;"><i
                                            class="fa fa-plus"></i> Add new</a>
                                </div>
                            </form>
                            <br/>
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr class="text-center">
                                    <th>RecordID</th>
                                    <th>PatientID</th>
                                    <th>Record</th>
                                    <th>Status</th>
                                    <th style="width: 130px;">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:if test="${recordList != null}">
                                    <c:forEach items="${recordList}" var="record">
                                        <%--                                                <c:if test="${i.count == l.role}">--%>
                                        <tr class="text-center">
                                            <td>${record.recordId}</td>
                                            <td>${record.patientId}</td>
                                            <td>${record.record}</td>
                                            <td style="color: ${l.status==true?"green":"red"};">${record.status?"Active":"Inactive"}</td>
                                            <td>
                                                <a class="btn btn-info btn-sm" style="margin-right:10%;"
                                                   href="?id=${record.recordId}&tag=update"><i
                                                        class="fas fa-pencil-alt"></i></a>
                                            </td>
                                        </tr>
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
    <c:if test="${! empty requestScope.recordList}">
        <nav aria-label="..." id="paging">
            <ul class="pagination d-flex justify-content-center">
                <li class="page-item disabled">
                    <c:if test="${curPage!=1}">
                <li class="page-item">
                    <a class="page-link"
                    <c:if test="${searchInput != null}">
                       href="recordservlet?curPage=${1}&searchInput=${searchInput}">Begin</a>
                    </c:if>
                    <c:if test="${searchInput == null}">
                        href="recordservlet?curPage=${1}">Begin</a>
                    </c:if>
                </li>
                <li class="page-item">
                    <a class="page-link"
                    <c:if test="${searchInput != null}">
                       href="recordservlet?curPage=${curPage-1}&searchInput=${searchInput}">Previous</a>
                    </c:if>
                    <c:if test="${searchInput == null}">
                        href="recordservlet?curPage=${curPage-1}">Previous</a>
                    </c:if>
                </li>
                </c:if>
                <c:forEach begin="${curPage>=2?curPage-1:curPage}" end="${curPage+2>NoPage?NoPage:curPage+2}" var="i">
                    <li class="page-item ${i==curPage?"active":""}">
                        <a class="page-link"
                        <c:if test="${searchInput != null}">
                           href="recordservlet?curPage=${i}&searchInput=${searchInput}">${i}</a>
                        </c:if>
                        <c:if test="${searchInput == null}">
                            href="recordservlet?curPage=${i}">${i}</a>
                        </c:if>
                    </li>
                </c:forEach>
                <c:if test="${curPage!=NoPage}">
                    <li class="page-item">
                        <a class="page-link"
                        <c:if test="${searchInput != null}">
                           href="recordservlet?curPage=${curPage + 1}&searchInput=${searchInput}">Next</a>
                        </c:if>
                        <c:if test="${searchInput == null}">
                            href="recordservlet?curPage=${curPage + 1}">Next</a>
                        </c:if>
                    </li>
                    <li class="page-item">
                        <a class="page-link"
                        <c:if test="${searchInput != null}">
                           href="recordservlet?curPage=${NoPage}&searchInput=${searchInput}">End</a>
                        </c:if>
                        <c:if test="${searchInput == null}">
                            href="recordservlet?curPage=${NoPage}">End</a>
                        </c:if>
                    </li>
                </c:if>
                </li>
            </ul>
        </nav>
    </c:if>

</div>


<%@include file="../home/Footer.jsp" %>
</body>
<script>
    $(document).ready(function () {
        $("#form").validate({
            onfocusout: false,
            onkeyup: false,
            onclick: false,
            highlight: function (element) {
                $(element).addClass('has-error');
            },
            unhighlight: function (element) {
                $(element).removeClass('has-error');
            },
            onfocusout: function (element) {
                this.element(element); // triggers validation
            },
            onkeyup: function (element, event) {
                if ($(element).hasClass('valid')) {
                    $(element).next().remove();
                }
                this.element(element); // triggers validation
            },
        });
    });
</script>
</html>

