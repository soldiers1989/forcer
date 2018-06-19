<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>充值中心</title>

</head>
<body>
<div class="header2">
    <a href="FrmMyWallet" class="prev"></a>
    <div class="head_title font18">充值中心</div>
</div>
<div class="main_content" id="recharge">
    <div id="mat"></div>
    <div class="recharge_title">充值</div>
    <div class="recharge_content">
        <div class="recharge_hint">
            <div class="mb_10">充值金额</div>
            <div class="specific_money mb_20">
                <span class="money_symbol">￥</span>
                <input placeholder="请输入充值金额" type="number" maxlength="18" name="price" id="price" maxlength="14"><span class="yuan"></span>
            </div>
        </div>
        <div class="Card-buttom">
            <input class="button font15" type="button" value="确认" onclick="finish()">
        </div>
        <input type="hidden" name="openid" id="openid" value="${openid}">
    </div>
</div>
    <!-- <h1>充值</h1>
    <div class="Card-type mt_10 mb_10">
        <div class="item-text">
            <input placeholder="请输入充值金额" type="number" maxlength="18"
                name="price" id="price" maxlength="14" onkeyup='this.value=this.value.replace(/\D/gi,"")'><span class="yuan">元</span>
        </div>
    </div>
    <div class="Card-buttom mt10">
        <input class="button" type="button" value="确认" onclick="finish()">
    </div> -->
<script type="text/javascript">
	$(function(){
		$(".button").css("opacity",".4")
		$("body").bind("input","#price",function(){
			var text=$("#price").val();
			if(text==""||text==null){
				$(".button").css("opacity",".4")
			}else{
				$(".button").css("opacity","1")
			}
		})
	})
    function finish() {
        if ($("#price").val() == "") {
            alert("请输入充值金额");
            return;
        }
        if ($("#price").val() == 0) {
            alert("充值金额应大于0");
            return;
        }
        var money = $("#price").val();
        var openid = $("#openid").val();
        weixintyzf(money, "钱包充值", openid);
        return;
    }
</script>
<script type="text/javascript" src="${cdn}/js/payJs/weixinPay.js"></script>
</body>
</html>