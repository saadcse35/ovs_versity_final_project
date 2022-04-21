<%--
  Created by IntelliJ IDEA.
  User: SoftRithm 02
  Date: 03-Apr-21
  Time: 3:55 PM
--%>

<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>
    <g:layoutTitle default="Online Voting System | Admin Panel"/>
    </title>
    <link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <asset:stylesheet src="fontawesome-free/css/all.min.css"/>
    <asset:stylesheet src="fontawesome-free/css/v4-shims.min.css"/>
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <asset:stylesheet src="tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css"/>
    <asset:stylesheet src="daterangepicker/daterangepicker.css"/>
    <asset:stylesheet src="icheck-bootstrap/icheck-bootstrap.min.css"/>
    <asset:stylesheet src="jqvmap/jqvmap.min.css"/>
    <asset:stylesheet src="adminlte.min.css"/>
    <asset:stylesheet src="overlayScrollbars/css/OverlayScrollbars.min.css"/>

    <asset:stylesheet src="summernote/summernote-bs4.css"/>
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <asset:stylesheet src="back-end.css"/>
    <script type="text/javascript">
        var root = "${request.contextPath}";
    </script>
    <!-- jQuery -->
    <asset:javascript src="jquery/jquery.min.js"/>
    <!-- jQuery UI 1.11.4 -->
    <asset:javascript src="jquery-ui/jquery-ui.min.js"/>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button)
    </script>
    <!-- Bootstrap 4 -->
    <asset:javascript src="bootstrap/js/bootstrap.bundle.min.js"/>
    <!-- ChartJS -->
    <asset:javascript src="chart.js/Chart.min.js"/>
    <!-- Sparkline -->
    <asset:javascript src="sparklines/sparkline.js"/>
    <!-- JQVMap -->
    <asset:javascript src="jqvmap/jquery.vmap.min.js"/>
    <asset:javascript src="jqvmap/maps/jquery.vmap.usa.js"/>
    <!-- jQuery Knob Chart -->
    <asset:javascript src="jquery-knob/jquery.knob.min.js"/>
    <!-- daterangepicker -->
    <asset:javascript src="moment/moment.min.js"/>
    <asset:javascript src="inputmask/min/jquery.inputmask.bundle.min.js"/>
    <asset:javascript src="daterangepicker/daterangepicker.js"/>
    <!-- Tempusdominus Bootstrap 4 -->
    <asset:javascript src="tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"/>
    <!-- Summernote -->
    <asset:javascript src="summernote/summernote-bs4.min.js"/>
    <!-- overlayScrollbars -->
    <asset:javascript src="overlayScrollbars/js/jquery.overlayScrollbars.min.js"/>
    <!-- AdminLTE App -->
    <asset:javascript src="adminlte.js"/>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <asset:javascript src="pages/dashboard.js"/>

    <!-- AdminLTE for demo purposes -->
    <asset:javascript src="demo.js"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datemask').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'});
        });
    </script>
    <g:layoutHead/>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
            </li>
        </ul>
        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
            <li>
                <g:link uri="/" title="Visit Website" target="_blank">
                    <asset:image src="93618.png" style="width:25px; height: 25px"/>
                </g:link>                        &nbsp;
            </li>
            <li>
                <g:link controller="common.reportCenter" class="icon-menu" action="callReport"
                        title="Report Center">
                    <asset:image src="report_center.png" class="rounded-circle" width="25" alt=""/>
                </g:link>
                &nbsp; &nbsp;
            </li>
            <li>
                <g:link controller="authorise" action="logout" title="Log Out">
                    <asset:image src="logout.jpg" style="width:25px; height: 25px"/>
                </g:link>
            </li>

            <!-- Messages Dropdown Menu -->
            %{--<li class="nav-item dropdown">
                            <a class="nav-link" data-toggle="dropdown" href="#">
                                <i class="far fa-comments"></i>
                                <span class="badge badge-danger navbar-badge">3</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                                <a href="#" class="dropdown-item">
                                    <!-- Message Start -->
                                    <div class="media">
                                        <asset:image src="user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle"/>
                                        <div class="media-body">
                                            <h3 class="dropdown-item-title">
                                                Brad Diesel
                                                <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
                                            </h3>
                                            <p class="text-sm">Call me whenever you can...</p>
                                            <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
                                        </div>
                                    </div>
                                    <!-- Message End -->
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item">
                                    <!-- Message Start -->
                                    <div class="media">
                                        <asset:image src="user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3"/>
                                        <div class="media-body">
                                            <h3 class="dropdown-item-title">
                                                John Pierce
                                                <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
                                            </h3>
                                            <p class="text-sm">I got your message bro</p>
                                            <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
                                        </div>
                                    </div>
                                    <!-- Message End -->
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item">
                                    <!-- Message Start -->
                                    <div class="media">
                                        <asset:image src="user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3"/>
                                        <div class="media-body">
                                            <h3 class="dropdown-item-title">
                                                Nora Silvester
                                                <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
                                            </h3>
                                            <p class="text-sm">The subject goes here</p>
                                            <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
                                        </div>
                                    </div>
                                    <!-- Message End -->
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
                            </div>
                        </li>

                        <!-- Notifications Dropdown Menu -->
            <li class="nav-item dropdown">
                            <a class="nav-link" data-toggle="dropdown" href="#">
                                <i class="far fa-bell"></i>
                                <span class="badge badge-warning navbar-badge">15</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                                <span class="dropdown-item dropdown-header">15 Notifications</span>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item">
                                    <i class="fas fa-envelope mr-2"></i> 4 new messages
                                    <span class="float-right text-muted text-sm">3 mins</span>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item">
                                    <i class="fas fa-users mr-2"></i> 8 friend requests
                                    <span class="float-right text-muted text-sm">12 hours</span>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item">
                                    <i class="fas fa-file mr-2"></i> 3 new reports
                                    <span class="float-right text-muted text-sm">2 days</span>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
                            </div>
                        </li>--}%

            %{--<li class="nav-item">
                            <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
                                <i class="fas fa-th-large"></i>
                            </a>
                        </li>--}%

        </ul>
    </nav>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
        <g:link controller="authorise" action="home" class="brand-link">
            <asset:image src="logo-100x100.jpg" alt="Online Voting System Logo"
                         class="brand-image img-circle elevation-3" style="opacity: .8"/>
            <span class="brand-text font-weight-light">Admin Panel</span>
        </g:link>

    <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar user (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="info">
                    <a href="#" class="d-block">
                        ${session["fullName"]}
                    </a>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <g:render template="../partial_templates/admin_menu"/>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
    <g:layoutBody/>


    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <footer class="main-footer">
        <strong>All rights reserved by <strong>Online Voting System</strong>. Designed & Developed by <a
                href="https://saadcse35.github.io/saadahmad/" target="_blank">Saad Ahmad</a>.</strong>
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

</body>
</html>

