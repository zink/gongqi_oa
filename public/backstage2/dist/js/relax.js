var Relax = new function(){
    var self = this;
    var now = new Date(); // 当前日期
    var nowDayOfWeek = now.getDay(); // 今天本周的第几天
    var nowDay = now.getDate(); // 当前日
    var nowMonth = now.getMonth(); // 当前月
    var nowYear = now.getYear(); // 当前年
    nowYear += (nowYear < 2000) ? 1900 : 0;
    //url 操作方法集合
    self.Urlutil = new function(){
        //url query融合
        var self = this;
        self.mergeQuery = function(url,query){
            if($.type(query) != 'object'){
                return false;
            }
            var oldQuery = self.getQueryList(url);
            var newQuery = $.extend(oldQuery,query);
            var queryArray = [];
            $.each(newQuery,function(index,item){
                if(item){
                    queryArray.push(index+'='+item);
                }
            });
            var newUrl = url.split('?')[0];
            return newUrl + '?' + queryArray.join('&');
        },
        //获取url参数
        self.getQueryVariable = function(url,variable){
            url = url || window.location.href;
            var query = url.split('?')[1];
            if(query){
                var vars = query.split("&");
                for (var i=0;i<vars.length;i++) {
                    var pair = vars[i].split("=");
                    if(pair[0] == variable){
                        return pair[1];
                    }
                }
                return(false);
            }else{
                return(false);
            }
        }
        //获取参数列表
        self.getQueryList = function(url){
            url = url || window.location.href;
            var query = url.split('?')[1];
            var queryList = {}
            if(query){
                var vars = query.split("&");
                for (var i=0;i<vars.length;i++) {
                    var pair = vars[i].split("=");
                    queryList[pair[0]] = pair[1];
                }
            }
            return(queryList);
        }
    }
    /*转换时间格式*/
    self.formatTime = function(timestamps,format) {
        if((''+timestamps).length == 10){
            timestamps = timestamps * 1000;
        }
        var newDate = new Date();
        newDate.setTime(timestamps);
        var date = {
              "M+": newDate.getMonth() + 1,
              "d+": newDate.getDate(),
              "h+": newDate.getHours(),
              "m+": newDate.getMinutes(),
              "s+": newDate.getSeconds(),
              "q+": Math.floor((newDate.getMonth() + 3) / 3),
              "S+": newDate.getMilliseconds()
        };
        if (/(y+)/i.test(format)) {
              format = format.replace(RegExp.$1, (newDate.getFullYear() + '').substr(4 - RegExp.$1.length));
        }
        for (var k in date) {
              if (new RegExp("(" + k + ")").test(format)) {
                     format = format.replace(RegExp.$1, RegExp.$1.length == 1
                            ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
              }
        }
        return format;
    }
    self.DateUtil = {
        /**
         * 获得当前日期
         *
         * @returns
         */
        getNowDay() {
            return this.formatDate(new Date());
        },
        /**
         * 获得本周的开始时间
         *
         * @returns
         */
        getStartDayOfWeek(timestamps) {
            var day = nowDayOfWeek || 7;
            if(timestamps){
                var _return = + new Date(now.getFullYear(), nowMonth, nowDay + 1 - day);
                return  _return / 1000 ;
            }else{
                return this.formatDate(new Date(now.getFullYear(), nowMonth, nowDay + 1 - day));
            }
        },
        /**
         * 获得本周的结束时间
         *
         * @returns
         */
        getEndDayOfWeek(timestamps) {
            var day = nowDayOfWeek || 7;
            if(timestamps){
                var _return = + new Date(now.getFullYear(), nowMonth, nowDay + 7 - day);
                return  _return / 1000;
            }else{
                return this.formatDate(new Date(now.getFullYear(), nowMonth, nowDay + 7 - day));
            }
        },
        /**
         * 获得本月的开始时间
         *
         * @returns
         */
        getStartDayOfMonth() {
            var monthStartDate = new Date(nowYear, nowMonth, 1);
            return this.formatDate(monthStartDate);
        },
        /**
         * 获得本月的结束时间
         *
         * @returns
         */
        getEndDayOfMonth() {
            var monthEndDate = new Date(nowYear, nowMonth, this.getMonthDays());
            return this.formatDate(monthEndDate);
        },
        /**
         * 获得本月天数
         *
         * @returns
         */
        getMonthDays() {
            var monthStartDate = new Date(nowYear, nowMonth, 1);
            var monthEndDate = new Date(nowYear, nowMonth + 1, 1);
            var days = (monthEndDate - monthStartDate) / (1000 * 60 * 60 * 24);
            return days;
        },
        /**
         * @param 日期格式化
         * @returns {String}
         */
        formatDate(date) {
            var myyear = date.getFullYear();
            var mymonth = date.getMonth() + 1;
            var myweekday = date.getDate();
      
            if (mymonth < 10) {
                mymonth = "0" + mymonth;
            }
            if (myweekday < 10) {
                myweekday = "0" + myweekday;
            }
            return (myyear + "-" + mymonth + "-" + myweekday);
        }
    }
};
