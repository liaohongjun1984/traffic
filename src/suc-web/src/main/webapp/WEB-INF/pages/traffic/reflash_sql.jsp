<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>数据更新</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>数据更新</h4>
					</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="v_id" value="0" /> 
	                <table id="f_tb" class="" width="500">
	                	<tbody>
	                        <tr>
	                        	<th><em class="em">*</em>sql语句：</th>
	                        	<td>
	                        		<textarea cols="100" rows="10" id="sql" name="sql" class="sql"></textarea>
	                            </td>
	                        </tr>   
	                    </tbody>
	                </table>
                <div class="nav">
                   <input type="button" onclick="history.back()" value="« 返回" /> |
                   <input type="button" class="button" id="add_save" value="执行" />
                </div>
                </form>

				<!-- 角色管理 end -->
			</div>
		</div>
		<!-- right end -->
	</div>
	<!-- mani end -->
	<div class="footer clearfix"></div>
</div>
<script>
$('#f_1').validationEngine({validationEventTriggers:"focusout",promptPosition : "topRight", scroll: false});
$('#add_save').click(add);

//加载属于路口的违法行为
function add() {
	var sql = $("#sql").val();
	$.ajax({
		type: 'POST',
		url: '/traffic/mysql/reflashSQL.do',
		data: {'sql':sql},
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				alert("执行成功");
				$("#sql").val('');
				return;
			}else{
				alert("执行失败");
				return;
			}
		}
	});
}

</script>
</body>
</html>