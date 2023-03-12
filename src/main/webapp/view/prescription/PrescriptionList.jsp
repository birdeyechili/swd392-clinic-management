<%--
  Created by IntelliJ IDEA.
  User: long
  Date: 2023-03-07
  Time: 10:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Prescription List</title>
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
                            <h2 class="card-title text-uppercase"><strong>Prescription List</strong></h2>
                        </div>
                        <div class="card-body">
                            <form action="prescriptionList" method="POST">
                                <div class="row">
                                    <select id="searchCategory" name="searchCategory"
                                            class="form-control selectpicker col-2"
                                            style="height: 40px; margin-right: 3px;">
                                        <option value="id">Prescription ID</option>
                                    </select>
                                    <input type="number" step="1" style="margin-right: 3px;"
                                           placeholder="Type to search"
                                           name="searchInput" size="30%"/>
                                    <button style="margin-right: 3px;" type="submit" class="btn btn-primary">Search</button>
                                    <button style="height: 40px;" type="reset" class="btn btn-default">Reset</button>

                                    <a href="createprescription" style="margin-left: 200px; padding-top: 5px;"><i
                                            class="fa fa-plus"></i> Add new</a>
                                </div>
                            </form>
                            <br/>
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>Appointment</th>
                                    <th>Prescription</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                    <th style="width: fit-content">Action</th>
                                </tr>
                                </thead>
                                <tbody id="tbody">
                                <c:if test="${presList.size() == 0}">
                                    <tr>
                                        <td colspan="6">
                                            <h1 style="color:red; font-size: 40px; text-align: center">No result! Try adding something first.</h1>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${presList.size() != 0}">
                                    <c:forEach items="${presList}" var="p">
                                        <tr class="text-center">
                                            <td>${p.presId}</td>
                                            <td>${p.appointId}</td>
                                            <td>${p.pres}</td>
                                            <td>${p.note}</td>
                                            <jsp:useBean id="c"
                                                         class="com.example.swd392_clinic_management.util.Config"/>
                                            <c:set var="listStatus" value="${c.prescriptionStatus}"/>
                                            <c:forEach items="${listStatus}" var="s" begin="0" varStatus="i">
                                                <c:if test="${(i.count - 1) == p.status}">
                                                    <td>${s}</td>
                                                </c:if>
                                            </c:forEach>
                                            <td>
                                                <a class="btn btn-info btn-sm"
                                                   href="${pageContext.request.contextPath}/updateprescription?presId=${p.presId}"><i
                                                        class="fas fa-pencil-alt"></i> &nbsp; Update
                                                </a>
                                                <a class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Delete this Item!?')"
                                                   href="${pageContext.request.contextPath}/PrescriptionDeleteServlet?id=${p.presId}"><i
                                                        class="fa-solid fa-trash-can"></i> &nbsp; Delete
                                                </a>
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
                           href="prescriptionList?curPage=${curPage + 1}&searchInput=${searchInput}">Next</a>
                        </c:if>
                        <c:if test="${searchInput == null}">
                            href="prescriptionList?curPage=${curPage + 1}">Next</a>
                        </c:if>
                    </li>
                    <li class="page-item">
                        <a class="page-link"
                        <c:if test="${searchInput != null}">
                           href="prescriptionList?curPage=${NoPage}&searchInput=${searchInput}">End</a>
                        </c:if>
                        <c:if test="${searchInput == null}">
                            href="prescriptionList?curPage=${NoPage}">End</a>
                        </c:if>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>

</div>


<%@include file="../home/Footer.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
      integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ=="
      crossorigin="anonymous" referrerpolicy="no-referrer"/>
</body>
<script>
    let message = "${param.message}";
    if(message!=="") alert(message);
</script>
<script src="${pageContext.request.contextPath}/js/paginathing.js"></script>
<script>
    $('#tbody').paginathing({
        perPage: 5,
        limitPagination: false,
        prevNext: true,
        firstLast: true,
        prevText: '&laquo;',
        nextText: '&raquo;',
        firstText: 'First',
        lastText: 'Last',
        containerClass: 'pagination-container',
        ulClass: 'pagination',
        liClass: 'page-item',
        activeClass: 'active',
        disabledClass: 'disabled',
        pageNumbers: false,
        insertAfter: ".table"
    });
</script>
<style>
    .pagination-container {
        text-align: center;
        padding: 20px 0;
    }

    .pagination {
        width: fit-content;
        margin: 0 auto;
    }

    .pagination a {
        color: black;
        text-decoration: none;
    }

    .pagination li {
        color: white;
        padding: 0.2rem 0.8rem;
        text-decoration: none;
        border: 1px solid #ddd;
    }

    .pagination .active {
        background-color: #337ab7;
        border: 1px solid #337ab7;
    }

    .active a {
        color: white;
    }

    .disabled a {
        color: darkgrey;
    }

    .pagination li:hover:not(.active) {
        background-color: #ddd;
    }

    .pagination li:first-child {
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
    }

    .pagination li:last-child {
        border-top-right-radius: 5px;
        border-bottom-right-radius: 5px;
    }

</style>
</html>

