<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="extraPages">
        <title>Online Voting System | Log In</title>
    </head>
    <body class="hold-transition login-page">
        <p class="login-box-msg" style="font-size:16px;">PLEASE TYPE USERNAME & PASSWORD</p>
        <g:form action="authenticateUser" method="post">
            <g:if test="${redirectUrl != null}">
                <g:hiddenField name="redirectUrl" value="${redirectUrl}"/>
            </g:if>
            <div class="input-group mb-3">
                <input type="email" name="username" class="form-control" placeholder="Email">
                <div class="input-group-append">
                    <div class="input-group-text">
                        <span class="fas fa-envelope"></span>
                    </div>
                </div>
            </div>
            <div class="input-group mb-3">
                <input type="password" name="password" class="form-control" placeholder="Password">
                <div class="input-group-append">
                    <div class="input-group-text">
                        <span class="fas fa-lock"></span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <input type="submit" class="btn btn-primary btn-block" value="LOG IN"/>
                </div>
            </div>
        </g:form>

        <br/>
        <p class="mb-1">
            <g:link action="forgotPassword">Forgot Password? Click Here</g:link>
        </p>
    </body>
</html>