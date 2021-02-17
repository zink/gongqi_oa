{{content_header(['title':title])}}
{{content_body()}}
    <div class="card card-primary card-outline card-outline-tabs">
        <div class="card-header p-0 border-bottom-0">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="pill" href="#J_opportunity_basic" role="tab" aria-controls="J_opportunity_basic" aria-selected="true">
                        基本信息
                    </a>
                </li>
                {%if opportunity%}
                <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#J_opportunity_job" role="tab" aria-controls="J_opportunity_job" aria-selected="false">
                        跟踪情况
                    </a>
                </li>
                {%endif%}
            </ul>
        </div>
        <div class="tab-content">
            <div class="tab-pane active" id="J_opportunity_basic">
                {{partial('opportunity/_basic')}}
            </div>
            {%if opportunity%}
            <div class="tab-pane" id="J_opportunity_job">
                {{partial('opportunity/_track')}}
            </div>
            {%endif%}
        </div>
    </div>
{{end_content_body()}}
<!-- /.content -->
