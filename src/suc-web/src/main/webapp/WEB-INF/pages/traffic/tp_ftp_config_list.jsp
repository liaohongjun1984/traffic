<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>FTP服务器管理</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>FTP服务器列表</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>服务器地址：</span>
							<input type="search" placeholder="服务器地址" name="ftp_host" id="ftp_host" />
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
            				<a href="/traffic/tpFtpConfig/tpFtpConfigOp.jspx" class="button fr">添加FTP服务器</a>
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>名称</td>            
									<td>服务器地址</td>
									<td>服务器端口</td>
									<td>服务器帐号</td>
									<td>服务器密码</td>
									<td>创建时间</td>
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
	var param = 'ftp_host='+$('#ftp_host').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/traffic/tpFtpConfig/tpFtpConfigList.do',
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
	                  <td><div>'+this.ftp_mark+'</div></td>\
	                  <td><div>'+this.ftp_host+'</div></td>\
	                  <td><div>'+this.ftp_port+'</div></td>\
	                  <td><div>'+this.ftp_user+'</div></td>\
	                  <td><div>'+this.ftp_pwd+'</div></td>\
	                  <td><div>'+this.create_time+'</div></td>\
	                  <td><div>\
	                  <a href="/traffic/tpFtpConfig/tpFtpConfigOp.jspx?id='+this.id+'">修改</a>|\
	                  <a href="javascript:void(0);" onclick="deleteById(\''+this.id+'\')">删除</a>\
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

function deleteById(id){
	if(!confirm('确定删除此用户？')) return false;
	$.getJSON('/traffic/tpFtpConfig/tpFtpConfigDelete.do',"id="+id,function(json){
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