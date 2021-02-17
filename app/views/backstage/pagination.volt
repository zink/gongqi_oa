{%if last%}
<ul class="pagination pagination-sm m-0 float-right" id="J_{{pagination_id}}">
    <li class="page-item"><a class="page-link" href="{{first_url}}" data-page=1>第一页</a></li>
    <li class="page-item"><a class="page-link" href="{{prev_url}}" data-page={{prev}}>«</a></li>
    <li class="page-item disabled">
    <span class="page-link">
    {{current}}
    </span>
    </li>
    <li class="page-item"><a class="page-link" href="{{next_url}}">»</a></li>
    <li class="page-item"><a class="page-link" href="{{last_url}}" data-page={{last}}>最后一页</a></li>
</ul>
{%if custom%}
<script>
    (function(){
        $('#J_{{pagination_id}}').on('click','a',function(e){
            e.preventDefault();
            e.stopPropagation();
            $('{{custom}}').data('pagination-callback')({
                'url':$(this).prop('href'),
                'page':$(this).data('page')
            });
        });
    })();
</script>
{%endif%}
{%endif%}
