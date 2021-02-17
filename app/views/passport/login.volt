<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>RCM OA| Log in</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    {{stylesheet_link(assetUri~"plugins/fontawesome-free/css/all.min.css")}}
    {{stylesheet_link(assetUri~"plugins/ionicons/css/ionicons.min.css")}}
    {{stylesheet_link(assetUri~"dist/css/adminlte.min.css")}}
    {{stylesheet_link(assetUri~"plugins/google/css/fonts.css")}}
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <b>RCM OA</b>
    </div>
    <!-- /.login-logo -->
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">{{flash.output()}}</p>

            <form action="{{url('passport/login')}}" method="post">
                <div class="input-group mb-3">
                    {{text_field('username','class':'form-control','required':true,'placeholder':"账号")}}
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    {{password_field('password', 'class':'form-control','required':true,'placeholder':"密码")}}
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    {{text_field('verify_code', 'class':'form-control','required':true,'placeholder':"验证码")}}
                    <div class="input-group-append">
                        <div class="input-group-text" style="padding:0;">
                            <img src="{{url('passport/captcha')}}" title="点击更换验证码" style="height:calc(2.25rem)" onclick="this.src='{{url('passport/captcha')}}?d='+Math.random();">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-8">
                    </div>
                    <!-- /.col -->
                    <div class="col-4">
                        <button type="submit" class="btn btn-primary btn-block">登陆</button>
                    </div>
                    <!-- /.col -->
                </div>
            </form>
        </div>
    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.3 -->
{{javascript_include(assetUri~"plugins/jquery/jquery.min.js")}}
<!-- Bootstrap 3.3.6 -->
{{javascript_include(assetUri~"plugins/bootstrap/js/bootstrap.bundle.min.js")}}
<!-- iCheck -->
{{javascript_include(assetUri~"dist/js/adminlte.min.js")}}
</body>
</html>
