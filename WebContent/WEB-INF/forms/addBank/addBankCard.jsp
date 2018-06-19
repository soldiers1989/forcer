
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享</title>
<style>
	.cash_pledge_list li{
		width:100%;
		height: 0.819rem;
		border-bottom: 1px solid #e6e6e6;
		margin:auto;
		line-height:0.819rem;
	}
	.cash_pledge_list li a{
		width:100%;
		height: 100%;
		line-height:0.819rem;
		border-bottom: none;
	}

</style>
</head>
<body>
	<div class="header2">
		<a href="javascript:history.go(-1);" class="prev"></a>
		<div class="head_title font18">添加银行卡</div>
	</div>
	<div class="main_content" id="cash_pledge">
    <div id="mat"></div>
    <form action="" method="post">
	    <div class="binding_tishi"><span>请绑定持卡人本人的银行卡</span></div>
	    <div class="card_mess" style="margin-top:0">
	        <div class="type"><span class="span1">持卡人</span><input type="text"  id="userName" name="userName" placeholder="请填写您的姓名"></div>
	        <div class="type"><span class="span1">卡号</span><input type="text" id="BankCard" name="BankCard" placeholder="请输入您的卡号"><img src="${cdn }/img/right.png" alt="" class="right"></div>
	    </div>
	    <div class="binding_tishi font205"><span> 一启享智能加密，保障您的用卡安全，</span><span class="fc">客服电话：0755-23359516</span></div>
		<input type="button" value="下一步" class="submitCard" onclick="gotoAddBankCard()"/>
	    <!-- <div class="next next-margin"><a href="添加银行卡-下一步.html">下一步</a></div> -->
	</form>
	</div>
	<!-- <div class="main_content" id="cash_pledge">
		<div id="mat"></div>
		<form action="FrmAddBank.addBank" method="post">
		<p>请绑定持卡人本人的银行卡</p>
		<p>持卡人：<input type="text" id="userName" name="userName"></p>
		<p>卡号：<input type="text" id="BankCard" name="BankCard"></p>
		<input type="submit" value="下一步" />
		</form>
	</div> -->
</body>
<script type="text/javascript">
	function gotoAddBankCard(){
		var userName= $("#userName").val();
		var BankCard= $("#BankCard").val();
		if(userName =='' || userName.length>4 ){
			alert("请输入正确的用户名");
			$("#userName").val("");
			return false;
		}
		if(BankCard == '' || BankCard.length<16){
			alert("请输入正确的银行卡号");	
			$("#BankCard").val("");
			return false;
		}
		window.location.href="FrmAddBank.addBank?BankCard="+BankCard+"&userName="+userName;
	}
</script>
</html>