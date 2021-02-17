<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>共启科技</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    {{ assets.outputCss('header') }}
</head>
<body class="hold-transition sidebar-mini pace-primary layout-fixed">
    <div class="wrapper">
      {{partial('public/header')}}
      <!-- Left side column. contains the logo and sidebar -->
      {{partial('public/sidebar')}}
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper" id="J_backstage_content">
        {{ content() }}
      </div>
      <!-- /.content-wrapper -->
      {{partial('public/footer')}}
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div>
    {{ assets.outputJs('footer') }}
<script>
(function(){
    $.widget.bridge('uibutton', $.ui.button);
    var content = $('#J_backstage_content'),
        lastState = '';
    window.loadPage = function(url ,keep_history){
        url = url || location.href;
        content.load(url);
        if(keep_history!=false && history.pushState != 'undefined'){
            history[lastState == url ? 'replaceState' : 'pushState']({
                        go:url
                    },
                    '', url);
            lastState = url;
        }
    };
    window.onpopstate = function(event) {
        if (!event.state) return;
        var params = event.state.go;
        loadPage(params ,false);
    };
    window.search = function(key,value,single){
        var query = {};
        query[key] = value;
        var url = Relax.Urlutil.mergeQuery(location.href,query);
        loadPage(url);
    }
    /**
     * 处理ajax 消息
     */
    var jsonCommond = function(response) {
        re = typeof(response) =='object'?response:$.parseJSON(response);
        if (!re) {
            return toastr.error('操作失败!' + response, '异常');
        }
        if (re.status == 'success') {
            toastr.success(re.msg, '成功');
            if (re.redirect) {
                loadPage(re.redirect);
            }
            return;
        }
        if (re.status == 'error') {
            toastr.error(re.msg, '错误');
        }
    };
    $(document).on('scroll',function(){
        var scrollTop = $(window).scrollTop();
        if($('[data-toggle="fixed-bar"]').length > 0){
            if(scrollTop > 100){
                $('[data-toggle="fixed-bar"]').addClass('fixed');
            }else{
                $('[data-toggle="fixed-bar"]').removeClass('fixed');
            }
        }
    }).on('click', 'a:not(a[target="_blank"],a[target="_command"],a[href^="javascript:"],a[data-toggle],a[data-target],a[data-event],a[data-finder-batch])', function(e) {
        e.preventDefault();
        var $el = $(this);
        var url = $el.prop('href');
        var target = $el.prop('target');

        loadPage(url);
    }).on('submit','form:not(form[enctype="multipart/form-data"])',function(e){
        e.preventDefault();
        var form = $(this);
        $.ajax({
            url:form.prop('action'),
            type:form.prop('method'),
            data:form.serialize(),
            beforeSend: function(xhr) {
                if (form.data('ajax:beforeSend') && typeof(form.data('ajax:beforeSend')) == 'function') {
                    form.data('ajax:beforeSend')(xhr);
                }
            },
            success: function(responseText) {
                if (form.data('ajax:success') && typeof(form.data('ajax:success')) == 'function') {
                    form.data('ajax:success')(responseText);
                }
                jsonCommond(responseText);
            },
            complete: function(xhr) {
                if (form.data('ajax:complete') && typeof(form.data('ajax:complete')) == 'function') {
                    form.data('ajax:complete')(xhr);
                }
            },
            error: function(xhr) {
                toastr.warning(xhr, '异常');
                if (form.data('ajax:error') && typeof(form.data('ajax:error')) == 'function') {
                    form.data('ajax:error')(xhr);
                }
            }
        });
    });
    //vue global component
    Vue.component('department-object',{{department_object(['mode':'component'])}});
    Vue.component('worker-object',{{worker_object(['mode':'component'])}});
    Vue.component('idc-object',{{idc_object(['mode':'component'])}});
    Vue.component('tags-input',VoerroTagsInput);
    Vue.component('draggable',vuedraggable);
    Vue.component('address-object',{{address_object(['mode':'component'])}});
    Vue.component('upload-object',{{upload_object(['mode':'component'])}});
    Vue.component('time-input',{
        props:['name','value'],
        template:'<input type="text" :name="name" class="form-control" autocomplete="off" v-model="formatTime">',
        model: {
          prop: 'value',
          event: 'edit'
        },
        'mounted':function(){
            var self = this;
            $(this.$el).datepicker({
                format:'yyyy-mm-dd',
                language:'zh-CN',
                autoclose:true
            }).on('changeDate',function(e){
                var timestamp = (+ e.date) / 1000;
                self.$emit('edit',timestamp);
            });
        },
        computed:{
            formatTime:function(){
                if(this.value){
                    return Relax.formatTime(this.value,'yyyy-MM-dd');
                }else{
                    return '';
                }
            }
        }
    });
    Vue.component('tel-object',{
        props:['name','value'],
        data:function(){
            return {
                areaCode:'',
                tel:'',
            }
        },
        template:`
            <div class="input-group">
                <input type="hidden" :name="name?name:'tel'" v-model="value"/>
                <span class="input-group-prepend">
                    <input type="text" class="form-control" v-model="areaCode" placeholder="区号"/>
                </span>
                <p class="form-control-plaintext">
                    -
                </p>
                <span class="input-group-append">
                    <input type="text" class="form-control" v-model="tel" placeholder="电话"/>
                </span>
            </div>
        `,
        model: {
            prop: 'value',
            event: 'edit'
        },
        mounted:function(){
            if(this.value){
                var tel = this.value.split('-');
                if(tel.length > 1){
                    this.areaCode = tel[0];
                    this.tel = tel[1];
                }else{
                    this.tel = this.value;
                }
            }
        },
        watch:{
            'areaCode':function(){
                this.$emit('edit',this.areaCode+'-'+this.tel);
            },
            'tel':function(){
                this.$emit('edit',this.areaCode+'-'+this.tel);
            }
        }
    });
    Vue.component('date-range-input',{
        props:['name','value'],
        template:'<input type="text" :name="name" class="form-control" readonly autocomplete="off">',
        'mounted':function(){
            var self = this,
                $el = $(this.$el);
            $el.daterangepicker({
                startDate:Relax.DateUtil.getStartDayOfWeek(),
                endDate:Relax.DateUtil.getEndDayOfWeek(),
                locale:{
                    format: 'YYYY-MM-DD',
                    separator: ' 至 ',
                    applyLabel: '确定',
                    cancelLabel: '取消',
                    fromLabel: '从',
                    toLabel: '至',
                    daysOfWeek: ['日', '一', '二', '三', '四', '五','六'],
                    monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
                }
            }).on('apply.daterangepicker',function(ev,picker){
                var range = $el.val().split(' 至 ');
                self.$emit('apply',{
                    'start':range[0],
                    'end':range[1]
                });
            });
        }
    });
})();
</script>
</body>
</html>
