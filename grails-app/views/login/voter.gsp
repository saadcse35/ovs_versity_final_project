<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="extraPages">
    <title>Online Voting System | Log In</title>
</head>
<body class="hold-transition login-page">
<p class="login-box-msg" style="font-size:16px;">আপনার ইউজার নেম ও পাসওয়ার্ড দিন</p>
<g:form action="authenticateUser" method="post">
    <g:if test="${redirectUrl != null}">
        <g:hiddenField name="redirectUrl" value="${redirectUrl}"/>
    </g:if>
    <div class="input-group mb-3">
        <input type="email" name="username" class="form-control" placeholder="ফোন / ইমেইল">
        <div class="input-group-append">
            <div class="input-group-text">
                <span class="fas fa-envelope"></span>
            </div>
        </div>
    </div>
    <div class="input-group mb-3">
        <input type="password" name="password" class="form-control" placeholder="পাসওয়ার্ড">
        <div class="input-group-append">
            <div class="input-group-text">
                <span class="fas fa-lock"></span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <input type="submit" class="btn btn-primary btn-block" value="লগইন"/>
        </div>
    </div>
</g:form>

<br/>
<p class="mb-1">
    <g:link action="forgotPassword">পাসওয়ার্ড ভুলে গেছেন? ক্লিক করুন</g:link>
</p>
</body>
</html>