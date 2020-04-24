<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>路口管理</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>路口管理</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>路口名称：</span>
							<input type="search" placeholder="路口名称" name="road_name" id="road_name" />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
            				<a href="/traffic/tpRoad/tpRoadOp.jspx" class="button fr">添加路口</a>
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>高速标识（1为路口违法，2为超速违法）</td>
									<td>路口名称</td> 
									<td>路口代码</td>
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
	var param = 'road_name='+$('#road_name').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/traffic/tpRoad/tpRoadList.do',
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
            		  <td><div>'+this.road_speed+'</div></td>\
	                  <td><div>'+this.road_name+'</div></td>\
	                  <td><div>'+this.road_code+'</div></td>\
	                  <td><div>\
	                  <a href="/traffic/tpRoad/tpRoadOp.jspx?cr_id='+this.cr_id+'">修改</a>|\
	                  <a href="javascript:void(0);" onclick="deleteById(\''+this.cr_id+'\')">删除</a>|\
	                  <a href="/traffic/tpRoad/addViolation.jspx?cr_id='+this.cr_id+'">添加所属违规行为</a>\
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

function deleteById(cr_id){
	if(!confirm('确定删除此路口？')) return false;
	$.getJSON('/traffic/tpRoad/tpRoadDelete.do',"cr_id="+cr_id,function(json){
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