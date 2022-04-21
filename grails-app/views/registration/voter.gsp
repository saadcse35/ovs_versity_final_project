<%--
  Created by IntelliJ IDEA.
  User: saad
  Date: 10/23/2021
  Time: 12:08 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="frontEnd/main">
    <title>অনলাইন ভোটিং সিস্টেম | ভোটার রেজিষ্ট্রেশন</title>

</head>

<body>

<section class="bg-grey pt-6">
    <div class="container">
        <div class="row justy-content-center">
            <div class="col-lg-12 col-sm-6 col-md-6">
                <div class="text-center feature-block">
                    <div class="card">
                        <p class="card-header" style="background-color: #21c87a; color: white;">ব্যাক্তিগত তথ্য</p>

                        <div class="card-body">
                            %{--<h5 class="card-title">Special title treatment</h5>--}%
                            <form>
                                <div class="row" >
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="আপনার নাম">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="জাতিয় পরিচয়পত্র নাম্বার">
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="মোবাইল নাম্বার">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="ই-মেইল (যদি থাকে)">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="পাসওয়ার্ড">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="নিশ্চিতকরন পাসওয়ার্ড">
                                    </div>
                                </div>

                                <div class="row">

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="জন্ম তারিখ">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="শিক্ষাগত যোগ্যতা">
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="লিঙ্গ">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="রক্তের গ্রুপ">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <br>

                    <div class="card">
                        <p class="card-header" style="background-color: #21c87a; color: white;">পারিবারিক তথ্য</p>

                        <div class="card-body">
                            %{--<h5 class="card-title">Special title treatment</h5>--}%
                            <form>
                                <div class="row" >
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="পিতার নাম">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="মাতার নাম">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="স্বামী / স্ত্রীর নাম (যদি থাকে)">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <br>

                    <div class="card">
                        <p class="card-header" style="background-color: #21c87a; color: white;">স্থায়ী ঠিকানা</p>

                        <div class="card-body">
                            %{--<h5 class="card-title">Special title treatment</h5>--}%
                            <form>
                                <div class="row" >
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="দেশ">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="বিভাগ">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="জেলা">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="থানা">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <br>

                    <div class="card">
                        <p class="card-header" style="background-color: #21c87a; color: white;">বর্তমান ঠিকানা</p>

                        <div class="card-body">
                            %{--<h5 class="card-title">Special title treatment</h5>--}%
                            <form>
                                <div class="row" >
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="দেশ">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="বিভাগ">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="জেলা">
                                    </div>

                                    <div class="col-lg-6 col-md-5 ptb-50 form-group">
                                        <input type="text" class="form-control" placeholder="থানা">
                                    </div>
                                </div>
                                <hr>

                                <button type="button" class="btn btn-warning" style="font-size: 16;">সাবমিট করুন</button>
                                <hr>
                            </form>
                        </div>
                    </div>



                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>