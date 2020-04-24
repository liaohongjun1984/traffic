<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>域名权重管理</span></h2>
			<div class="mainContent">
				<!-- 域名权重管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>域名权重列表</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>域名：</span>
							<input type="search" placeholder="域名" name="host" id="host" />
<!--							<span>应用名称：</span>-->
<!--							<input type="search" placeholder="应用系统id" name="app_id" id="app_id" />-->
							<span>系统名称：</span>
							<select id="app_id">
								
							</select>
							<input type="button" class="button" id="search_domin_weight" value="搜索" onclick="searchData()" />
            				<a href="/admin/domain_weights_add.jspx" class="button fr">添加域名权重</a>
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>域名</td>            
									<td>系统名称</td>
									<td>权重</td>
									<td>备注</td>
									<td>修改时间</td>
									<td>操作人</td>
									<td class="op" style="text-align:center">操作</td>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="paginationbar" id="paginationbar">
						</div>
						<!--分页导航-->
						<div class="displayNum" id="displayNum">
						</div>
						<!--每页显示数目导航-->
						<div class="clear"></div>
					  </div>
					</div>
				<!-- 角色管理 end -->
			</div>
		</div>
		<!-- right end -->
	</div>
	<!-- mani end -->
	<div class="footer clearfix"></div>
</div>
<script>
$.sysop.autoComplete.init('#host','/admin/domainWeightsListByHost.do?host=','host');
//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

$(function(){
	$.getJSON('/admin/getAppList.do',function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var appInfo = $("#app_id");
		appInfo.append("<option value=''>请选择</option>");
		$.each(json.object,function(){
			appInfo.append("<option value='"+this.app_id+"'>"+this.cn_name+"</option>");
		});
	});
});

function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = 'host='+$('#host').val()+'&app_id='+($('#app_id').val()||-1);
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/admin/domainWeightsList.do',
        data: req,
        dataType: "json",
        cache: false,
        success: dealData
    });
	function dealData(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		var count=json.object.count,list=json.object.lists,p=json.object.page,pCount=json.object.pageCount;
		var $tbody=$box.find('tbody').html('');
		$.each(list,function(){
			$tbody.append('<tr>\
	                  <td><div>'+this.host+'</div></td>\
	                  <td><div>'+this.cn_name+'</div></td>\
	                  <td><div>'+this.weight+'</div></td>\
	                  <td><div>'+this.notes+'</div></td>\
	                  <td><div>'+this.last_modify+'</div></td>\
	                  <td><div>'+this.nick_name+'</div></td>\
	                  <td><div><a href="/admin/domain_weights_edit.jspx?id='+this.id+'">修改</a>|\
	                  <a href="javascript:void(0);" onclick="del('+this.id+')">删除</a></td>\
	          </tr>');
		});
		$box.find('.count').html("记录数("+count+")");
		//分页
		var $pag=$box.find('.paginationbar'),$dis=$box.find('.displayNum');
		$.sysop.pagination.init($pag,p,pCount,10,function(num){
			fn(num,disR);
		});
		//显示数目
		$.sysop.pagination.displayNum($dis,disR,function(){
			fn(1,this.innerHTML.slice(0,-1));
		});
	}	
}
searchData();

function del(id){
	if(!confirm('确认删除？')) return;
	$.getJSON('/admin/delDomainWeights.do',"id="+id,function(json){
		var msg = json.success ? '删除成功' : json.message;
		$.sysop.popup.autoTip(msg, function() {
			searchData();
		});
	});		
}
</script>
</body>
</html>