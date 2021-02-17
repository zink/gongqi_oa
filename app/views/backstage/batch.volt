<div class="btn-group">
    <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
        批量操作
    </button>
    <div class="dropdown-menu" id="J_{{id}}">
        {%for index,item in menu%}
        <a href="javascript:;" class="batch-item dropdown-item" onclick="(
            function($el){
                var values = [];
                $.each($el.parents('.card').find('.table td input:checked'),function(){
                    values.push($(this).val());
                });
                if(values.length < 1){
                    toastr.warning('请至少勾选一项', '异常');
                    return false;
                }
                var callback = {{item}};
                callback(values);
            }
        )($(this))">{{index}}</a>
        {%endfor%}
    </div>
</div> 
<script>
(function(){
    $('#J_{{id}}').on('click','.batch-item',function(e){
        e.preventDefault();
        e.stopPropagation();
    });
})();
</script>
