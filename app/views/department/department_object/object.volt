{%if mode != 'component'%}
{{partial('department/department_object/template')}}
<script>
var config{{id}} = 
{%endif%}
    {
        {%if mode != 'component'%}
        el:'#{{id}}',
        {%endif%}
        {%if mode == 'component'%}
        template:`{{partial('department/department_object/template')}}`,
        props:['id'],
        {%endif%}
        data:function(){
            return {
                name:'顶级'
            }
        },
        model:{
            'prop':'id',
            'event':'change'
        },
        delimiters:['<%','%>'],
        watch:{
            'id':function(id){
                var self = this;
                $.ajax({
                    'url':"{{url('department/get_department/')}}"+id,
                    'success':function(re){
                        if(re.name){
                            self.name = re.name;
                        }
                    }
                });
            }
        },
        methods:{
            'getList':function(){
                var self = this;
                $.ajax({
                    'url':"{{url('department/department_modal')}}",
                    'success':function(re){
                        var html = $(re).appendTo($('body'));
                        var modal = html.find('.modal');
                        modal.on('hidden.bs.modal',function(){
                            html.remove();
                        }).on('click','.submit',function(){
                            var checked = modal.find('input:checked');
                            if(checked.length > 0){
                                self.id = checked.val();
                                self.$emit('change',self.id);
                            }
                            modal.modal('hide');
                        });
                        modal.modal('show');
                    }
                });
            }
        }
    }
{%if mode != 'component'%}
var dpo_{{id}} = new Vue(config);
</script>
{%endif%}
