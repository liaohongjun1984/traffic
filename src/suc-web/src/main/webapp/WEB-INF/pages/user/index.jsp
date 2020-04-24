<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_index.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
  			<h2 class="mainTitle" id="mainTitle"><span>最新动态</span></h2>
  		 	<div class="mainContent">
          <div class="feed">
            <ul class="feed-list" id="J_feedList">
            </ul>
            <div id="paginationbar" class="paginationbar"></div>
            <!--分页导航-->
            <div id="displayNum" class="displayNum">
              <span class="tip-hover btn" tip="#displayNum_cont">每页显示...</span><span id="displayNum_cont" class="cont"><a rel="10">10条</a><span class="cur">20条</span><a rel="50">50条</a><a rel="100" style="margin-right:0;">100条</a></span>
            </div>
            <!--每页显示数目导航-->
            <div class="clear"></div>
          </div>
  		 		<!-- 常用链接 start -->
  		 		
  		 		<!-- 常用链接 end -->
  		 	</div>
  		</div>
<script type="text/javascript">
	$(function(){
		
		function loadFeeds(page,disR){	//加载信息流
			var fn = arguments.callee;
			var req = '/user/infoFlowList.do';
			var param = 'page='+ (page || 1) + '&displayRecord=' + (disR || 10);
			$.getJSON(req,param,function(data){
				if( data.success){
					var object = data.object;
					var count = object.count,list = object.lists,p = object.page,pCount = object.pageCount;
					var J_feedList = $('#J_feedList');
					J_feedList.html('');
					var html = '';
					$.each(list,function(i,item){
						var time = new Date(item.create_time).toLocaleString();
						html += '<li class="feed-item">\
					                <p>\
					                  <span class="time">'+ time +'</span>\
					                  <strong>'+ item.user_name +'</strong>\
					                  <span class="do">'+ item.value +'</span>\
					                  <span class="what">'+ item.cn_name +'</span>\
					                </p>\
					              </li>';
					})
					J_feedList.html(html);
					if(pCount>0){
						//分页
						var $pag=$('.paginationbar'),$dis=$('.displayNum');
						$.sysop.pagination.init($pag,p,pCount,20,function(num){
							fn(num,disR);
						});
						//显示数目
						$.sysop.pagination.displayNum($dis,disR,function(){
							fn(1,this.innerHTML.slice(0,-1));
						});
					}
				}
			})
		}
	loadFeeds();	
	
})

</script>
</body>
</html>
