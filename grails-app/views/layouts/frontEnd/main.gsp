<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="it">
    <meta name="keywords" content="Rapoo,creative, agency, startup,onepage, clean, modern,business, company,it">

    <link rel="icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    <title>অনলাইন ভোটিং সিস্টেম</title>

    <!-- bootstrap.min css -->
    <asset:stylesheet src="frontEnd/bootstrap.min.css"/>
    <!-- Animate Css -->
    <asset:stylesheet src="frontEnd/animate.css"/>
    <!-- Icon Font css -->
    <asset:stylesheet src="frontEnd/all.css"/>
    <asset:stylesheet src="frontEnd/Pe-icon-7-stroke.css"/>
    <!-- Themify icon Css -->
    <asset:stylesheet src="frontEnd/themify-icons.css"/>
    <!-- Slick Carousel CSS -->
    <asset:stylesheet src="frontEnd/slick.css"/>
    <asset:stylesheet src="frontEnd/slick-theme.css"/>

    <!-- Main Stylesheet -->
    <asset:stylesheet src="frontEnd/style.css"/>
    <asset:stylesheet src="front-end.css"/>
    <g:layoutHead/>

</head>


<body id="top-header">

<!-- LOADER TEMPLATE -->
<div id="page-loader">
    <div class="loader-icon fa fa-spin colored-border"></div>
</div>
<!-- /LOADER TEMPLATE -->

<div class="top-bar bg-dark " id="top-bar">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 col-md-6">
                <div class="top-bar-left text-white">
                    <i class="fa fa-map-marker"></i>
                    <span class="ml-2">ঢাকা, বাংলাদেশ</span>
                </div>
            </div>

            <div class="col-lg-4 ml-lg-auto col-md-6">
                <ul class="d-flex list-unstyled header-socials float-lg-right">
                    <li><a href="https://web.facebook.com/saad.cse35/" target="_blank"><i class="fab fa-facebook-f"></i>
                    </a></li>
                    <li><a href="https://twitter.com/saadcse35" target="_blank"><i class="fab fa-twitter"></i></a></li>
                    %{--<li><a href="#"> <i class="fab fa-pinterest-p"></i></a></li>--}%
                    <li><a href="https://www.linkedin.com/in/saadcse35/" target="_blank"><i class="fab fa-linkedin"></i>
                    </a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="logo-bar d-none d-md-block d-lg-block bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <div class="logo d-none d-lg-block">
                    <!-- Brand -->
                    <g:link class="navbar-brand" style="font-size: 30;" uri="/">
                        অনলাইন ভোটিং সিস্টেম
                    </g:link>
                </div>
            </div>

            <div class="col-lg-8 justify-content-end ml-lg-auto d-flex col-12 col-md-12 justify-content-md-center">
                <div class="top-info-block d-inline-flex">
                    <div class="icon-block">
                        <i class="ti-mobile"></i>
                    </div>

                    <div class="info-block">
                        <a href="tel:+8801755969477">
                            <h5 class="font-weight-500">+8801755969477</h5>

                            <p>কল করুন</p>
                        </a>

                    </div>
                </div>

                <div class="top-info-block d-inline-flex">
                    <div class="icon-block">
                        <i class="ti-email"></i>
                    </div>

                    <div class="info-block">
                        <a href="mailto:saad.cse35@gmail.com">
                            <h5 class="font-weight-500">saad.cse35@gmail.com</h5>

                            <p>ই-মেইল করুন</p>
                        </a>

                    </div>
                </div>

                <div class="top-info-block d-inline-flex">
                    <div class="icon-block">
                        <i class="ti-time"></i>
                    </div>

                    <div class="info-block">
                        <h5 class="font-weight-500">রবি-বৃহ ৯.০০-৫.০০</h5>

                        <p>শুক্র, শনি বন্ধ</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- NAVBAR
    ================================================= -->
<div class="main-navigation" id="mainmenu-area">
    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary main-nav navbar-togglable rounded-radius"
             style="font-size: 16;">

            <g:link controller="home" action="index" class="navbar-brand d-lg-none d-block">
                অনলাইন ভোটিং সিস্টেম
            </g:link>
            <!-- Toggler -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
                    aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="fa fa-bars"></span>
            </button>

            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <!-- Links -->
                <ul class="navbar-nav ">
                    <li class="nav-item">
                        <g:link uri="/" class="nav-link js-scroll-trigger">
                            মূলপাতা
                        </g:link>

                    </li>

                    <li class="nav-item ">
                        <g:link controller="login" action="voter" class="nav-link">
                            ভোটার লগইন
                        </g:link>
                    </li>

                    <li class="nav-item ">
                        <g:link controller="aboutUs" action="index" class="nav-link js-scroll-trigger">
                            আমাদের সম্পর্কে
                        </g:link>
                    </li>

                    <li class="nav-item ">
                        <g:link controller="contact" action="index" class="nav-link">
                            যোগাযোগ করুন
                        </g:link>
                    </li>
                </ul>

                <ul class="ml-lg-auto list-unstyled m-0">
                    <li><g:link controller="registration" action="voter"
                                class="btn btn-white btn-circled" style="font-size: 16">ভোটার নিবন্ধন করুন</g:link></li>
                </ul>
            </div> <!-- / .navbar-collapse -->
        </nav>
    </div> <!-- / .container -->
</div>


<g:layoutBody/>

<footer class="section " id="footer">
    <div class="overlay footer-overlay"></div>
    <!--Content -->
    <div class="container">
        <div class="row justify-content-start">
            <div class="col-lg-4 col-sm-12">
                <div class="footer-widget">
                    <!-- Brand -->
                    <g:link uri="/" class="footer-brand text-white">
                        অনলাইন ভোটিং সিস্টেম
                    </g:link>
                    <p>অনলাইন ভোটিং সিস্টেম, আরো বেশি ভোটারদের সম্পৃক্ত করা, আরো ভালো ভোট দেওয়ার অভিজ্ঞতা তৈরি করা, সময় বাচানো এবং নির্বাচনের নিরাপত্তা নিশ্চিত করার জন্য সবচেয়ে সহজ পদ্ধতি।</p>
                </div>
            </div>

            <div class="col-lg-2 col-sm-6">
                <div class="footer-widget">
                    <g:link uri="/">
                        <p style="font-size: 24; color: white;">মূলপাতা</p>
                    </g:link>

                <!-- Links -->
                    <ul class="footer-links ">
                        <li>
                            <g:link controller="aboutUs" action="index">
                                আমাদের সম্পর্কে
                            </g:link>
                        </li>
                        <li>
                            <g:link controller="contact" action="index">
                                যোগাযোগ করুন
                            </g:link>
                        </li>
                        <li>
                            <g:link controller="registration" action="voter">
                                ভোটার নিবন্ধন
                            </g:link>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-2 col-sm-6">
                <div class="footer-widget">
                    <g:link>
                        <p style="font-size: 24; color: white;">গুরুত্বপূর্ণ লিংক</p>
                    </g:link>

                <!-- Links -->
                    <ul class="footer-links ">
                        <li>
                            <g:link>
                                ভোট দেওয়ার নিয়মাবলী
                            </g:link>
                        </li>
                        <li>
                            <g:link>
                                ফলাফল
                            </g:link>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-2 col-sm-6">
                <div class="footer-widget">
                    <p style="font-size: 24; color: white;">সামাজিক মাধ্যম</p>
                    <!-- Links -->
                    <ul class="list-unstyled footer-links">
                        <li><a href="https://web.facebook.com/saad.cse35/" target="_blank"><i
                                class="fab fa-facebook-f"></i>ফেসবুক</a></li>
                        <li>
                            <a href="https://twitter.com/saadcse35" target="_blank"><i class="fab fa-twitter"></i>টুইটার
                            </a></li>
                        %{--<li><a href="#"><i class="fab fa-pinterest-p"></i>Pinterest
                        </a></li>--}%
                        <li><a href="https://www.linkedin.com/in/saadcse35/" target="_blank"><i
                                class="fab fa-linkedin"></i>লিংকডইন
                        </a></li>
                        %{--<li><a href="#"><i class="fab fa-youtube"></i>YouTube
                        </a></li>--}%
                    </ul>
                </div>
            </div>

            <div class="col-lg-2 col-sm-6 pt-4">
                <div class="footer-widget">
                    <g:link controller="login" action="voter" type="button" class="btn btn-outline-success" style="font-size: 18;  color: white;">
                        ভোটার লগইন
                    </g:link>

                </div>
            </div>

        </div> <!-- / .row -->


        <div class="row text-right pt-5">
            <div class="col-lg-12">
                <!-- Copyright -->
                <p class="footer-copy ">
                    &copy; কপিরাইট <span class="current-year">সাদ আহমাদ</span> সর্বস্বত্ব সংরক্ষিত.
                </p>
            </div>
        </div> <!-- / .row -->
    </div> <!-- / .container -->
</footer>


<!--  Page Scroll to Top  -->

<a class="scroll-to-top js-scroll-trigger" href="#top-header">
    <i class="fa fa-angle-up"></i>
</a>





<!--
    Essential Scripts
    =====================================-->


<!-- Main jQuery -->
<asset:javascript src="frontEnd/jquery.min.js"/>
<!-- Bootstrap 3.1 -->
<asset:javascript src="frontEnd/popper.min.js"/>
<asset:javascript src="frontEnd/bootstrap.min.js"/>
<!-- Slick Slider -->
<asset:javascript src="frontEnd/slick.min.js"/>
<asset:javascript src="js/jquery.easing.1.3.js"/>
<!-- Map Js -->
<asset:javascript src="frontEnd/gmap3.min.js"/>
%{--<asset:javascript src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwIQh7LGryQdDDi-A603lR8NqiF3R_ycA"/>--}%

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwIQh7LGryQdDDi-A603lR8NqiF3R_ycA"></script>


<asset:javascript src="frontEnd/contact.js"/>
<asset:javascript src="frontEnd/theme.js"/>

</body>
</html>
