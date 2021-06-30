{{content_header(['title':title])}}
{{content_body()}}
    <div class="card card-primary card-outline card-outline-tabs">
        <div class="card-header p-0 border-bottom-0">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="pill" href="#J_order_basic" role="tab" aria-controls="J_order_basic" aria-selected="true">
                        基本信息
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#J_order_bill" role="tab" aria-controls="J_order_job" aria-selected="false">
                        账单信息
                    </a>
                </li>
            </ul>
        </div>
        <div class="tab-content">
            <div class="tab-pane active" id="J_order_basic">
                {{partial('order/_basic')}}
            </div>
            <div class="tab-pane" id="J_order_detail">
                {{partial('order/_detail')}}
            </div>
            <div class="tab-pane" id="J_order_bill">
                {{partial('order/_bill')}}
            </div>
        </div>
    </div>
{{end_content_body()}}
<!-- /.content -->
