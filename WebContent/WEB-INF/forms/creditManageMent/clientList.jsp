<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>征信配置</title>
<style>
</style>
<script type="text/javascript">

	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
</head>
<body style="background-color: #ffffff;">
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">客户认证资料导入列表</span>
		</div>
		  <form action="FrmClientList.importCustomerExcel" enctype="multipart/form-data" method="post">
			<input type="file" name="excel" style="margin-left:111px;margin-right:10px;text-indent:4px;">
			<button type="submit" class="bigBtn_style" style="margin-right:5px;">导入客户认证资料</button>
		</form> 
		<form action="FrmClientList" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<span>按用户手机号：</span><input type="text" name="mobile_"> 
					<span>按状态查询：</span>
						<select name="status_">
							<option value="1">有效</option>
							<option value="2">失效</option>
						</select>
				</div>
				
	            <div class="fr rightSide">
	                <input type="submit" value="查询" id="sub">
	                <a href="FrmExcel?service=SvrGetClientLog&amp;exportKey=SvrGetClientLog&amp;templateId=SvrGetClientLog"><input type="button" value="查询结果导出"></a>
	            </div>
			</div>
		</form>
		<div role="grid" class="mt_20">
			<div class="table">
				<table class="tbl">
					<tbody>
						<tr>
							<td class="t-head">序号</td>
							<td class="t-head">用户手机号<br/>(主键)</td>
							<td class="t-head">资料来源</td>
							<td class="t-head">用户属性</td>
							<td class="t-head">资料责任人</td>
							<td class="t-head">状态</td>
							<td class="t-head">操作</td>
						</tr>
					<tbody>
					<tbody class="t-body tc">
						<c:forEach items="${sesame }" var="sesame" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${sesame.items.userCode_}</td>
								<td>${sesame.items.source_}</td>
								<td>${sesame.items.attributes_}</td>
								<td>${sesame.items.dataRen_}</td>
								<td>${sesame.items.status_}</td>
								<td>
									<span class="btn_style" onclick="up('${sesame.items.UID_}', '${sesame.items.status_}')">变更状态</span>
									<span class="btn_style" onclick="del('${sesame.items.UID_}')">删除</span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function up(id_, status_){
			if (window.confirm('友情提示：你确定变更状态吗？\n\n请确认！！！')) {
			    $.ajax({
					url : 'FrmClientList.up',
					dataType : 'json',
					type : 'post',
					data : { 
						"id_" : id_,
						"status_" : status_
					},
					cache : false,
					success : function(data) {
						if(data == true){
							alert("变更状态成功！\n\n前台用户下单实时更新此配置！");
							window.location.href='FrmClientList';
						}else{
							alert("变更状态失败!")
						}
					}
					});
			} else {
				return false;
			}
		}
		function del(id_){
			if (window.confirm('友情提示：你确定要删除吗？\n\n请确认！！！')) {
			    $.ajax({
					url : 'FrmClientList.del',
					dataType : 'json',
					type : 'post',
					data : { 
						"id_" : id_
					},
					cache : false,
					success : function(data) {
						if(data == true){
							alert("删除成功！");
							window.location.href='FrmClientList';
						}else{
							alert("删除失败！")
						}
					}
					});
			} else {
				return false;
			}
		}
	</script>
</body>
</html>
