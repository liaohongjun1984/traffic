<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>违反交通规则行为管理</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>违反交通规则行为管理</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>违反交通规则行为名称：</span>
							<input type="search" placeholder="违反交通规则行为名称" name="action_name" id="action_name" />
							<input type="search" placeholder="违反交通规则行为代码" name="action_id" id="action_id" />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
            				<a href="/traffic/tpViolationAction/tpViolationActionOp.jspx" class="button fr">添加违反交通规则行为</a>
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>违反交通规则行为名称</td>   
									<td>违反交通规则行为代码</td>  
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
//搜索绑定enter
$('.action-bar input[type="search"]').each(function() {
	$.sysop.kit.bindEnterKey('#' + this.id, searchData);
});

function searchData(page,disR){
	var $box=$('#box_list').show();
	var fn=arguments.callee;
	var param = {};
	if($('#action_name').val()!=""){
		param.action_name = $('#action_name').val();
	}
	if($('#action_id').val()!=""){
		param.action_id = $('#action_id').val();
	}
	param.page = (page||1);
	param.displayRecord = (disR=disR||20);

	$.ajax({
        type: "get",
        async: false,
        url: '/traffic/tpViolationAction/tpViolationActionList.do',
        data: param,
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
		var i = 1;
		$.each(list,function(){
			var bg = ' bgColor="#fff" ';
			if(this.status==2){
				bg=' bgColor="#fee" ';
			}
			if(this.status==3){
				bg=' bgColor="#fff" ';
			}

              $tbody.append('<tr' + bg + '>\
            		  <td><div>'+i+'</div></td>\
	                  <td><div>'+this.action_name+'</div></td>\
	                  <td><div>'+this.action_id+'</div></td>\
	                  <td><div>\
	                  <a href="/traffic/tpViolationAction/tpViolationActionOp.jspx?v_id='+this.v_id+'">修改</a>|\
	                  <a href="javascript:void(0);" onclick="deleteById(\''+this.v_id+'\')">删除</a>\
	                  </div></td>\
	          </tr>');   
	          i = i + 1;
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

function deleteById(v_id){
	if(!confirm('确定删除此交通行为？')) return false;
	$.getJSON('/traffic/tpViolationAction/tpViolationActionDelete.do',"v_id="+v_id,function(json){
		if(!json.success) {
			alert(json.message);
			return;
		}
		searchData();
	});		
}
</script>
</body>
</html>