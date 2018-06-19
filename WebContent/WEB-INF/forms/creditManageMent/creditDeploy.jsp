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
			<span class="min-col f16">征信数据和押金关系调整页</span>
		</div>
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<!-- <div class="fl leftSide">
				<a href="javascript:window.history.go(-1);" class="btn_style">返回</a>
			</div>
			<div class="fr rightSide"></div> -->
		</div>
		<div class="zm_content">
			<ul class="zmxyScore ">
				<li class="flexLayout">
					<div class="ts">当前享受减免押金芝麻信用分为</div>
					<div class="currentScore"><span>${credit}</span>分</div>
					<div class="changeScore">变更为<input type="number" id="credit">分</div>
				</li>
				<li class="flexLayout">
					<div class="ts">当前芝麻信用分可抵扣租金额最高为</div>
					<div class="currentScore"><span>${credit1}</span>元</div>
					<div class="changeScore">变更为<input type="number" id="credit1">元</div>
				</li>
				<li class="flexLayout">
					<div class="ts">当前活体映像认证成功可抵扣租金额最高为</div>
					<div class="currentScore"><span>${credit2}</span>元</div>
					<div class="changeScore">变更为<input type="number" id="credit2">元</div>
				</li>
				<li class="flexLayout">
					<div class="ts">当前绑定银行卡认证成功可抵扣租金额最高为</div>
					<div class="currentScore"><span>${credit3}</span>元</div>
					<div class="changeScore">变更为<input type="number" id="credit3">元</div>
				</li>
				<li class="flexLayout">
					<div class="ts">当前认证客户列表有效用户可抵扣在租金额最高为</div>
					<div class="currentScore">${credit4}</div>
					<div class="changeScore">变更为<input type="number"
					id="credit4">元</div>
				</li>
			</ul>
			<input type="button" id="confirm" value="提交当前页面" class="btn_style">
		</div>
	</div>
	<script type="text/javascript">
		$("#confirm").click(function() {
			var credit = $("#credit").val();
			var credit1 = $("#credit1").val();
			var credit2 = $("#credit2").val();
			var credit3 = $("#credit3").val();
			var credit4 = $("#credit4").val();
			
			if(window.confirm('友情提示：你确定更改征信和押金的配置吗？\n\n更改后用户下单的押金会实时更改！！！')){
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
						if(data == true){
							alert("征信和押金的配置修改成功！\n\n前台用户下单实时更新此配置！")
						}else{
							alert("更新配置失败！")
						}
					}
				});
             }else{
                return false;
            }
		});
	</script>
</body>
</html>
