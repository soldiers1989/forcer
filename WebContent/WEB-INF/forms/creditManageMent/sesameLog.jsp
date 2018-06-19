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
			<span class="min-col f16">芝麻信用认证列表</span>
		</div>
		<form action="" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<!-- <div class="fl leftSide">
				<a href="javascript:window.history.go(-1);" class="btn_style">返回</a>
			</div>
			<div class="fr rightSide"></div> -->
				<div class="fl leftSide">
					<span>按手机号：</span><input type="text"> <span>按姓名：</span><input
						type="text"> <span>按身份证号码：</span><input type="text">
					<span>按发起次数：</span><input type="text"> <span>按芝麻分范围：</span><input
						type="text"> <input type="button" value="搜索" class="mt_10">
				</div>
			</div>
		</form>
		<!-- <div class="box clearfloat"> -->
		<div role="grid" class="mt_20">
			<div class="table">
				<table class="tbl">
					<tbody>
						<tr>
							<td class="t-head">序号</td>
							<td class="t-head">授权芝麻信用认证用户名</td>
							<td class="t-head">最近发起认证时间</td>
							<td class="t-head">发起认证次数（最多5次）</td>
							<td class="t-head">授权姓名</td>
							<td class="t-head">授权身份证号</td>
							<td class="t-head">授权状态</td>
							<td class="t-head">认证状态</td>
							<td class="t-head">芝麻分</td>
							<td class="t-head">操作</td>
						</tr>
					<tbody>
					<tbody class="t-body tc">
						<c:forEach items="${sesame }" var="sesame" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${sesame.items.createUser_}</td>
								<td>${sesame.items.createDate_}</td>
								<td>${sesame.items.count_}</td>
								<td>${sesame.items.name_}</td>
								<td>${sesame.items.idCard_}</td>
								<td>${sesame.items.sqStatus_}</td>
								<td>${sesame.items.rzStatus_}</td>
								<td>${sesame.items.sesameFen_}</td>
								<td><span class="btn_style">初始化认证次数</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$("#confirm").click(function() {
			var credit = $("#credit").val();
			var credit1 = $("#credit1").val();
			var credit2 = $("#credit2").val();
			var credit3 = $("#credit3").val();
			var credit4 = $("#credit4").val();

			if (window.confirm('友情提示：你确定更改征信和押金的配置吗？\n\n更改后用户下单的押金会实时更改！！！')) {
				$.ajax({
					url : 'FrmCreditManageMent.upCredit',
					dataType : 'json',
					type : 'post',
					data : {
						"credit" : credit,
						"credit1" : credit1,
						"credit2" : credit2,
						"credit3" : credit3,
						"credit4" : credit4
					},
					cache : false,
					success : function(data) {
						if (data == true) {
							alert("征信和押金的配置修改成功！\n\n前台用户下单实时更新此配置！")
						} else {
							alert("更新配置失败！")
						}
					}
				});
			} else {
				return false;
			}
		});
	</script>
</body>
</html>
