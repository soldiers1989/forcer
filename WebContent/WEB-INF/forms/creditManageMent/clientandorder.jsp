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
	$(function(){
	$('#sub').on('click', function() {
	    var startdate=$('#unlockDate_').val();
	  var enddate=$('#endDate_').val();
	  if(startdate != null && startdate!=""){
	  if(startdate>enddate){ 
	    alert("结束时间必须大于开始时间");
	    return false;
	    }
	  }
	    });
	})
</script>
<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
</head>
<body style="background-color: #ffffff;">

	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">征信与订单关联列表</span>
		</div>
		<form action="FrmClientList" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<div>
						<span class="back_hint6">按用户名：</span><input type="text" name="mobile_"> 
						<span>按来自渠道：</span><input type="text" name="channel_"> 
						<span>按归属机构：</span><input type="text" name="jigou_"> 
					</div>
					<div class="mt_10">
						<span class="back_hint6">订单时间范围：</span>
						<input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
	                    <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
	               
						<span class="back_hint8">按当前余额范围：</span>
						<input type="text" name="moneyq_" placeholder="最低金额">
						<input type="text" name="moneyh_" placeholder="最高金额"> 
					</div>
				</div>
				
	            <div class="fr rightSide">
	                <input type="submit" value="查询" id="sub">
	                <a href="FrmExcel?service=SvrGetClientAndOrder&amp;exportKey=SvrGetClientAndOrder&amp;templateId=SvrGetClientAndOrder"><input type="button" value="查询结果导出"></a>
	            </div>
			</div>
		</form>
		<div role="grid" class="mt_20">
			<div class="table">
				<table class="tbl">
					<tbody>
						<tr>
							<td class="t-head">序号</td>
							<td class="t-head">租赁单编号</td>
							<td class="t-head">租赁单用户名</td>
							<td class="t-head">订单时间</td>
							<td class="t-head">订单物品归属机构</td>
							<td class="t-head">来自征信渠道</td>
							<td class="t-head">订单生产时<br/>总免押额度</td>
							<td class="t-head">订单物品原押金</td>
							<td class="t-head">订单实际收取押金</td>
							<td class="t-head">享受免押金额</td>
							<td class="t-head">订单归还是否报异常</td>
							<td class="t-head">订单结算后用户余额</td>
							<td class="t-head">用户当前余额</td>
						</tr>
					<tbody>
					<tbody class="t-body tc">
						<c:forEach items="${sesame }" var="sesame" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${sesame.items.id_}</td>
								<td>${sesame.items.userCode_}</td>
								<td>${sesame.items.createDate_}</td>
								<td>${sesame.items.jigou_}</td>
								<td>${sesame.items.channel_}</td>
								<td>${sesame.items.myMoney_}</td>
								<td>${sesame.items.yuanYj_}</td>
								<td>${sesame.items.shiYj_}</td>
								<td>${sesame.items.jianmianYj_}</td>
								<td>${sesame.items.orderStatus_}</td>
								<td>${sesame.items.userJsMoney_}</td>
								<td>${sesame.items.userMoney_}</td>
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
