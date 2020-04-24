
/**
 * 
 * 2011-4-7/11-29
 * @author 刘显炎/KOEN
 */

var Admin = {
	inprogress: false,
	"loadAdmnList" : function(processType) {
		$("type").val(1);
		var req = $("#search_form").serialize();
		$.ajax( {
			url : "listAdmin.action",
			data : req+"&r=" + new Date().getTime(), // 参数
			type : "post",
			cache : false,
			dataType : "text",
			error : function(x, er) {
				if (isAlert)
					alert('loadAdmnList...' + x + " : " + er);
			},
			success : function(msg) {
				$("#list_search_div").html(msg);
			},
			complete : function(){
				//TODO json
			}
		});
	},
	"loadGroupList" : function(processType) {
		$("type").val(2);
		var req = $("#search_form").serialize();
		$.ajax( {
			url : "listGroup.action",
			data : req+"&r=" + new Date().getTime(), // 参数
			type : "post",
			cache : false,
			dataType : "text",
			error : function(x, er) {
				if (isAlert)
					alert('loadGroupList...' + x + " : " + er);
			},
			success : function(msg) {
				$("#list_search_div").html(msg);
			},
			complete : function(){
				//TODO json
			}
		});
	},
	"loadList":function(){
		if($("#type").val()==2){
			this.loadGroupList();
		}else{
			this.loadAdmnList();
		}
	}

};

//用户编辑
function resetPopcont(cont,title){//重置弹出窗口的状态
	var $cont=$(cont);
	$cont.find('dt span').html(title);
	$cont.find('input:not(:button),textarea').val('');
	$cont.find('input:[type=hidden]').val('0');//重置值
	$cont.find('.errorStatus').removeClass('errorStatus');
	$cont.find('.inputTips').remove();
	$cont.find('.unique').attr('alt','');
}

function addUser(){
	resetPopcont('#open-yonghu','添加用户');
}
function editUser(id,o){
	if($(o).attr('disabled')=='true') return false;
	resetPopcont('#open-yonghu','编辑用户');
	$.getJSON('/admin/getAdmin.action?id='+id,function(data){
		var form=$('#form_user')[0];
		for(var p in data){
			if(form['processAdminVO.'+p]) form['processAdminVO.'+p].value=data[p];
		}
		$.sysop.popup.box('#open-yonghu');
		$('#open-yonghu .unique').attr('alt',function(){return this.value;});
	});
}
function saveUser(){
	if(!$.sysop.validation.check('#form_user')) return;
	var req = $("#form_user").serialize();
	$.post('/admin/process.action',req +'&processType=1',function(data){
		if(data=='操作成功'){
			$.sysop.popup.tip('提示',data,function(){
				$.sysop.popup.reset();//重置弹出窗
				Admin.loadList();//重载列表
			});
		} else {
			$.sysop.popup.tip('提示',data);
		}
	});
}

//组编辑

function addGroup(){
	resetPopcont('#open-juese','添加组');
}
function editGroup(id,o){
	if($(o).attr('disabled')=='true') return false;
	resetPopcont('#open-juese','编辑组');
	$.getJSON('/admin/getGroup.action?id='+id,function(data){
		var form=$('#form_group')[0];
		for(var p in data){
			if(form['processUserGroupVO.'+p]) form['processUserGroupVO.'+p].value=data[p];
		}
		$.sysop.popup.box('#open-juese');
		$('#open-juese .unique').attr('alt',function(){return this.value;});
	});
}
function saveGroup(){
	if(!$.sysop.validation.check('#form_group')) return;
	var req = $("#form_group").serialize();
	$.post('/admin/process.action',req +'&processType=2',function(data){
		if(data=='操作成功'){
			$.sysop.popup.tip('提示',data,function(){
				$.sysop.popup.reset();//重置弹出窗
				Admin.loadList();//重载列表
			});
		} else {
			$.sysop.popup.tip('提示',data);
		}
	});
}
