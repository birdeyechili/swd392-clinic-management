<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="wrapper">
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
        <div class="container">

            <a href="" class="navbar-brand">
                <img src="<%=request.getContextPath()%>/img/FPT.jpg" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8; height: 35px">
                <span class="brand-text font-weight-light">FPT Project</span>
            </a>
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <c:if test = "${sessionScope.user != null}">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                    </li>
                </c:if>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="home" class="nav-link">Home</a>
                </li>
            </ul>

            <c:if test = "${sessionScope.user == null}">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item" style="padding-right: 10px;">
<%--                        <a href="login" ><button type="button" class="btn btn-block btn-light" >Login</button></a>--%>
                        <a href="authentication" ><button type="button" class="btn btn-block btn-light" >Login</button></a>
                    </li>
                    <li class="nav-item">
                        <a href="registration"><button type="button" class="btn btn-block btn-light" >Registration</button></a>
                    </li>
                </ul>
            </c:if>
            <c:if test = "${sessionScope.user != null}">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown show" style="padding-right: 10px;">
                        <a href="#" class="d-block nav-link" data-toggle="dropdown" aria-expanded="true" style="padding-top: 5px;font-size: 20px; padding-right: 10px;color: #212529">${sessionScope.user.fullName}
                        </a>
                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="left: inherit; right: 0px;">
                            <span class="dropdown-item dropdown-header">User features</span>
                            <div class="dropdown-divider"></div>
                            <a href="UserProfileViewServlet" class="dropdown-item">
                                <i class="bi bi-file-person-fill" style="font-size: 21px;"></i> User Profile
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="UserPasswordServlet" class="dropdown-item">
                                <i class="bi bi-file-earmark-lock2-fill" style="font-size: 21px;"></i> Change Password
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="LogOutServlet" class="dropdown-item">
                                <i class="bi bi-box-arrow-right" style="font-size: 21px;"></i>  Log Out
                            </a>
                        </div>
                    </li>
                </ul>
            </c:if>


        </div>
    </nav>
    <!-- /.navbar -->

    <aside class="main-sidebar elevation-4 sidebar-light-navy">
        <!-- Brand Logo -->
        <a href="" class="brand-link">
            <img src="<%=request.getContextPath()%>/img/FPT.jpg" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
            <span class="brand-text font-weight-light">FPT Project</span>
        </a>

        <!-- Sidebar -->
        <div class="sidebar os-theme-dark">
            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                    <!-- Add icons to the links using the .nav-icon class
                         with font-awesome or any other icon font library -->
                    <li class="nav-item menu-open">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-tachometer-alt"></i>
                            <p>
                                Dashboard
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <!--Admin-->
                            <c:if test = "${sessionScope.user.role == 0}">
                                <li class="nav-item">
                                    <a href="appointment" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Appointment List </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="recordservlet" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Record List </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="userlist" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> User List </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="request" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Request Appointment </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="prescriptionList" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Prescription List </p>
                                    </a>
                                </li>
                            </c:if>
                            <!--Admin-->
                            <!--Doctor-->
                            <c:if test = "${sessionScope.user.role == 2}">
                                <li class="nav-item">
                                    <a href="appointment" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Appointment List </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="recordservlet" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Record List </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="request" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Request Appointment </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="prescriptionList" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Prescription List </p>
                                    </a>
                                </li>
                            </c:if>
                            <!--Doctor-->
                            <!--Patient-->
                            <c:if test = "${sessionScope.user.role == 1}">
                                <li class="nav-item">
                                    <a href="appointment" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Appointment List </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="recordservlet" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Record List </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="request" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Request Appointment </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="prescriptionList" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p> Prescription List </p>
                                    </a>
                                </li>
                            </c:if>
                            <!--Patient-->
                        </ul>
                    </li>

                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>

    <!-- Title -->
    <div class="content-wrapper" style="min-height: 632px;">
        <div class="content">
            <div class="container" style="padding-bottom: 16px; padding-top: 10px">