{%if !js_mode%}
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
        {{title}}
        </h3>
    </div>
    <div class="card-body">
        <div class="" id="J_{{input_id}}_selected"></div>
    </div>
    <div class="card-footer">
        <button class="btn btn-primary btn-sm btn-block input-object" id="{{input_id}}">
            <i class="fa fa-plus"></i>
        </button>
    </div>
</div>
<script>
(function(){
    $('#J_{{input_id}}_selected').data('selected',function(values){
        $('#J_{{input_id}}_selected').load("{{url('backstage/finder_selected')}}/{{model}}/"+values.join(','));
    });
    {%if value%}
        $('#J_{{input_id}}_selected').load("{{url('backstage/finder_selected')}}/{{model}}/{{value}}");
    {%endif%}
    $('#{{input_id}}').on('click',function(e){
        e.preventDefault();
        e.stopPropagation();
        load_{{input_id}}();
    });
    var load_{{input_id}} = 
{%endif%}
function(){
    $.ajax({
        'url':"{{url('backstage/finder')}}/{{input_id}}/{{title}}/{{model}}/{{multiple?'true':'false'}}",
        'success':function(re){
            if(!re.status){
                var modal = $(re);
                modal.appendTo($('body'));
                modal.find('#J_data_{{input_id}}').data('pagination-callback',function(page_obj){
                    $('#J_data_{{input_id}}').load(page_obj.url+'&onlydata=true');
                });
                modal.find('#J_confirm_{{input_id}}').on('click',function(e){
                    e.preventDefault();
                    e.stopPropagation();
                    var finder = $('#J_data_{{input_id}}');
                    var checked = finder.find('input:checked');
                    var values = [];
                    $.each(checked,function(index,item){
                        values.push($(item).val());
                    });
                    {%if callback%}
                    {{callback}}(values);
                    {%endif%}

                    {%if !js_mode%}
                    $('#J_{{input_id}}_selected').data('selected')(values);
                    {%endif%}
                    modal.modal('hide');
                });
                modal.modal('show');
                modal.on('hidden.bs.modal',function(e){
                    modal.remove();
                });
            }else{
                toastr.error(re.msg, '异常');
            }
        }
    });
}
{%if !js_mode%}
})();
</script>
{%endif%}
