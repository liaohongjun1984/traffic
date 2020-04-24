<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/include/head_new.jsp"></jsp:include>
<div class="main clearfix">
	<div class="left" id="sec-left">
		<div class="menuTree" id="menuTree"></div>
	</div>
	<div class="right">
		<h2 id="mainTitle" class="mainTitle">
			<span>机构管理</span>
		</h2>
		<div class="mainContent">
			<div class="box-item">
				<div class="tit">
					<span class="arr"></span>
					<h4>机构管理</h4>
				</div>
				<div class="top">
					<!-- 				<span>empty</span> -->
				</div>
				<div class="cont-border">
					<form id="f_1" name="f_1">
						<table class="form" style="margin-top: 0;">
							<tbody>
								<tr>
									<td style="width: 40%;">
										<div id="menuTreeOS" class="menuTreeOs" style="width: 95%;">treeMenu</div>
									</td>
									<td style="width: 60%;">
										<div class="box-item"
											style="width: 100%; border: 1px solid #aaa;">
											<div class="tit">
												<h4>修改区域节点树</h4>
											</div>
											<input type="hidden" id="parentCode" name="parentCode"
												value="" /> <input type="hidden" id="curOrgCode"
												name="curOrgCode" value="" /> <input type="hidden"
												id="flag" name="flag" value="0" />
											<table id="f_tb" class="form" style="margin-top: 0;">
												<tbody>
													<tr>
														<th><em class="em">*</em>上级机构：</th>
														<td><input type="text" class="validate[required]"
															id="orgParName" name="orgParName" placeholder="请输入上级机构" readonly="readonly"/></td>
													</tr>
													<tr>
														<th><em class="em">*</em>机构名称：</th>
														<td><input type="text" class="validate[required]"
															id="organizationName" name="organizationName"
															placeholder="请输入机构名称" /></td>
													</tr>
													<tr>
														<th><em class="em">*</em>联系地址：</th>
														<td><input type="text" class="validate[required]"
															id="address" name="address" placeholder="请输入联系地址" /></td>
													</tr>
													<tr>
														<th><em class="em">*</em>邮政编码：</th>
														<td><input type="text" class="validate[required]"
															id="postcode" name="postcode" placeholder="请输入邮政编码" /></td>
													</tr>
													<tr>
														<th><em class="em">*</em>序号：</th>
														<td><input type="text" class="validate[required]"
															id="serialNum" name="serialNum" placeholder="请输入序号" /></td>
													</tr>
													<tr>
														<td colspan="2">
															<div class="nav" style="padding-left: 20px;">
																<input type="button" class="button" id="update_org"
																	value="保存" />&nbsp;&nbsp;&nbsp;&nbsp;<input
																	type="button" class="button" id="add_org" value="新增子机构" />&nbsp;&nbsp;&nbsp;
																<input type="button" class="button" id="delete_org"
																	value="删除" />
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- right end -->
	<div class="footer clearfix"></div>
</div>
<!-- main end -->
<script>
	//by Tanj, 04June2014
	function buildTreeModel(listData) {
		var treeData = [];
		var isNeed = function(menu, parent_id) {
			if (menu.parent_id == parent_id) {
				return true;
			}
			return false;
		};
		var curAdd = function(list, parentId) {
			$.each(list, function() {
				if (this.parent_id == parentId) {
					this.checked = false;
					var currParentId = this.menu_id;
					var children = $.grep(listData, function(menu) {
						return isNeed(menu, currParentId);
					});
					this.children = children;

					curAdd(this.children, currParentId);
				}
			});
		};

		var parentId = "00";
		$.each(listData, function() {
			if (this.parent_id == parentId) {
				this.checked = false;
				var currParentId = this.menu_id;
				var children = $.grep(listData, function(menu) {
					return isNeed(menu, currParentId);
				});
				this.children = children;
				treeData.push(this);

				curAdd(this.children, currParentId);
			}
		});

		return treeData;
	}
	//过滤数组
	function filterTreeData(listData) {
		var treeData = [];
		var isNeed = function(menu, parent_id) {
			if (menu.parent_id == parent_id) {
				return true;
			}
			return false;
		};
		$.each(listData, function() {
			if (this.parent_id == 0) {
				this.checked = false;
				var currParentId = this.menu_id;
				var children = $.grep(listData, function(menu) {
					return isNeed(menu, currParentId);
				});
				this.children = children;
				treeData.push(this);
			}
		});
		return treeData;
	}
	//反向
	var filter = function(arr) {
		var newarr = [];
		$.each(arr, function(i, n) {
			if (n.children) {
				newarr = newarr.concat(n.children);
				delete n.children;
			}
		});
		if (newarr.length !== 0) {
			$.each(newarr, function(i, n) {
				arr.push(n);
			});
		}
		return arr;
	};
	$(function() {
		$.ajaxSetup({
			cache : false
		});
		function reloadTree() {
			var app_id = $('#J_sysName').val();
			loadTreeMenuGroup(app_id, {
				unfold : true,
				checkbox : false,
				editable : true,
				link : false,
				fn_addItem : callback_addItem,
				fn_delItem : callback_delItem,
				fn_editItem : callback_saveTree,
				fn_reloadTree : reloadTree
			});
		}
		//XXX
		loadOrganizationTree({
			unfold : true,
			checkbox : false,
			editable : true,
			link : false
		});

		function addandupdate() {
			var flag = $("#flag").val();
			if (flag == 0) {
				callback_updateOrgTree();
			} else if (flag == 1) {
				alert("增加子节点");

				callback_addOrgItem();
			}

		}

		$('#update_org').click(addandupdate);

		//保存修改的机构信息zgh
		function callback_updateOrgTree() {

			var req = $('#f_1').serialize();
			var url = '/admin/user/modifiyOrg.do';
			$
					.getJSON(
							url,
							req,
							function(json) {
								if (!json.success) {
									alert(json.message);
									return;
								}
								$.sysop.popup
										.autoTip(
												'修改区域信息['
														+ $('#userName').val()
														+ ']成功.',
												function() {
													window.location.href = "/admin/user_organizationlist.jspx";
												});
							});
		}

		//新增机构节点（真正新增）zgh
		function callback_addOrgItem() {
			var req = $('#f_1').serialize();
			var url = '/admin/user/addOrg.do';
			$
					.getJSON(
							url,
							req,
							function(json) {
								if (!json.success) {
									alert(json.message);
									return;
								}
								$.sysop.popup
										.autoTip(
												'修改区域信息['
														+ $('#userName').val()
														+ ']成功.',
												function() {
													window.location.href = "/admin/user_organizationlist.jspx";
												});
							});
		}

		//新增子节点zgh
		$("#add_org").click(
				function() {
					alert("新增子节点");
					var param = {};
					param["parentCode"] = $("#curOrgCode").val();
					param["orgParName"] = $("#organizationName").val();
					$.post('/admin/user/queryParOrganizationInfo.do', param,
							function(data) {
								if (data.success) {
									$("#parentCode")
											.val(data.object.parentCode);
									$("#curOrgCode")
											.val(data.object.curOrgCode);
									$("#orgParName")
											.val(data.object.orgParName);
									$("#flag").val("1");
									$("#organizationName").val("");
									$("#address").val("");
									$("#postcode").val("");
									$("#address").val("");
									$("#address").val("");
									$("#serialNum").val("");
									$.sysop.popup.autoTip('操作成功！');
								} else {
									alert(data.message);
								}
							});

				});

		$('#delete_org').click(callback_deleteOrgTree);
		//删除的机构信息zgh
		function callback_deleteOrgTree() {

			var param = {};
			param["curOrgCode"] = $("#curOrgCode").val();
			alert($("#curOrgCode").val());
			$.post('/admin/user/removeOrg.do', param, function(data) {
				if (data.success) {

					$.sysop.popup.autoTip('操作成功！');
				} else {
					alert(data.message);
				}
			});
		}

		//编辑树 保存功能
		function callback_saveTree(app_id, flag) {
			var json = menuOS.parseItem();
			var jsonStr = filter(json);
			var jsonStr2 = $.sysop.kit.obj2Str(jsonStr);

			var param = {};
			param["data"] = jsonStr2;
			$.post('/admin/menu/modifyMenu.do', param, function(data) {
				if (data.success) {
					if (!flag) {
						$.sysop.popup.autoTip('操作成功！');
						reloadTree();
					}
				} else {
					alert(data.message);
				}
			});
		}
		//新增节点
		function callback_addItem(param) {
			$.post('/admin/menu/addMenu.do?', param, function(data) {
				if (data.success) {
					$.sysop.popup.autoTip('操作成功！');
					reloadTree();
				} else {
					alert(data.message);
				}
			});
		}
		//删除节点
		function callback_delItem(menu_id) {
			$.getJSON('/admin/menu/removeMenu.do?menu_id=' + menu_id, function(
					data) {
				if (data.success) {
					$.sysop.popup.autoTip('操作成功！');
					reloadTree();
				} else {
					alert(data.message);
				}
			});
		}
		//loadTreeMenuGroup(1,{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:callback_addItem,fn_delItem:callback_delItem,fn_editItem:callback_saveTree});
		//渲染树
		function loadTreeMenuGroup(app_id, setting) { //setting : {unfold:true,checkbox:false,editable:true,link:false}
			$.getJSON('/admin/menu/listByAppId.do?app_id=' + app_id, function(
					data) {
				if (data.success) {
					var list = filterTreeData(data.object);
					console.log($.sysop.kit.obj2Str(list));
					if (list == '') {
						var arr = [ {
							"app_id" : app_id,
							"menu_id" : '0',
							"parent_id" : 0,
							"name" : "新增菜单",
							"url" : "#"
						} ];
						var param = 'menu_id=0&parent_id=0&app_id=' + app_id
								+ '&name=新增菜单&url=#';
						menuOS = new menuTree();
						menuOS.bindData(arr);
						menuOS.draw('#menuTreeOS', setting);
						callback_addItem(param);
						return;
					}
					menuOS = new menuTree();
					menuOS.bindData(list);
					menuOS.draw('#menuTreeOS', setting);
				} else {
					alert(data.message);
				}
			});
		}
		//区域节点树
		function loadOrganizationTree(setting) { //setting : {unfold:true,checkbox:false,editable:true,link:false}
			$.getJSON('/admin/user/listAllOrgs.do', function(data) {
				if (data.success) {
					var list = buildTreeModel(data.object);
					console.log($.sysop.kit.obj2Str(list));
					if (list == '') {
						var arr = [ {
							"app_id" : app_id,
							"menu_id" : '0',
							"parent_id" : 0,
							"name" : "新增机构节点",
							"url" : "#"
						} ];
						menuOS = new menuTree();
						menuOS.bindData(arr);
						menuOS.draw('#menuTreeOS', setting);
						return;
					}
					menuOS = new menuTree();
					menuOS.bindData(list);
					menuOS.draw('#menuTreeOS', setting);
					
					//点击树，右边显示此树的相应信息
					$("#menuTreeOS").find("a").each(function() {
						$(this).click(function() {

								var json = menuOS.parseItem();
								var jsonStr = filter(json);
								var jsonStr2 = $.sysop.kit.obj2Str(jsonStr);

								var param = {};
								param["parentCode"] = $(this).attr("parent_id");
								param["curOrgCode"] = $(this).attr("menu_id");
								param["data"] = jsonStr2;
								$.post('/admin/user/queryOrganizationInfo.do',param,function(data) {
										if (data.success) {
											$("#parentCode").val(data.object.parentCode);
											$("#curOrgCode").val(data.object.curOrgCode);
											$("#organizationName").val(data.object.organizationName);
											$("#address").val(data.object.address);
											$("#postcode").val(data.object.postcode);
											$("#address").val(data.object.address);
											$("#address").val(data.object.address);
											$("#orgParName").val(data.object.orgParName);
											$("#serialNum").val(data.object.serialNum);
											$("#flag").val("0");
											$.sysop.popup.autoTip('操作成功！');
										} else {
											alert(data.message);
										}
								});
						});
					});
				} else {
					alert(data.message);
				}
			});
		}
		//分组
		var loadGroupList = function() {
			$.getJSON('/admin/appGroupList.do', function(data) {
				if (data.success) {
					var list = data.object;
					$.each(list, function(n, item) {
						$('#J_sysGroup').append(
								'<option value="'+item.app_group_id+'">'
										+ item.name + '</option>');
					});
				} else {
					alert(data.message);
				}
			});
		};
		//选择系统
		var loadAppList = function(id) {
			if (id == 0 || id == '') {
				$('#J_sysName').html('<option value="0">请选择</option>');
				return;
			}
			$.getJSON('/admin/getAppList.do?app_group_id=' + id + '&status=1',
					function(data) {
						if (data.success) {
							var list = data.object;
							$('#J_sysName').html(
									'<option value="">请选择</option>');
							$.each(list, function(n, item) {
								$('#J_sysName').append(
										'<option value="'+item.app_id+'">'
												+ item.cn_name + '</option>');
							});
						} else {
							alert(data.message);
						}
					});
		};
		//加载分组
		loadGroupList();
		//加载系统列表
		$('#J_sysGroup').change(function() {
			loadAppList($(this).val());
		});
		//加载树形菜单
		$('#J_sysName').change(function() {
			var app_id = $(this).val();
			if (app_id == '') {
				alert('请选择');
				return;
			}
			loadTreeMenuGroup(app_id, {
				unfold : true,
				checkbox : false,
				editable : true,
				link : false,
				fn_addItem : callback_addItem,
				fn_delItem : callback_delItem,
				fn_editItem : callback_saveTree,
				fn_reloadTree : reloadTree
			});
		});

		var saveTree = function() {
			var json = menuOS.parseItem();
			//var jsonStr = $.sysop.kit.obj2Str(json);
			var jsonStr2 = filter(json);
			var jsonStr3 = $.sysop.kit.obj2Str(jsonStr2);
			console.log(json);
			//console.log(jsonStr);
			console.log(jsonStr2);
			console.log(jsonStr3);
			return false;
		};
		//$('#add_save').click(saveTree);
		//loadTreeMenuGroup(1,{unfold:true,checkbox:false,editable:true,link:false,fn_addItem:callback_addItem,fn_delItem:callback_delItem,fn_editItem:callback_saveTree});

	});
</script>
</body>
</html>
