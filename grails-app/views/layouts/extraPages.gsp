<%@ page contentType='text/html, charset=UTF-8' %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'>
        <meta name="description" content="Online Voting System Admin || Devleoped by Saad Ahmad">
        <meta name="author" content="Saad Ahmad">
        <title>
            <g:layoutTitle default="Online Voting System"/>
        </title>
        <link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
        <asset:stylesheet src="fontawesome-free/css/all.min.css"/>
        <asset:stylesheet src="front-end.css"/>
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <asset:stylesheet src="icheck-bootstrap/icheck-bootstrap.min.css"/>
        <asset:stylesheet src="adminlte.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
        <g:layoutHead/>
    </head>
    <body class="hold-transition login-page">
        <div class="login-box">
            <div class="login-logo">
                <a href="/">
                    <asset:image src="logo-100x100.jpg"/>
                </a>
            </div>

            <div class="card">
                <div class="card-body login-card-body">
                    <g:if test="${flash.error}">
                        <div class="alert alert-danger" style="display: block">${flash.error}</div>
                    </g:if>
                    <g:elseif test="${flash.success}">
                        <div class="alert alert-success" style="display: block">${flash.success}</div>
                    </g:elseif>
                    <g:layoutBody/>
                </div>
            </div>
        </div>

        <asset:javascript src="jquery/jquery.min.js"/>
        <asset:javascript src="bootstrap/js/bootstrap.bundle.min.js"/>
        <asset:javascript src="adminlte.min.js"/>
    </body>
</html>