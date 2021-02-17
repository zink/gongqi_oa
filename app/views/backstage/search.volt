<form action="/" class="input-group input-group-sm" id="J_{{id}}">
    <div class="input-group-prepend">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
            <span id="J_{{id}}_main">
            </span>
        </button>
        <div class="dropdown-menu">
            {%for index,item in menu%}
            <a class="dropdown-item" href="javascript:;" data-query="{{item}}">{{index}}</a>
            {%endfor%}
        </div>
    </div>
    <input type="text" class="form-control">
    <span class="input-group-append">
        <button type="submit" class="btn btn-default">
            <i class="fa fa-search"></i>
        </button>
    </span>
</form>
<script>
(function(){
    var url = location.href,
        searchObject = $('#J_{{id}}'),
        searchInput = searchObject.find('input');
    searchObject.on('click','.dropdown-menu a',function(e){
        e.stopPropagation();
        e.preventDefault();
        var $el = $(this);
        $('#J_{{id}}_main').text($el.text());
        searchInput.data('query',$el.data('query'));
    }).on('submit',function(e){
        e.stopPropagation();
        e.preventDefault();
        var value = $.trim(searchInput.val());
        search(searchInput.data('query'),value);
    });
    searchObject.find('.dropdown-menu a').first().trigger('click');
})();
</script>
