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
			<span class="min-col f16">活体映像认证列表</span>
		</div>
		<form action="FrmClientList" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<span>按用户手机号：</span><input type="text" name="mobile_"> 
					<span>按失效时间：</span><input type="text" name="sxDate_"> 
					<span>按订单时间：</span><input type="text" name="date_"> 
					<span>按状态查询：</span>
						<select name="status_">
							<option value="正常">正常</option>
							<option value="失效">失效</option>
						</select>
					
				</div>
				
	            <div class="fr rightSide">
	                <input type="submit" value="查询" id="sub">
	                <a href="FrmExcel?service=SvrGetLivingBody&amp;exportKey=SvrGetLivingBody&amp;templateId=SvrGetLivingBody"><input type="button" value="查询结果导出"></a>
	            </div>
			</div>
		</form>
		<div role="grid" class="mt_20">
			<div class="table">
				<table class="tbl">
					<tbody>
						<tr>
							<td class="t-head">序号</td>
							<td class="t-head">订单编号<br/>(主键)</td>
							<td class="t-head">发起用户名</td>
							<td class="t-head">订单时间</td>
							<td class="t-head">失效时间</td>
							<td class="t-head">柜子地址</td>
							<td class="t-head">柜子编号</td>
							<td class="t-head">订单状态</td>
							<td class="t-head">订单映像图片</td>
							<td class="t-head">操作</td>
						</tr>
					<tbody>
					<tbody class="t-body tc">
						<c:forEach items="${sesame }" var="sesame" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${sesame.items.id_}</td>
								<td>${sesame.items.userCode_}</td>
								<td>${sesame.items.createDate_}</td>
								<td>${sesame.items.sxDate_}</td>
								<td>${sesame.items.cabAdr_}</td>
								<td>${sesame.items.cabNo_}</td>
								<td>${sesame.items.status_}</td>
								<td>${sesame.items.imgUrl_}</td>
								<td>
									<span class="btn_style" onclick="ups('${sesame.items.UID_}')">延长失效时间</span>
									<span class="btn_style" onclick="up('${sesame.items.UID_}', '${sesame.items.status_}')">订单失效</span>
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
					url : 'FrmLivingBodyList.up',
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
							window.location.href='FrmLivingBodyList';
						}else{
							alert("变更状态失败!")
						}
					}
					});
			} else {
				return false;
			}
		}
		
		function ups(id_){
			if (window.confirm('友情提示：你确定延长时间吗？\n\n请确认！！！')) {
			    $.ajax({
					url : 'FrmLivingBodyList.ups',
					dataType : 'json',
					type : 'post',
					data : { 
						"id_" : id_
					},
					cache : false,
					success : function(data) {
						if(data == true){
							alert("延长时间成功！\n\n前台用户下单实时更新此配置！");
							window.location.href='FrmLivingBodyList';
						}else{
							alert("延长时间失败!")
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
