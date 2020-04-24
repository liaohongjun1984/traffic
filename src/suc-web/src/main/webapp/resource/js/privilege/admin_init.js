
/**
 * 
 * 2011-4-7/11-29
 * @author 刘显炎/KOEN
 */

/**是否打印调试提示*/
var isAlert = true;

$(document).ready(function() {
	Admin.loadList();
});
//
$(function(){//验证表单
	//用户
	$.sysop.validation.init('#form_user',true);
	$.sysop.validation.myCheck.unique('.unique','/admin/checkAdmin.action?key=');
	$.sysop.validation.myCheck.uniqueUDB('.uniqueUDB','/admin/checkUdbAdmin.action?key=');
	$.sysop.validation.myCheck.unique('.uniqueNAME','/admin/checkAdminByNick.action?key=');
	//组
	$.sysop.validation.init('#form_group',true);
	$.sysop.validation.myCheck.unique('.unique','/admin/checkGroup.action?key=');
});
$(function(){//自动完成
	if($("#type").val()==1) $.sysop.autoComplete.init('#searchKey','/admin/listAdminIndex.action?key=','nickName');
	else $.sysop.autoComplete.init('#searchKey','/admin/listGroupIndex.action?key=','groupName');
});
$(function(){//列表双击
	$('#list_search_div tbody tr').live('dblclick',function(){
		getSelection().removeAllRanges();
		$(this).find('td:first a').eq(0).click();
		return false;
	});
});

