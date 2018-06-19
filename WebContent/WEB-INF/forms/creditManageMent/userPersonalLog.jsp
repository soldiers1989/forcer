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
			<span class="min-col f16">单独配置征信列表</span>
		</div>
		<div class="mt_20 ml_20">
			<input type="text" name="code_" id="code_" style="margin-bottom:0px">
			<input type="button" onclick="add()" value="为该用户新增个人征信" class="btn_style">
		</div>
		 <form action="FrmUserPersonalCredit" method="post" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<span>按征信对象：</span><input type="text" name="name_" value="${name_ }"> 
					<span>按征信时间：</span><input type="text" name="date_" value="${date_ }"> 
					<span>按征信方法：</span><input type="text" name="fangfa_" value="${fangfa_ }">
					<span>按启用实效状态：</span>
						<select name="statu_">
							<option value="1">启用</option>
							<option value="0">失效</option>
						</select>
				</div>
				
            <div class="fr rightSide">
                <input type="submit" value="查询" id="sub">
                <a href="FrmUserPersonalCredit.excel?service=SvrGetUserPersonalCredit&amp;exportKey=SvrGetUserPersonalCredit&amp;templateId=SvrGetUserPersonalCredit"><input type="button" value="查询结果导出"></a>
            </div>
			</div>
		</form>
		<div role="grid" class="mt_20">
			<div class="table">
				<table class="tbl">
					<tbody>
						<tr>
	                        <th class="t-head tc">序号</th>
	                        <th class="t-head tc">征信对象</th>
	                        <th class="t-head tc">个人征信来源</th>
	                        <th class="t-head tc">产生征信原因</th>
	                        <th class="t-head tc">产生征信节点</th>
	                        <th class="t-head tc">产生征信责任人</th>
	                        <th class="t-head tc">征信时间</th>
	                        <th class="t-head tc">征信方法</th>
	                        <th class="t-head tc">征信调整数据</th>
	                        <th class="t-head tc">征信关联单据详情</th>
	                        <th class="t-head tc">状态</th>
	                        <th class="t-head tc">操作</th>
						</tr>
					<tbody>
					<tbody class="t-body tc">
						<c:forEach items="${personal }" var="value" varStatus="status">
							<tr>
	                            <td>${ status.index + 1}</td>
	                            <td>${value.items.userCode_}</td>
	                            <td>${value.items.source_}</td>
	                            <td>${value.items.yuanying_}</td>
	                            <td>${value.items.node_}</td>
	                            <td>${value.items.people_}</td>
	                            <td>${value.items.time_ }</td>
	                            <td>
	                            	<c:if test="${value.items.type_ == '0'}">押金比例浮动</c:if>
	                            	<c:if test="${value.items.type_ == '1'}">是否给予押金 </c:if>
	                            	<c:if test="${value.items.type_ == '2'}">免押金额度调整</c:if>
	                            	<c:if test="${value.items.type_ == '3'}">租赁订单结算方式</c:if>
	                            </td>
	                            <td>${value.items.revision_}</td>
	                            <td>查看修改</td>
	                            <td>${value.items.status_} </td>
	                            <td>
	                            	<a href="#" class="btn_style" onclick="up('${value.items.UID_}','0')">启用</a>
	                            	<a href="#" class="btn_style" onclick="up('${value.items.UID_}','1')">失效</a>
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
			var kefu = $("#kefu").val();
			if (window.confirm('友情提示：你确定启动/禁用吗？\n\n更改后用户下单的押金会实时更改！！！')) {
			    $.ajax({
					url : 'FrmUserPersonalCredit.upCredit',
					dataType : 'json',
					type : 'post',
					data : { 
						"id_" : id_,
						"status_" : status_
					},
					cache : false,
					success : function(data) {
						if(data == true){
							alert("征信和押金的配置修改成功！\n\n前台用户下单实时更新此配置！");
							window.location.href='FrmUserPersonalCredit';
						}else{
							alert("变更客服失败!")
						}
					}
					});
			} else {
				return false;
			}
		}
		function add(){
			var code_ = $("#code_").val();
			if(code_ == ""){
				alert("用户ID/手机号不能为空！")
				return false;
			}
			window.location.href='FrmUserXinyong.addDetails?code_='+ code_;
		}
	</script>
</body>
</html>
