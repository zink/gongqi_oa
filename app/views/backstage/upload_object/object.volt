{%if mode != 'component'%}
<script>
var config{{id}} = 
{%endif%}
{
    delimiters:['<%','%>'],
    template:`{{partial('backstage/upload_object/template')}}`,
    {%if mode == 'component'%}
    props:['title','url','types','image','multiple'],
    {%endif%}
    data:function(){
        return {
            imageSrc:''
        };
    },
    mounted:function(){
        var self = this;
        var $input = $(self.$refs.upload_btn);
        var self = this;
        if(this.image){
            this.imageSrc = this.image;
        }
        $input.fileupload({
            add:function(e,data){
                var fileObj = data.files[0];
                if(fileObj.size / 1024 / 1024 > 2){
                    return toastr.warning('图片不要大于2M','超过大小');
                }
                if(self.types){
                    for(var i = 0;i<self.types.length;i++){
                        var match = new RegExp(self.types[i]);
                        if(fileObj['type'].match(match)){
                            return data.submit();
                        }
                    }
                    return toastr.warning(data.files[0]['name']+'不是允许的文件类型','类型错误');
                }else{
                    return data.submit();
                }
            },
            done:function(e,data){
                var re = data.result;
                if(re.status == 'success'){
                    toastr.success(re.msg, '成功');
                    loadPage();
                }else{
                    toastr.error(re.msg, '异常');
                }
            }
        });
    }
}
{%if mode != 'component'%}
var upload_{{id}} = new Vue(config{{id}});
</script>
{%endif%}
