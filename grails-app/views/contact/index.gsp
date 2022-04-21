<%--
  Created by IntelliJ IDEA.
  User: saad
  Date: 5/6/2021
  Time: 1:02 PM
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
<section class="page-banner-area page-contact">
    <div class="overlay"></div>
    <!-- Content -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-9 col-md-12 col-12 text-center">
                <div class="page-banner-content">
                    <p class="display-4 font-weight-bold">আপনার কোন প্রশ্ন আছে ?</p>

                    <p>কিভাবে আপনাকে সাহায্য করতে পারি ?</p>
                </div>
            </div>
        </div> <!-- / .row -->
    </div> <!-- / .container -->
</section>


<!-- SECTIONS
    ================================================== -->
<section id="contact-info">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="contact-info-block text-center">
                    <i class="pe-7s-map-marker"></i>
                    <p style="font-weight: bold; font-size: 18; color: black;">ঠিকানা</p>

                    <p class="lead">ঢাকা, বাংলাদেশ</p>
                </div>
            </div>

            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="contact-info-block text-center">
                    <i class="pe-7s-mail"></i>
                    <p style="font-weight: bold; font-size: 18; color: black;">ই-মেইল</p>

                    <a href="mailto:saad.cse35@gmail.com">
                        <p class="lead">saad.cse35@gmail.com</p>
                    </a>

                </div>
            </div>

            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="contact-info-block text-center">
                    <i class="pe-7s-phone"></i>
                    <p style="font-weight: bold; font-size: 18; color: black;">ফোন নাম্বার</p>

                    %{--<p class="lead">+8801755969477</p>--}%
                    <a href="tel:+8801755969477">
                        <p class="lead">+8801755969477</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section" id="contact">
    <div class="container">
        <div class="row mb-4">
            <div class="col-md-8 col-lg-6">
                <p>আমাদেরকে বার্তা পাঠান</p>
                <!-- Heading -->
                <p class="section-title mb-2 ">
                    আপনার সম্পর্কে আমাদেরকে বলুন
                </p>

                <!-- Subheading -->
                %{--<p class="mb-5 ">
                    Whether you have questions or you would just like to say hello, contact us.
                </p>--}%

            </div>
        </div> <!-- / .row -->

        <div class="row">
            <div class="col-lg-6">
                <!-- form message -->
                <div class="row">
                    <div class="col-12">
                        <div class="alert alert-success contact__msg" style="display: none" role="alert">
                            Your message was sent successfully.
                        </div>
                    </div>
                </div>
                <!-- end message -->
                <!-- Contacts Form -->
                <form class="contact_form" action="mail.php">
                    <div class="row">
                        <!-- Input -->
                        <div class="col-sm-6 mb-6">
                            <div class="form-group">
                                %{--<label class="h6 small d-block text-uppercase">
                                    Your name
                                    <span class="text-danger">*</span>
                                </label>--}%

                                <div class="input-group">
                                    <input class="form-control" name="name" id="name" required="" placeholder="আপনার নাম"
                                           type="text">
                                </div>
                            </div>
                        </div>
                        <!-- End Input -->

                        <!-- Input -->
                        <div class="col-sm-6 mb-6">
                            <div class="form-group">
                                %{--<label class="h6 small d-block text-uppercase">
                                    Your email address
                                    <span class="text-danger">*</span>
                                </label>--}%

                                <div class="input-group ">
                                    <input class="form-control" name="email" id="email" required=""
                                           placeholder="আপনার ইমেইল" type="email">
                                </div>
                            </div>
                        </div>
                        <!-- End Input -->

                        <div class="w-100"></div>

                        <!-- Input -->
                        <div class="col-sm-6 mb-6">
                            <div class="form-group">
                                %{--<label class="h6 small d-block text-uppercase">
                                    Subject
                                    <span class="text-danger">*</span>
                                </label>--}%

                                <div class="input-group">
                                    <input class="form-control" name="subject" id="subject" required=""
                                           placeholder="বিষয়" type="text">
                                </div>
                            </div>
                        </div>
                        <!-- End Input -->

                        <!-- Input -->
                        <div class="col-sm-6 mb-6">
                            <div class="form-group">
                                %{--<label class="h6 small d-block text-uppercase">
                                    Your Phone Number
                                    <span class="text-danger">*</span>
                                </label>--}%

                                <div class="input-group ">
                                    <input class="form-control" id="phone" name="phone" required=""
                                           placeholder="আপনার ফোন নাম্বার" type="text">
                                </div>
                            </div>
                        </div>
                        <!-- End Input -->
                    </div>

                    <!-- Input -->
                    <div class="form-group mb-5">
                        %{--<label class="h6 small d-block text-uppercase">
                            How can we help you?
                            <span class="text-danger">*</span>
                        </label>--}%

                        <div class="input-group">
                            <textarea class="form-control" rows="4" name="message" id="message" required=""
                                      placeholder="আপনার বার্তা"></textarea>
                        </div>
                    </div>
                    <!-- End Input -->

                    <div class="">
                        <input name="submit" type="submit" class="btn btn-primary btn-circled" value="বার্তা প্রেরন করুন">

                        %{--<p class="small pt-3">We'll get back to you in 1-2 business days.</p>--}%
                    </div>
                </form>
                <!-- End Contacts Form -->
            </div>

            <div class="col-lg-6 col-md-6">
                <!-- START MAP -->
                <div>
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d233668.38703802988!2d90.27923923029098!3d23.780573257422205!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755b8b087026b81%3A0x8fa563bbdd5904c2!2sDhaka!5e0!3m2!1sen!2sbd!4v1635232875349!5m2!1sen!2sbd" width="600" height="400" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
                <!-- END MAP -->
            </div>
        </div>
    </div>
</section>
</body>
</html>