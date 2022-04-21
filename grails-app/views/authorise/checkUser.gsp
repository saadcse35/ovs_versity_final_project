<!doctype html>
<html lang='en'>
    <head>
        <meta name="layout" content="extraPages"/>
        <title>Online Voting System || Access Confirm</title>
    </head>
    <body class="hold-transition login-page">
        <g:form class='form-auth-small' action='confirmUser' method="post">
            <g:if test="${redirectUrl != null}">
                <g:hiddenField name="redirectUrl" value="${redirectUrl}"/>
            </g:if>
            <div class='form-group'>
                <label for='authCode' class='control-label sr-only'>Access Code</label>
                <input type='text' name="authCode" required="required" class='form-control' id='authCode' value=''
                       placeholder="Access Code" maxlength="8" minlength="8">
            </div>
            <button type='submit' class='btn btn-primary btn-lg btn-block to-disable'>CONFIRM</button>
        </g:form>
    </body>
</html>

