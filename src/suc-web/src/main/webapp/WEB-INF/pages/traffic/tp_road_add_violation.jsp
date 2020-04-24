<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>

<script src="/resource/checkbox/js/modernizr.js"></script>
		

	<div class="main clearfix">
		<div class="left" id="sec-left">
			<div class="menuTree" id="menuTree"></div>
		</div>
		<div class="right">
			<h2 id="mainTitle" class="mainTitle"><span>添加路口所属违规行为</span></h2>
			<div class="mainContent" >
				<!-- 系统分组管理 start -->
				<div class="box-item">
					<div class="tit"> <span class="arr"></span>
						<h4>添加路口所属违规行为</h4>
					</div>
					<div class="container">
			
			</div>
				<div class="cont" >
					<form id="f_1">
					<input type="hidden" name="ct_id" value="0" /> 
	                <table id="f_tb" class="form">
	                	<thead>
						</thead>
	                	<tbody>
	                    </tbody>
	                </table>
                <div class="nav">
                   <input type="button" onclick="history.back()" value="« 返回" /> |
                   <input type="button" class="button" id="add_save" value="保存" />
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
$('#add_save').click(saveRoadViolationAction);

//加载违法行为列表
function loadViolationAction() {
	var $box=$('#box_list').show();
	var cr_id = $.sysop.kit.getUrlValue('cr_id');
	var param = {};
	param.cr_id = cr_id;
	$.ajax({
		type: 'POST',
		url: '/traffic/tpViolationAction/tpViolationActionListAll.do',
		data: param,
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				var $tbody=$("#f_tb").find('tbody').html('');
				var list = json.object.lists;
				var i = 0;
				$.each(list,function(n,value){
					i++;
					$tbody.append('\
						<input type="checkbox" name="volotion_action" value="'+this.v_id+'" id="checkbox-7-'+i+'" /><label for="checkbox-7-'+i+'"><span>'+this.action_name+'</span></label>\
						');
					if(value.status==1){
						$('input:checkbox[id=checkbox-7-'+i+']').attr("checked", true);
					}
				})
				
				
				
				 
			}else{
				alert(json.message);
			}
		}
	});
}

//保存
function saveRoadViolationAction() {
	var cr_id = $.sysop.kit.getUrlValue('cr_id');
	$('input:checkbox[name=volotion_action]:checked').each(function(i){
       if(0==i){
    	   v_ids = $(this).val();
       }else{
    	   v_ids += (","+$(this).val());
       }
	 });
	var param = {};
	param.road_id = cr_id;
	param.v_ids = v_ids;
	$.ajax({
		type: 'POST',
		url: '/traffic/tpRoad/addViolationAction.do',
		data: param,
		dataType: 'json',
		cache: false,
		async: true,
		success: function(json) {
			if(json.success) {
				alert("添加成功",function(){
				window.location.href="/traffic/tpRoad/tpRoadList.jspx";});
			}else{
				alert("添加失败");
			}
		}
	});
}

$(document).ready(function(){
	loadViolationAction();
});
</script>

<style type="text/css">
body {
	padding: 0;
	margin: 0;
	font-size: 62.5%;
	font-family: Arial, sans-serif;
}

label {
	display: inline;
}

.holder {
	width: 100%;
	background: #f9f9f9;
	margin: 0px auto;
	padding: 60px 0;
	font-size: 1em;
}

.center {
	margin: 0px auto;
}

input[type="checkbox"] {
	display: none;
}

.top-content {
	padding: 40px 0;
}
/*h1 {
	font-size: 3em;
	font-family: 'adelle-sans', sans-serif;
	text-align: center;
}*/

p {
	font-size: 2em;
	font-family: 'adelle-sans', sans-serif;
	text-align: center;
	color: #bbb;
}

/* ==================================================================== */
/* CHECKBOX TYPE 1 ---------------------------------------------------- */
/* ==================================================================== */

[id^="checkbox-1-"] + label {
	background-color: #FFF;
	border: 1px solid #C1CACA;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05);
	padding: 9px;
	border-radius: 5px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
}

[id^="checkbox-1-"] + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}

[id^="checkbox-1-"]:checked + label {
	background-color: #ECF2F7;
	border: 1px solid #92A1AC;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05), inset 15px 10px -12px rgba(255, 255, 255, 0.1);
	color: #243441;
}

[id^="checkbox-1-"]:checked + label:after {
	content: '\2715';
	position: absolute;
	top: 0px;
	left: 0px;
	color: #758794;
	width: 100%;
	text-align: center;
	font-size: 1.4em;
	padding: 1px 0 0 0;
	vertical-align: text-top;
}

#checkbox-1-2 + label {
	width: 10px;
	height: 10px;
}

#checkbox-1-3 + label {
	width: 20px;
	height: 20px;
}

#checkbox-1-2 + label:after {
	left: 0px;
	padding: 6px 0 0 0;
}

#checkbox-1-3 + label:after {
	top: -6px;
	left: 0px;
	padding: 17px 0 0 0;
}
input[type="checkbox"] {
	display: none;
}

input[type="checkbox"] + label {
	cursor: pointer;
	font-size: 1em;
}

/* ==================================================================== */
/* CHECKBOX TYPE 1 ---------------------------------------------------- */
/* ==================================================================== */

[id^="checkbox-1-"] + label {
	background-color: #FFF;
	border: 1px solid #C1CACA;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05);
	padding: 9px;
	border-radius: 5px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
}

[id^="checkbox-1-"] + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}

[id^="checkbox-1-"]:checked + label {
	background-color: #ECF2F7;
	border: 1px solid #92A1AC;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05), inset 15px 10px -12px rgba(255, 255, 255, 0.1);
	color: #243441;
}

[id^="checkbox-1-"]:checked + label:after {
	content: '\2715';
	position: absolute;
	top: 0px;
	left: 0px;
	color: #758794;
	width: 100%;
	text-align: center;
	font-size: 1.4em;
	padding: 1px 0 0 0;
	vertical-align: text-top;
}

#checkbox-1-2 + label {
	width: 10px;
	height: 10px;
}

#checkbox-1-3 + label {
	width: 20px;
	height: 20px;
}

#checkbox-1-2 + label:after {
	left: 0px;
	padding: 6px 0 0 0;
}

#checkbox-1-3 + label:after {
	top: -6px;
	left: 0px;
	padding: 17px 0 0 0;
}



/* ==================================================================== */
/* CHECKBOX TYPE 2 ---------------------------------------------------- */
/* ==================================================================== */

input[id^="checkbox-2-"] + label {
	background-color: #F37900;
	padding: 18px 20px 18px 23px;
	box-shadow: inset 0 50px 37px -30px rgba(255, 222, 197, 0.3), 0 0 13px rgba(0, 0, 0, 0.6);
	border-radius: 1000px;
	display: inline-block;
	position: relative;
	border-top: 1px solid #ECA14F;
	margin-right: 30px;
	color: #FFF;
	font-size: 1.7em;
	width: 213px;
	text-shadow: 0 1px 0 rgba(0, 0, 0, 0.2);
	border-bottom: 1px solid #552B09;
}

[id^="checkbox-2-"] + label:hover  {
	border-top: 1px solid #FC8C1E;
	background: #FC8C1E;
	box-shadow: inset 0 -50px 37px -30px rgba(255, 222, 197, 0.07), 0 0 13px rgba(0, 0, 0, 0.6);
}

[id^="checkbox-2-"] + label:active  {
	border-top: none;
	background: #FC8C1E;
	padding: 19px 20px 18px 23px;
	box-shadow: inset 0 3px 8px rgba(129, 69, 13, 0.3), inset 0 -50px 37px -30px rgba(255, 222, 197, 0.07), 0 0 13px rgba(0, 0, 0, 0.6);	
}

[id^="checkbox-2-"] + label:after {
	content: ' ';
	border-radius: 100px;
	width: 32px;
	position: absolute;
	top: 12px;
	right: 12px;
	box-shadow: inset 0px 16px 40px rgba(0, 0, 0, 0.4);
	height: 32px;
}

[id^="checkbox-2-"] + label:before {
	content: ' ';
	border-radius: 100px;
	width: 20px;
	position: absolute;
	top: 18px;
	right: 18px;
	z-index: 999;
	box-shadow: inset 0px 16px 40px #FFF;
	height: 20px;
	display: none;
}

[id^="checkbox-2-"]:checked + label:before {
	display: block;
}

/* ==================================================================== */
/* CHECKBOX TYPE 3 ---------------------------------------------------- */
/* ==================================================================== */

[id^="checkbox-3-"] + label {
	background-color: #FFF;
	border: 1px solid #C1CACA;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05);
	padding: 9px;
	border-radius: 1000px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
}

[id^="checkbox-3-"] + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.2);
}

[id^="checkbox-3-"]:checked + label {
	background-color: #ECF2F7;
	border: 1px solid #92A1AC;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05), inset 15px 10px -12px rgba(255, 255, 255, 0.1);
	color: #243441;
}

[id^="checkbox-3-"]:checked + label:before {
	content: ' ';
	border-radius: 100px;
	position: absolute;
	background: #253C4B;
	opacity: 0.8;
	display: none;
	box-shadow: inset 0 15px 23px -10px rgba(187, 230, 240, 0.3), 0 2px 2px rgba(0, 0, 0, 0.1);
	top: 3px;
	left: 3px;
	width: 12px;
	height: 12px;
}

[id^="checkbox-3-"]:checked + label:before {
	content: ' ';
	display: block;
}


#checkbox-3-2:checked + label:before {
	top: 4px;
	left: 4px;
	width: 20px;
	height: 20px;
}

#checkbox-3-3:checked + label:before {
	top: 5px;
	left: 5px;
	width: 28px;
	height: 28px;
}

#checkbox-3-2 + label {
	width: 10px;
	height: 10px;
}

#checkbox-3-3 + label {
	width: 20px;
	height: 20px;
}

#checkbox-3-2 + label {
	width: 10px;
	height: 10px;
}

#checkbox-3-3 + label {
	width: 20px;
	height: 20px;
}


/* ==================================================================== */
/* CHECKBOX TYPE 4 ---------------------------------------------------- */
/* ==================================================================== */

[id^="checkbox-4-"] + label {
	background-color: #FFF;
	border: 2px solid #D6846A;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05);
	padding: 9px;
	border-radius: 5px;
	display: inline-block;
	overflow: hidden;
	position: relative;
	margin-right: 30px;
}

[id^="checkbox-4-"] + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}

[id^="checkbox-4-"]:checked + label {
	background-color: #F7F2EC;
	border: 2px solid #C47D62;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05), inset 15px 10px -12px rgba(255, 255, 255, 0.1);
}

[id^="checkbox-4-"] + label:after {
	position: absolute;
	top: 99px;
	-webkit-transition: all 0.3s linear;
	transition: all 0.3s linear;	
	content: '\2715';
	color: #947975;
	width: 100%;
	text-align: center;
	font-size: 1.4em;
	padding: 1px 0 0 0;
	left: 0px;

}

[id^="checkbox-4-"]:checked + label:after {
	top: 0px;
}

#checkbox-4-2 + label {
	width: 10px;
	height: 10px;
}

#checkbox-4-3 + label {
	width: 20px;
	height: 20px;
}

#checkbox-4-2:checked + label:after {
	left: 0px;
	padding: 6px 0 0 0;
}

#checkbox-4-3:checked + label:after {
	left: 0px;
	top: 2px;
	padding: 9px 0 0 0;
}

/* ==================================================================== */
/* CHECKBOX TYPE 5 ---------------------------------------------------- */
/* ==================================================================== */


[id^="checkbox-5-"] + label {
	background-color: #FFF;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05);
	padding: 9px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
	-webkit-transition: all 0.5s linear 0s;
	transition: all 0.5s linear 0s;
}

[id^="checkbox-5-"] + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}

[id^="checkbox-5-"]:checked + label {
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05), inset 15px 10px -12px rgba(255, 255, 255, 0.1);
}

[id^="checkbox-5-"] + label:after {
	-webkit-transform: rotateX(270deg);
	-webkit-transform-origin: 0 0;
	transform: rotateX(270deg);
	transform-origin: 0 0;
	-webkit-transition: all 0.6s ease-in;
	transition: all 0.6s ease-in;
	position: absolute;
	top: 0px;
	left: 0px;
	content: '\2715';
	padding: 9px 0 0 0;
	width: 100%;
	height: 100%;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	background: #fff;
	font-size: 1.5em;
	line-height: 0;
	background: #CCE7F7;
	color: #5C7FA0;
	text-align: center;
}
[id^="checkbox-5-"]:checked + label:after {
	-webkit-transform: rotateX(0);
	transform: rotateX(0);
}

[id^="checkbox-5-"]:checked + label {
	-webkit-transition: all 0.5s linear 0.35s;
	transition: all 0.5s linear 0.35s;
	background: #aaa;
}

#checkbox-5-2 + label, #checkbox-5-5 + label {
	width: 10px;
	height: 10px;
}

#checkbox-5-3 + label, #checkbox-5-6 + label {
	width: 20px;
	height: 20px;
}

#checkbox-5-2 + label:after, #checkbox-5-5 + label:after {
	padding: 14px 0 0 0;
}

#checkbox-5-3 + label:after, #checkbox-5-6 + label:after {
	padding: 18px 0 0 0;
}

/* ==================================================================== */
/* CHECKBOX TYPE 6 ---------------------------------------------------- */
/* ==================================================================== */


[id^="checkbox-6-"] + label {
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05);
	padding: 9px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
	width: 15px;
	height: 15px;
	-webkit-transition: all 0.5s linear 0s;
	transition: all 0.5s linear 0s;
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-transform-origin: 100%;
	transform-origin: 100% 100%;
}

[id^="checkbox-6-"] + label:after {
	-webkit-transform: rotateX(90deg) rotateY(0deg);
	-webkit-transform-origin: 0 0;
	transform: rotateX(90deg) rotateY(0deg);
	transform-origin: 0 0;
	-webkit-transition: all 0.3s ease-in;
	transition: all 0.3s ease-in;
	position: absolute;
	top: 0px;
	left: 0px;
	content: '\2715';
	padding: 15px 0 0 0;
	width: 100%;
	height: 100%;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	background: #fff;
	font-size: 1.5em;
	line-height: 0;
	background: #3C809B;
	color: #F0F6FC;
	text-align: center;
}

[id^="checkbox-6-"] + label:before {
	position: absolute;
	top: 0px;
	left: 0px;
	content: ' ';
	padding: 9px 0 0 0;
	width: 100%;
	height: 100%;
	-webkit-transition: all 0.3s ease-in;
	transition: all 0.3s ease-in;
	background: #fff;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
}

[id^="checkbox-6-"]:checked + label:before {
	background: #ccc;
}

#checkbox-6-2 + label:after {	
	-webkit-transform: rotateY(-90deg);
	-webkit-transform-origin: 0 0;
	transform: rotateY(-90deg);
	transform-origin: 0 0;
}


#checkbox-6-3 + label:after {	
	-webkit-transform: rotateY(90deg);
	-webkit-transform-origin: 100% 100%;
	transform: rotateY(90deg);
	transform-origin: 100% 100%;
}


#checkbox-6-4 + label:after {	
	-webkit-transform: rotateX(-90deg);
	-webkit-transform-origin: 100% 100%;
	transform: rotateX(-90deg);
	transform-origin: 100% 100%;
}

[id^="checkbox-6-"]:checked + label:after {
	-webkit-transform: rotateX(0deg) rotateY(0deg) !important;
	transform: rotateX(0deg) rotateY(0deg) !important;
}


/* ==================================================================== */
/* CHECKBOX TYPE 7 ---------------------------------------------------- */
/* ==================================================================== */


[id^="checkbox-7-"] + label {
	background-color: #FFF;
	padding: 6px 43px 8px 9px;
	border-radius: 5px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
	box-shadow: 0 0 2px rgba(0,0,0,0.3);
	height: 17px;
	overflow: hidden;
	font-size: 1.3em !important;
	color: #464E50;
	-webkit-transition: all 0.3s linear, color 0 linear;
	transition: all 0.3s linear, color 0 linear;
}

[id^="checkbox-7-"] + label:after {
	content: ' ';
	position: absolute;
	background: #FFF;
	top: 4px;
	right: 3px;
	width: 24px;
	display: block;
	font-size: 1em !important;
	height: 16px;
	border-radius: 3px;
	box-shadow: 0 0 1px rgba(0, 0, 0, 0.6), inset 0 -18px 15px -10px rgba(0, 0, 0, 0.05);
	padding: 4px 0px;
	text-align: center;
	color: #496F7A;
}

[id^="checkbox-7-"]:checked + label {
	color: #fff;
}

[id^="checkbox-7-"] + label > span {
	position: relative;
	z-index: 99999;
	font-family: 'adelle-sans', sans-serif;
}

[id^="checkbox-7-"]:active + label:after {
	box-shadow: 0 0 1px rgba(0, 0, 0, 0.6), inset 0 2px 6px rgba(0, 0, 0, 0.1), inset 0 -18px 15px -10px rgba(0, 0, 0, 0.05);

}

[id^="checkbox-7-"]:checked + label:after {
	content: '\2715';
}

[id^="checkbox-7-"] + label:before {
	content: ' ';
	position: absolute;
	background: #AAAAAA;
	width: 0%;
	height: 100%;
	top: 0;
	-webkit-transition: all 0.3s ease-in;
	transition: all 0.3s ease-in;
	left: 0;
}

[id^="checkbox-7-"]:checked + label:before {
	content: ' ';
	position: absolute;
	width: 100%;
	height: 100%;
	text-shadow: 0 1px 0 rgba(0,0,0,0.1);
	top: 0;
	left: 0;
}

#checkbox-7-2 + label:before {
	width: 100%;
	height: 0;
}
#checkbox-7-2:checked + label:before {
	width: 100%;
	height: 100%;
}

#checkbox-7-3 + label:before {
	width: 100%;
	height: 0;
	bottom: 0;
	top: auto;
}
#checkbox-7-3:checked + label:before {
	width: 100%;
	height: 100%;
}

#checkbox-7-4 + label:before {
	width: 0;
	height: 100%;
	left: auto;
	right: 0;
}
#checkbox-7-4:checked + label:before {
	width: 100%;
	height: 100%;
}


/* ==================================================================== */
/* CHECKBOX TYPE 8 ---------------------------------------------------- */
/* ==================================================================== */


[id^="checkbox-8-"] + label {
	background-color: #FFF;
	padding: 9px;
	border-radius: 50px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
	width: 40px;
	height: 15px;
}

[id^="checkbox-8-"] + label:after {
	content: ' ';
	position: absolute;
	background: #E6332C;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	border-radius: 100px;
	box-shadow: inset 0 0 20px rgba(0,0,0,0.2);
}

[id^="checkbox-8-"] + label:before {
	content: ' ';
	position: absolute;
	background: white;
	top: 2px;
	left: 2px;
	z-index: 99999;
	width: 29px;
	height: 29px;
	border-radius: 100px;
	box-shadow: 0 0 2px rgba(0,0,0,0.5), inset 0 -18px 15px -10px rgba(0,0,0,0.05);
}


[id^="checkbox-8-"] + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}

[id^="checkbox-8-"]:checked + label:before {
	content: ' ';
	position: absolute;
	left: 27px;
	border-radius: 100px;
}

#checkbox-8-1 + label, #checkbox-8-2 + label {
	overflow: hidden;
}

[id^="checkbox-8-"]:checked + label:after {
	content: ' ';
	font-size: 1.5em;
	position: absolute;
	background: #63C99C;
}

#checkbox-8-2 + label:after, #checkbox-8-2 + label:before, #checkbox label,
#checkbox-8-4 + label:after, #checkbox-8-4 + label:before, #checkbox label {
	-webkit-transition: all 0.1s ease-in;
	transition: all 0.1s ease-in;
}

#checkbox-8-3 + label:before, #checkbox-8-4 + label:before {
	width: 35px;
	height: 35px;
	top: -1px;
	left: -1px;
}

#checkbox-8-3:checked + label:before, #checkbox-8-4:checked + label:before {
	left: 27px;
}

/* ==================================================================== */
/* CHECKBOX TYPE 9 ---------------------------------------------------- */
/* ==================================================================== */


[id^="checkbox-9-"] + label {
	background-color: #FFF;
	padding: 9px;
	border-radius: 5px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
	width: 45px;
	box-shadow: 0 0 1px rgba(0,0,0,0.6);
	height: 10px;
}

[id^="checkbox-9-"] + label:before {
	content: ' ';
	position: absolute;
	background: white;
	top: -1px;
	z-index: 99999;
	left: -1px;
	width: 21px;
	height: 30px;
	border-radius: 3px;
	box-shadow: 0 0 1px rgba(0,0,0,0.6), inset 0 -18px 15px -10px rgba(0,0,0,0.05);
}

[id^="checkbox-9-"] + label:after {
	content: 'NO';
	position: absolute;
	top: 7px;
	left: 37px;
	font-size: 1.2em;
	color: #868686;
}

[id^="checkbox-9-"]:checked + label:after {
	content: 'YES';
	left: 8px;
	color: #21BE92;
}

[id^="checkbox-9-"]:checked + label:before {
	content: ' ';
	position: absolute;
	z-index: 99999;
	left: 44px;
}

#checkbox-9-3 + label:before, #checkbox-9-4 + label:before {
	width: 21px;
	height: 24px;
	top: 2px;
	left: 2px;
}

#checkbox-9-3:checked + label:before, #checkbox-9-4:checked + label:before {
	left: 40px;
}

#checkbox-9-2 + label:after, #checkbox-9-2 + label:before, #checkbox label,
#checkbox-9-4 + label:after, #checkbox-9-4 + label:before, #checkbox label {
	-webkit-transition: all 0.1s ease-in;
	transition: all 0.1s ease-in;
}

/* ==================================================================== */
/* CHECKBOX TYPE 10 ---------------------------------------------------- */
/* ==================================================================== */


[id^="checkbox-10-"] + label {
	background-color: #fafbfa;
	padding: 9px;
	border-radius: 50px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
	-webkit-transition: all 0.1s ease-in;
	transition: all 0.1s ease-in;
	width: 40px;
	height: 15px;
}

[id^="checkbox-10-"] + label:after {
	content: ' ';
	position: absolute;
	top: 0;
	-webkit-transition: box-shadow 0.1s ease-in;
	transition: box-shadow 0.1s ease-in;
	left: 0;
	width: 100%;
	height: 100%;
	border-radius: 100px;
	box-shadow: inset 0 0 0 0 #eee, 0 0 1px rgba(0,0,0,0.4);
}

[id^="checkbox-10-"] + label:before {
	content: ' ';
	position: absolute;
	background: white;
	top: 1px;
	left: 1px;
	z-index: 999999;
	width: 31px;
	-webkit-transition: all 0.1s ease-in;
	transition: all 0.1s ease-in;
	height: 31px;
	border-radius: 100px;
	box-shadow: 0 3px 1px rgba(0,0,0,0.05), 0 0px 1px rgba(0,0,0,0.3);
}

[id^="checkbox-10-"]:active + label:after {
	box-shadow: inset 0 0 0 20px #eee, 0 0 1px #eee;
}

[id^="checkbox-10-"]:active + label:before {
	width: 37px;
}

[id^="checkbox-10-"]:checked:active + label:before {
	width: 37px;
	left: 20px;
}

[id^="checkbox-10-"] + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}

[id^="checkbox-10-"]:checked + label:before {
	content: ' ';
	position: absolute;
	left: 26px;
	border-radius: 100px;
}

[id^="checkbox-10-"]:checked + label:after {
	content: ' ';
	font-size: 1.5em;
	position: absolute;
	background: #4cda60;
	box-shadow: 0 0 1px #4cda60;
}

/* ==================================================================== */
/* CHECKBOX TYPE 11 ---------------------------------------------------- */
/* ==================================================================== */


[id^="checkbox-11-"] + label {
	background-color: #FFF;
	padding: 11px 9px;
	border-radius: 7px;
	display: inline-block;
	position: relative;
	margin-right: 30px;
	background: #F7836D;
	width: 55px;
	height: 10px;
	box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.1), 0 0 10px rgba(245, 146, 146, 0.4);
}

[id^="checkbox-11-"] + label:before {
	content: ' ';
	position: absolute;
	background: #FFF;
	top: 0px;
	z-index: 99999;
	left: 0px;
	width: 24px;
	color: #FFF;
	height: 32px;
	border-radius: 7px;
	box-shadow: 0 0 1px rgba(0,0,0,0.6);
}

[id^="checkbox-11-"] + label:after {
	content: 'OFF';
	position: absolute;
	top: 7px;
	left: 37px;
	font-size: 1.2em;
	color: white;
	font-weight: bold;
	left: 8px;
	padding: 5px;
	top: 4px;
	border-radius: 100px;
}

[id^="checkbox-11-"]:checked + label {
	background: #67A5DF;
	box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.1), 0 0 10px rgba(146, 196, 245, 0.4);
}

[id^="checkbox-11-"]:checked + label:after {
	content: 'ON';
	left: 6px;
}

[id^="checkbox-11-"]:checked + label:before {
	content: ' ';
	position: absolute;
	z-index: 99999;
	left: 49px;
}


[id^="checkbox-11-"] + label:after {
	left: 35px;	
}	

#checkbox-11-3 + label:before {
	width: 21px;
	height: 22px;
	top: 3px;
	left: 3px;
}

#checkbox-11-3:checked + label:before {
	left: 49px;
}

#checkbox-11-2 + label:after, #checkbox-11-2 + label:before, #checkbox label {	
	-webkit-transition: all 0.1s ease-in;
	transition: all 0.1s ease-in;
}

</style>
</body>
</html>