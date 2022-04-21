<%--
  Created by IntelliJ IDEA.
  User: saad
  Date: 10/23/2021
  Time: 12:25 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="frontEnd/main">
    <title>অনলাইন ভোটিং সিস্টেম | প্রার্থী</title>
</head>

<body>

<section class="section" id="process">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 text-center">
                <div class="section-heading">
                    <!-- Heading -->
                    <p class="section-title">
                        আপনি কি বাংলাদেশ সংসদ নির্বাচনে প্রার্থী হতে চান ?
                    </p>

                    <!-- Subheading -->
                    <p style="font-size: 20;">
                        তাহলে নিম্নলিখিত শর্তাবলী পূরন সাপেক্ষে আবেদন করুন
                    </p>

                </div>
            </div>
        </div> <!-- / .row -->

        <div class="row justify-content-center">
            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="process-block">
                    <img src="images/process/process-1.jpg" alt="" class="img-fluid">

                    <h3>Project Research</h3>

                    <p>Nihil facere delectus eaque aut possimus nobis laudantium reprehenderit.</p>
                </div>
            </div>

            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="process-block">
                    <img src="images/process/process-2.jpg" alt="" class="img-fluid">

                    <h3>Project demostration</h3>

                    <p>Nihil facere delectus eaque aut possimus nobis laudantium reprehenderit.</p>
                </div>
            </div>

            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="process-block">
                    <img src="images/process/process-3.jpg" alt="" class="img-fluid">

                    <h3>Development & delivery</h3>

                    <p>Nihil facere delectus eaque aut possimus nobis laudantium reprehenderit.</p>
                </div>
            </div>


            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="process-block">
                    <g:link controller="registration" action="candidate" type="button" class="btn btn-warning "
                            style="font-size: 16;">আবেদন করুন</g:link>
                
                </div>
            </div>
        </div>

    </div>

</section>

</body>
</html>