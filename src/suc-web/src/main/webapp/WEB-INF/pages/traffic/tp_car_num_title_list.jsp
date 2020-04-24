<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<!-- 左边列表树 -->
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<!-- 右边列表树 -->
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>车牌前缀管理</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>车牌前缀管理</h4><span class="right count"></span>
					</div>
					<!-- 搜索框 -->
					<div class="cont">
						<div class="action-bar">
							<span>车牌前缀名称：</span>
							<input type="search" placeholder="车牌前缀名称" name="crt_num_title" id="crt_num_title" />
							<input type="search" placeholder="车牌前缀代码" name="crt_num_id" id="crt_num_id" />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
            				<a href="/traffic/tpCarNumTitle/tpCarNumTitleOp.jspx" class="button fr">添加车牌前缀</a>
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>车牌前缀名称</td>  
									<td>车牌前缀ID</td>   
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
	if($('#crt_num_title').val()!=""){
		var param = 'crt_num_title='+$('#crt_num_title').val();
	}
	if($('#crt_num_id').val()!=""){
		var param = 'crt_num_id='+$('#crt_num_id').val();
	}
	
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/traffic/tpCarNumTitle/tpCarNumTitleList.do',
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
			var crtNumId = this.crt_num_id;
			if(this.crt_num_id==-1){
				crtNumId = "无";
			}
              $tbody.append('<tr>\
            		  <td><div>'+i+'</div></td>\
	                  <td><div>'+this.crt_num_title+'</div></td>\
	                  <td><div>'+crtNumId+'</div></td>\
	                  <td><div>\
	                  <a href="/traffic/tpCarNumTitle/tpCarNumTitleOp.jspx?crt_id='+this.crt_id+'">修改</a>|\
	                  <a href="javascript:void(0);" onclick="deleteById(\''+this.crt_id+'\')">删除</a>\
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

function deleteById(crt_id){
	if(!confirm('确定删除此用户？')) return false;
	$.getJSON('/traffic/tpCarNumTitle/tpCarNumTitleDelete.do',"crt_id="+crt_id,function(json){
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