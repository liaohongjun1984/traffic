jQuery.cookie = function(name, value, options) {   
    if (typeof value != 'undefined') { 
         options = options || {};   
        if (value === null) {   
             value = '';   
             options.expires = -1;   
         }   
        var expires = '';   
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {   
            var date;   
            if (typeof options.expires == 'number') {   
                 date = new Date();   
                 date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));   
             } else {   
                 date = options.expires;   
             }   
             expires = '; expires=' + date.toUTCString();   
         }   
        var path = options.path ? '; path=' + (options.path) : '';   
        var domain = options.domain ? '; domain=' + (options.domain) : '';   
        var secure = options.secure ? '; secure' : '';   
         document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');   
     } else {   
        var cookieValue = null;   
        if (document.cookie && document.cookie != '') {   
            var cookies = document.cookie.split(';');   
            for (var i = 0; i < cookies.length; i++) {   
                var cookie = jQuery.trim(cookies[i]);   
                if (cookie.substring(0, name.length + 1) == (name + '=')) {   
                     cookieValue = decodeURIComponent(cookie.substring(name.length + 1));   
                    break;   
                 }   
             }   
         }   
        return cookieValue;   
     }   
};
function menuTree(){//menuTree类
	//this.id=id;
}
menuTree.prototype={
	bindData:function(data){
		this.data=data;
	},
	draw:function(id,isAll){
		var self=this;
		this.addHtml(id,this.data);//生成HTML
		$(id).find('.menu-nav,.item-nav').toggle(function(){
			if(!$(this).next().is('.itembox')) return;
			$(this).next('.itembox').show(self.dur||200);
			$(this).find('b').addClass('active');
		},function(){
			if(!$(this).next().is('.itembox')) return;
			$(this).next('.itembox').hide(self.dur||100);
			$(this).find('b').removeClass('active');
		});
		$(id).find('a').click(function(){
			$(id).find('a').removeClass('active');
			$(this).addClass('active');
			if($(this).attr('href')!='#opensub') document.open(this.href);
		});
		//菜单结束
		this.showMenu(id,window.location,isAll);
	},
	addHtml:function(id,data){//生成HTML
		var $box=$(id),box=$box[0],len=data.length,str=[],id=$box.attr('id');
		for(var i=0;i<len;i++){
			str.push('<div class="menu-nav" id="'+id+'_'+i+'"><b></b>'+data[i].name+'</div>');
			if(data[i].sub&&data[i].sub.length) this.addChild(str,id+'_'+i,data[i].sub);//循环
		}
		box.innerHTML=str.join('');
	},
	addChild:function(str,id,sub){//生成单项item-nav
		str.push('<div class="itembox">');
		for(var i=0,l=sub.length;i<l;i++){
			str.push('<div class="item-nav" id="'+id+'_'+i+'"><b></b><a href="'+(sub[i].url?sub[i].url:'#opensub')+'" target="_self">'+sub[i].name+'</a></div>');
			if(sub[i].sub&&sub[i].sub.length) this.addChild(str,id+'_'+i,sub[i].sub);//循环
		}
		str.push('</div>');
	},
	showMenu:function(o,url,isAll){
		var id='',oId=o.slice(1);
		$(o).find('a').each(function(){//找到当前页菜单
			if(this.href==url) id=$(this).parent().attr('id');
		});
		var ori=id;//保存原始值
		this.dur=1;//设置最小延迟
		if(isAll){
			$(o).find('.menu-nav,.item-nav').click();
			if(id) $('#'+id).find('a').addClass('active');
		} else {
			if(id){
				do{
					$('#'+id).click();
					if(id===ori) $('#'+id).find('a').addClass('active');
					id=id.slice(0,id.lastIndexOf('_'));
				}
				while(id!==oId);
			}
		}
		this.dur='';//还原
	}
};