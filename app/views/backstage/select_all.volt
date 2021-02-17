<div class="icheck-primary d-inline">
    <input type="checkbox" id="J_checkbox_{{id}}" value="{{item.id}}">
    <label for="J_checkbox_{{id}}"></label>
</div>
<script>
(function(){
    $('#J_checkbox_{{id}}').on('change',function(e){
        $(this).parents('table').find('td input').prop('checked',$(this).prop('checked'));
    });
})();
</script>
