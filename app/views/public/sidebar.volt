<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="index3.html" class="brand-link">
        <span class="brand-text font-weight-light">共启科技</span>
    </a>
    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column nav-child-indent" data-widget="treeview" role="menu" data-accordion="false">
                <li class="nav-item">
                    <a href="{{url('index')}}" class="nav-link active">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>
                            总览
                        </p>
                    </a>
                </li>
                {%if permission('department',true)%}
                <li class="nav-header">
                    公司内部管理
                </li>
                <li class="nav-item has-treeview">
                    <a href="#" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-sitemap"></i>
                        <p>
                            公司组织
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        {%if permission('department-index')%}
                        <li class="nav-item">
                            <a href="{{url('department')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>组织架构</p>
                            </a>
                        </li>
                        {%endif%}
                        {%if permission('rank-index')%}
                        <li class="nav-item">
                            <a href="{{url('rank')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>职级职等</p>
                            </a>
                        </li>
                        {%endif%}
                        {%if permission('worker-index')%}
                        <li class="nav-item">
                            <a href="{{url('worker')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>员工列表</p>
                            </a>
                        </li>
                        {%endif%}
                    </ul>
                </li>
                {%endif%}
                {%if permission('business',true)%}
                <li class="nav-header">
                    业务管理
                </li>
                <li class="nav-item has-treeview">
                    <a href="#" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-yen-sign"></i>
                        <p>
                            销售
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        {%if permission('opportunity-index')%}
                        <li class="nav-item">
                            <a href="{{url('opportunity')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>全部销售线索</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="{{url('opportunity/index?status=dead')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>作废销售线索</p>
                            </a>
                        </li>
                        {%endif%}
                        {%if permission('order-index')%}
                        <li class="nav-item">
                            <a href="{{url('order')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>销售订单</p>
                            </a>
                        </li>
                        {%endif%}
                    </ul>
                </li>
                {%if permission('customer-index')%}
                <li class="nav-item has-treeview">
                    <a href="#" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-address-card"></i>
                        <p>
                            客户
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        {%if permission('customer-index')%}
                        <li class="nav-item">
                            <a href="{{url('customer')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>客户列表</p>
                            </a>
                        </li>
                        {%endif%}
                    </ul>
                </li>
                {%endif%}
                {%if permission('idc-index') or permission('ip-index')%}
                <li class="nav-item has-treeview">
                    <a href="#" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-shipping-fast"></i>
                        <p>
                            销售物料
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        {%if permission('idc-index')%}
                        <li class="nav-item">
                            <a href="{{url('idc')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>机房列表</p>
                            </a>
                        </li>
                        {%endif%}
                        {%if permission('ip-index')%}
                        <li class="nav-item">
                            <a href="{{url('ip')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>IP池</p>
                            </a>
                        </li>
                        {%endif%}
                        {%if permission('bandwidth-index')%}
                        <li class="nav-item">
                            <a href="{{url('bandwidth')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>带宽</p>
                            </a>
                        </li>
                        {%endif%}
                    </ul>
                </li>
                {%endif%}
                {%endif%}
                {%if permission('devops',true)%}
                <li class="nav-header">
                    运维管理
                </li>
                {%if permission('up-index')%}
                <li class="nav-item has-treeview">
                    <a href="{{url('up')}}" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-upload"></i>
                        <p>
                            上架管理
                        </p>
                    </a>
                </li>
                {%endif%}
                {%if permission('wo-index')%}
                <li class="nav-item has-treeview">
                    <a href="javascript:;" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-sticky-note"></i>
                        <p>
                            售后工单
                        </p>
                    </a>
                </li>
                <li class="nav-item has-treeview">
                    <a href="#" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-yen-sign"></i>
                        <p>
                            资源管理
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="{{url('ipcm')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>IP</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="{{url('cabinet')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>机柜</p>
                            </a>
                        </li>
                    </ul>
                </li>
                {%endif%}
                {%endif%}
                {%if permission('finance',true)%}
                <li class="nav-header">
                    财务管理
                </li>
                {%if permission('bill-all')%}
                <li class="nav-item has-treeview">
                    <a href="{{url('bill')}}" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-upload"></i>
                        <p>
                            账单列表
                        </p>
                    </a>
                </li>
                {%endif%}
                {%if permission('bill-confirm')%}
                <li class="nav-item has-treeview">
                    <a href="{{url('bill/bill_confirm')}}" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-sticky-note"></i>
                        <p>
                            待确收账单
                        </p>
                    </a>
                </li>
                {%endif%}
                {%if permission('bill-finish')%}
                <li class="nav-item has-treeview">
                    <a href="{{url('bill/bill_finish')}}" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-sticky-note"></i>
                        <p>
                            实收账单
                        </p>
                    </a>
                </li>
                {%endif%}
                {%endif%}
                {%if permission('site',true)%}
                <li class="nav-header">
                    官网管理
                </li>
                <li class="nav-item has-treeview">
                    <a href="#" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-scroll"></i>
                        <p>
                            页面管理
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        {%if permission('site-index')%}
                        <li class="nav-item">
                            <a href="javascript:;" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>栏目列表</p>
                            </a>
                        </li>
                        {%endif%}
                        {%if permission('page-index')%}
                        <li class="nav-item">
                            <a href="javascript:;" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>页面列表</p>
                            </a>
                        </li>
                        {%endif%}
                    </ul>
                </li>
                {%if permission('image-index')%}
                <li class="nav-item">
                    <a href="javascript:;" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-images"></i>
                        <p>
                            图库
                        </p>
                    </a>
                </li>
                {%endif%}
                {%endif%}
                {%if permission('role',true)%}
                <li class="nav-header">
                    系统设置
                </li>
                <li class="nav-item has-treeview">
                    <a href="javascript:;" data-event='true' class="nav-link">
                        <i class="nav-icon fas fa-gamepad"></i>
                        <p>
                            权限管理
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        {%if permission('role-index')%}
                        <li class="nav-item">
                            <a href="{{url('role')}}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>角色列表</p>
                            </a>
                        </li>
                        {%endif%}
                    </ul>
                </li>
                {%endif%}
            </ul>
        </nav>
    </div>
    <!-- /.sidebar -->
</aside>
