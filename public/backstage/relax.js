var Relax = new function(){
    var self = this;
    self.mergeUrl = function(url,query){
        if($.type(query) != 'object'){
            return false;
        }
        var queryArray = [];
        $.each(query,function(index,item){
            queryArray.push(index+'='+item);
        });
        if(/\?/.test(url)){
            return url + '&' + queryArray.join('&');
        }else{
            return url + '?' + queryArray.join('&');
        }
    };
}
