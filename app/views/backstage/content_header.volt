<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>
                    {{title}}
                    <small>{{sub_title}}</small>
                </h1>
            </div>
            <div class="col-sm-6">
            {%if breadcrumb%}
                <ol class="breadcrumb float-sm-right">
                    {%for item in breadcrumb%}
                    {%if item == end(breadcrumb)%}
                    <li class="breadcrumb-item active">
                    {{item['name']}}
                    </li>
                    {%else%}
                    <li class="breadcrumb-item active">
                    <a href="{{item['url']?url(item['url']):'javascript:;'}}">{{item['name']}}</a>
                    </li>
                    {%endif%}
                    {%endfor%}
                </ol>
            {%endif%}
            </div>
        </div>
    </div><!-- /.container-fluid -->
</section>
