<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Prescription Create</title>
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
                    <h1 class="text-uppercase card-title">Prescription Create</h1>
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
                        <form action="createprescription" method="post" id="form">
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-4" \>
                                        <label>Appointment</label>
                                        <select class="form-control selectpicker" id="appointmentId" name="appointmentId"
                                                style="width: 100%; margin-left: 0px">
                                            <c:forEach items="${appointmentList}" var="a">
                                                <option value="${a.appointId}">${a.time}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Prescription</label>
                                        <input class="form-control" id="pres" type="text" name="pres">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Note</label>
                                        <input class="form-control" id="note" type="text" name="note">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-8 ">
                                        <label>Status</label> <br/>
                                        <select class="form-control selectpicker col-4" name="status"
                                                style="height: 40px;margin-right: 3px;">
                                            <c:forEach items="${statusList}" var="s" begin="0" varStatus="i">
                                                <option value="${i.count - 1}">${s}</option>
                                            </c:forEach>
                                        </select>
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

<script>
    let message = "${param.message}";
    if(message!=="") alert(message);
</script>

<%@include file="../home/Footer.jsp" %>
</body>
</html>
