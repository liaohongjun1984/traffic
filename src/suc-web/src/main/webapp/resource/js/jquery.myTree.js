// 
// jQuery.myTree v2.0
// Author: koen_lee@qq.com
// Date: 2.16
//
;(function($){
	$.fn.extend({
		myTree:function(p){
			p=$.extend({
				type:'myTreeOS',//默认一般菜单形式
				unfold:true,//默认菜单展开，格式：[#id1,#id2]|'auto'
				link:true,//默认有链接
				animate:100,//菜单展示速度
				checkbox:false,//默认无checkbox
				editable:false,//默认不可编辑
				nameEditable:true,//编辑状态下默认可点击修改名字
				rightClickMenu:true,//编辑状态下默认有右键菜单
				data:[],//数据
				menu:[],//右键菜单，格式：[{name:'',fn:handle}]
				fn:function(){}//点击菜单链接的回调函数
			},p);
			//有checkbox或可编辑状态都禁用链接
			if(p.checkbox||p.editable) p.link=false;
			//全局引用
			kit.$box=this;
			//生成HTML
			kit.addHtml(this,p);
			//绑定基本事件
			kit.addEventBase(this,p);
			//初始化显示，包括高亮当前菜单、折叠等
			kit.initShow(this,p);
			//选择是否可编辑
			if(p.editable) kit.editable(this,p);
			//
			return $;
		},
		myTreeParseJSON:function(){
			$boxItem=this.children('div');
			return kit.parseItem($boxItem);
		}
	});
	var kit={//功能方法集
		addHtml:function($box,p){//生成HTML
			var box=$box[0],id=box.id,arr=[];
			this.addChild(arr,p.data,p.checkbox,p.link,id);
			box.innerHTML=arr.join('');
			//加类menu-nav
			$box.addClass(p.type).children('div').addClass('itembox-wrap').children('.item-nav').addClass('menu-nav');
		},
		addChild:function(arr,children,checkbox,link,id){//生成单项item-nav
			arr.push('<div class="itembox">');
			for(var i=0,l=children.length;i<l;i++){
				var hasChild=children[i].children&&children[i].children.length;
				var ID=id+'_'+i;
				arr.push('<div class="item-nav '+(hasChild?'parent ':'')+(children[i].css||'')+'" id="'+ID+'"><b></b>'+(checkbox?'<span class="'+(children[i].checked?'onClick':'')+'"></span>':'')+'<a value="'+(children[i].value||'')+'"'+(link?' href="'+(children[i].url||'')+'"':'')+' target="'+(children[i].target||'_self')+'" data='+(children[i].data||'')+'>'+children[i].name+'</a></div>');
				if(hasChild) this.addChild(arr,children[i].children,checkbox,link,ID);//循环
			}
			arr.push('</div>');
		},
		addEventBase:function($box,p){
			//展开&收起
			$box.find('b').click(function(){
				if($(this).is('.active')){//收起
					$(this).removeClass('active').parent().next('.itembox').hide(p.animate);
				}else{//展开
					$(this).addClass('active').parent().next('.itembox').show(p.animate);
				}
			});
			//checkbox选择
			$box.find('span').click(function(){
				var $nav=$(this).parent();
				if($(this).attr('class')=='check'){
					//self处理
					$(this).removeClass();
					//child处理
					if($nav.next().is('.itembox')) $nav.next().find('span').removeClass();
					//parent处理
					kit.checkParentCheckbox($nav,$box);
				}else{
					//self处理
					$(this).attr('class','check');
					//child处理
					if($nav.next().is('.itembox')) $nav.next().find('span').attr('class','check');
					//parent处理
					kit.checkParentCheckbox($nav,$box);
				}
				//return false;
			});
			//链接点击
			$box.find('a').click(function(){
				$box.find('a.selected').removeClass('selected');
				$(this).addClass('selected');
				p.fn.call(this);
			});
			//点击整个菜单
			$box.find('.item-nav').click(function(){
				//kit.$menu.hide();//隐藏右键菜单
			});
		},
		rightClickMenu:{
			addMenu:function(){
				var $box=kit.$box,data=this.data;
				var boxId=$box[0].id,mId=boxId+'_menu';
				$('#'+mId).remove();//删除已存在的，以兼容多次绑定
				var $menu=kit.$menu=$('<div id="'+mId+'" class="myTree-rightClickMenu" onselectstart="return false">').appendTo('body');//全局引用
				var arr=[],self;
				arr.push('<ul>');
				for(var i=0;i<data.length;i++) arr.push('<li class="'+(data[i].css||'')+' '+(data[i].disabled?'disabled':'')+'">'+data[i].name+'</li>');
				arr.push('</ul>');
				$menu.html(arr.join(''));
				//
				$menu.click(function(){return false;})//防止点击line隐藏菜单
				.find('li').click(function(){
					if($(this).is('.disabled')) return false;
					kit.$menu.hide();//隐藏右键菜单
					var index=$(this).index();
					data[index].fn&&data[index].fn.call(self,data[index].handle);
				});
				$menu[0].oncontextmenu=function(){return false;};
				$('body').click(function(){$menu.hide();});
				$('body')[0].oncontextmenu=function(e){//在其它地方右键隐藏菜单(bug:菜单上右键也会隐藏)
					var e = e || window.event;
					if(!$(e.target).is('#'+boxId+' a')) $menu.hide();
				}
				//链接右键事件
				$box.find('a').each(function(){
					this.oncontextmenu = function(e){
						var e = e || window.event;
						$menu.css({left:e.clientX,top:e.clientY,display:'block'});
						$box.find('a.selected').removeClass('selected');
						$(this).addClass('selected');
						self=this;//保存点击处链接a
						return false;
					};
				});
			},
			initMenu:function($box,p){
				var data=[//默认的菜单
					{name:'添加同级菜单',fn:this.addItem},
					{name:'添加子级菜单',fn:this.addSubItem},
					{css:'line',disabled:true},
					{name:'编辑菜单',fn:this.editItem},
					{name:'删除菜单',fn:this.delItem}
				];
				//查找并合并自定义回调函数
				if(p.menu.length){
					for(var i=0;i<p.menu.length;i++){
						for(var j=0;j<data.length;j++){
							if(p.menu[i].name==data[j].name){
								data[j].handle=p.menu[i].handle;
								data[j].disabled=p.menu[i].disabled;
								if(p.menu[i].reName) data[j].name=p.menu[i].reName;
								break;
							}
						}
					}
				}
				//通用
				this.data=data;
				//
				this.addMenu();
			},
			addItem:function(handle){//新增同级菜单
				var hd=handle&&handle.call(this);
				if(hd===false) return;
				//
				var $nav=$(this).parent(),$copy=$nav.clone(true);
				$copy=kit.rightClickMenu.copyReset($copy);
				$(this).parent().parent().append($copy);
				$copy.find('a').click();
				//暂不提供checkbox检测
				//kit.checkParentCheckbox($copy,this.$box);
				kit.rightClickMenu.addMenu();
			},
			addSubItem:function(handle){//新增子级菜单(有bug)
				//if($(this).parents('.itembox').length>=4){alert('最多5层子菜单');return;};//！！！！个性化
				var hd=handle&&handle.call(this);
				if(hd===false) return;
				//
				var $nav=$(this).parent(),$copy=$nav.clone(true);
				$copy=kit.rightClickMenu.copyReset($copy,true);
				if($nav.next().is('.itembox')){
					$nav.next().append($copy);
				}else{
					var $itemBox=$('<div class="itembox">');
					$itemBox.append($copy).show();
					$nav.addClass('parent').after($itemBox);
					//
					kit.checkParent($copy,kit.$box,function($i,$p){
						$i.parent().show();
						$p.find('b').addClass('active');
					});
				}
				$copy.find('a').click();
				//暂不提供checkbox检测
				//kit.checkParentCheckbox($copy,this.$box);
				kit.rightClickMenu.addMenu();
			},
			editItem:function(handle){
				var hd=handle&&handle.call(this);
				if(hd===false) return;
				//
				$(this).click();
			},
			delItem:function(handle){
				if(!confirm('确认删除？')) return;
				//
				var hd=handle&&handle.call(this);
				if(hd===false) return;
				//
				var $nav=$(this).parent();
				//删除子菜单
				if($nav.next().is('.itembox')) $nav.next().remove();
				//删除自己
				$nav.remove();
				handle&&handle.call(this);
			},
			copyReset:function($copy,isSub){
				var id=$copy.attr('id'),_id=id.slice(0,id.lastIndexOf('_')+1);
				//重置状态
				$copy.attr('id',_id+(isSub?'copy_':'')+(+new Date)).removeClass('parent');
				$copy.find('span').removeClass();
				$copy.find('a').removeClass('selected').attr('value',0).html('新增菜单');
				$copy.find('input').val('新增菜单');
				return $copy;
			}
		},
		nameEditable:function($box){
			$box.find('div.item-nav').each(function(){
				$(this).append('<input value="'+$(this).find('a').html()+'" style="display:none;" />')							
			});
			$box.find('a').addClass('editable').click(function(e){
				$(this).removeClass('hover').hide().next('input').show().select();
				e.preventDefault();//禁止默认跳转
				//return false;//防止跳转
			});
			$box.find('input').blur(function(){
				$(this).hide().prev('a').show().html(this.value||'未命名');
			}).click(function(){
				//return false;
			}).keyup(function(e){//绑定Enter
				if(e.keyCode == '13') $(this).blur();
			});
		},
		editable:function($box,p){
			//隐藏checkbox
			$box.find('span').hide();
			//右键菜单
			if(p.rightClickMenu) kit.rightClickMenu.initMenu($box,p);
			//名字点击编辑
			if(p.nameEditable) kit.nameEditable($box,p)
		},
		checkParent:function($nav,$box,fn){//遍历当前菜单的父层
			var ID=$nav.attr('id'),boxID=$box.attr('id');
			do{
				var $navList=$('#'+ID).parent().children('.item-nav'),$navPar=$('#'+ID).parent().prev();
				fn&&fn($navList,$navPar);
				ID=ID.slice(0,ID.lastIndexOf('_'));
			}
			while(ID!==boxID);
		},
		checkParentCheckbox:function($nav,$box){
			kit.checkParent($nav,$box,function($navList,$navPar){
				if($navList.find('.check').length==$navList.length) $navPar.find('span').attr('class','check');
				else if($navList.find('.check,.checkIn').length>0) $navPar.find('span').attr('class','checkIn');
				else $navPar.find('span').removeClass();
			});
		},
		initShow:function($box,p){
			//高亮当前菜单
			var curID='',boxID=$box[0].id,url=window.location.toString(),uIDX1=url.indexOf('#'),uIDX2=url.indexOf('?');
			if(uIDX1!==-1) url=url.slice(0,uIDX1);
			if(uIDX2!==-1) url=url.slice(0,uIDX2);
			$box.find('a').each(function(){//高亮并返回当前页菜单id
				if(this.href==url){
					$(this).addClass('active');
					curID=$(this).parent().attr('id');
					return false;//跳出循环
				}
			});
			//折叠菜单
			if(p.unfold==true){//全部展开
				$box.find('.itembox').show();
				$box.find('b').addClass('active');
			}else if(p.unfold=='auto'){//自动展开当前菜单
				kit.checkParent($('#'+curID),$box,function($i,$p){
					$i.parent().show();
					$p.find('b').addClass('active');
				});
			}else if(p.unfold.sort){//自定义展开
				$.each(p.unfold,function(i,n){
					kit.checkParent($(n),$box,function($i,$p){
						$i.parent().show();
						$p.find('b').addClass('active');
					});
				});
			}
			//初始化选择的菜单
			$box.find('span.onClick').click();
		},
		parseItem:function($boxItem){//解析数据(返回后台)
			var data=[],_this=this;
			$boxItem.children('.item-nav').each(function(){
				var json={},$a=$(this).find('a');
				json.name=$a.html()||'';
				json.value=$a.attr('value')||'';
				json.data=$a.attr('data')||'';
				json.url=$a.attr('href')||'';
				json.target=$a.attr('target')||'';
				json.checked=$(this).find('span').is('.check');
				if($(this).next().is('.itembox')){
					json.children=_this.parseItem($(this).next());
				}
				//else json.children=[1];
				data.push(json);
			});
			return data;//返回array
		},
		parseCheckItem:function(){
			var data=this.parseJSON();//=children
			var arrCheck=[],str='';
			var parseChild=function(arr){
				for(var i=0;i<arr.length;i++){
					if(arr[i].children) parseChild(arr[i].children);
					else arrCheck.push(arr[i]);
				}
			}
			parseChild(data);
			for(var i=0;i<arrCheck.length;i++){
				if(arrCheck[i].checked) str+=arrCheck[i].value+',';
			}
			return str;//返回字符串
		}
	}
})(jQuery);

/*
API=(id,{
	unfold:bool,
	data:DATA,
})
DATA=[{
	name:str,
	url:str,
	target:str,
	checked:false,
	value:str,
	data:str|JSONStr,
	css:str,//不返回后台
	children:[]//
}];

*/