<header class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button" data-event=""><i class="fas fa-bars"></i></a>
        </li>
    </ul>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown">
            <a href="javascript:;" data-toggle="dropdown" class="nav-link">
                {{_account['name']}}
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <a href="{{url('worker/reset_pwd')}}" class="dropdown-item">
                    <i class="fas fa-key mr-2"></i>修改密码
                </a>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="{{url('passport/logout')}}" data-event>
                退出
            </a>
        </li>
    </ul>
</header>
