<%--
  Created by IntelliJ IDEA.
  User: saad
  Date: 5/5/2021
  Time: 4:50 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="frontEnd/main">
    <title>Online Voting System</title>
</head>

<body>

<!-- HERO
    ================================================== -->
<section class="banner-area py-7">
    <!-- Content -->
    <div class="container">
        <div class="row  align-items-center">
            <div class="col-md-12 col-lg-7 text-center text-lg-left">
                <div class="main-banner">
                    <!-- Heading -->
                    <p class="display-4 mb-4 font-weight-normal">
                       প্রতিটি ভোট গুরুত্বপূর্ণ
                    </p>

                    <!-- Subheading -->
                    <p class="lead mb-4">
                        অনলাইন ভোটিং সিস্টেম, আরো বেশি ভোটারদের সম্পৃক্ত করা, আরো ভালো ভোট দেওয়ার অভিজ্ঞতা তৈরি করা, সময় বাচানো এবং নির্বাচনের নিরাপত্তা নিশ্চিত করার জন্য সবচেয়ে সহজ পদ্ধতি।

                    </p>

                    <!-- Button -->
                    <p class="mb-0">
                        <g:link controller="applyVote" action="index" class="btn btn-primary btn-circled" style="font-size: 16;">
                            ভোট দিন
                        </g:link>
                    </p>
                </div>
            </div>

            <div class="col-lg-5 d-none d-lg-block">
                <div class="banner-img-block">
                    <asset:image src="frontEnd/General-Election-piece.png" alt="banner-img" class="img-fluid"/>
                </div>
            </div>
        </div> <!-- / .row -->
    </div> <!-- / .container -->
</section>


<section class="section bg-grey" id="feature">
    <div class="container">
        <div class="row justy-content-center">
            <div class="col-lg-3 col-sm-6 col-md-6">
                <div class="text-center feature-block">
                    <div class="img-icon-block mb-4">
                        <i class="ti-thumb-up"></i>
                    </div>
                    <p class="mb-2" style="font-size: 18; font-weight: bold;">ভোট দেওয়ার সঠিক জায়গা</p>
                    <p>আমাদের দল আপনাকে ভোট দেওয়ার সঠিক দিকনির্দেশনা দিবে।</p>
                </div>
            </div>

            <div class="col-lg-3 col-sm-6 col-md-6">
                <div class="text-center feature-block">
                    <div class="img-icon-block mb-4">
                        <i class="ti-face-smile"></i>
                    </div>
                    <p class="mb-2" style="font-size: 18; font-weight: bold;">গ্রাহকের সন্তুষ্টি</p>
                    <p>আমরা আমাদের সেবা দ্বারা গ্রাহকদের সন্তুষ্টি অর্জন করতে বদ্ধপরিকর।</p>
                </div>
            </div>

            <div class="col-lg-3 col-sm-6 col-md-6">
                <div class="text-center feature-block">
                    <div class="img-icon-block mb-4">
                        <i class="ti-cup"></i>
                    </div>
                    <p class="mb-2" style="font-size: 18; font-weight: bold;">অন্যদের তুলনার শ্রেষ্ট</p>
                    <p>আমরা বাজারের অন্যান্য সেবাদানকারী প্রতিষ্ঠানের তুলনায় শ্রেষ্ঠ</p>
                </div>
            </div>

            <div class="col-lg-3 col-sm-6 col-md-6">
                <div class="text-center feature-block">
                    <div class="img-icon-block mb-4">
                        <i class="ti-support"></i>
                    </div>
                    <p class="mb-2" style="font-size: 18; font-weight: bold;">সর্বোচ্চ নিরাপত্তা</p>
                    <p>আপনার ভোটকে নিরাপদ রাখতা আমরা বদ্ধপরিকর।</p>
                </div>
            </div>
        </div>
    </div> <!-- / .container -->
</section>

</body>
</html>