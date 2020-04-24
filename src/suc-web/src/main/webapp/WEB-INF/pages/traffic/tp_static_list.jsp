<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right" id="box_list">
			<h2 id="mainTitle" class="mainTitle"><span>审核管理</span></h2>
			<div class="mainContent">
				<!-- 用户管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>审核管理</h4><span class="right count"></span>
					</div>
					<div class="cont">
						<div class="action-bar">
							<span>日期：</span>
							<input type="text" placeholder="开始时间" name="keyword" id="beginTime" class="beginTime" onclick="$.calendar.Show({format:'yyyy-MM-dd'})" />
							<input type="text" placeholder="结束时间" name="keyword" id="endTime" class="endTime" onclick="$.calendar.Show({format:'yyyy-MM-dd'})" />&nbsp;
							<input type="button" class="button" id="search_user" value="搜索" onclick="searchData()" />
                    	</div>
						<table class="cyan tb-actorList">
							<thead>
								<tr>
									<td>序号</td>
									<td>中队警员</td>
									<td>上传数</td>
									<td>已核对</td>
									<td>无效</td>
									<td>日期</td>    
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
	var param = 'beginTime='+$('#beginTime').val()+'&endTime='+$('#endTime').val();
	var req   =  param+'&page='+(page||1)+'&displayRecord='+(disR=disR||20);//默认20
	$.ajax({
        type: "get",
        async: false,
        url: '/traffic/tpStatistics/tpStatisticsList.do',
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
            		  <td><div>'+this.user_name+'</div></td>\
            		  <td><div>'+this.up_num+'</div></td>\
	                  <td><div>'+this.checked+'</div></td>\
	                  <td><div>'+this.invalid+'</div></td>\
	                  <td><div>'+this.date+'</div></td>\
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

function deleteById(ct_id){
	if(!confirm('确定删除此用户？')) return false;
	$.getJSON('/traffic/tpCarType/tpCarTypeDelete.do',"ct_id="+ct_id,function(json){
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