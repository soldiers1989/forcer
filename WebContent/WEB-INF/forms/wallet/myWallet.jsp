<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../../files/common.css">
    <link rel="stylesheet" href="../../css/user.css">
    <title>一启享</title>
    <style>
        ul{
            display: inline;
        }
        .header2{
            background-color: white;
        }
    </style>
</head>

<body>

<!--一启享模块-->
<!-- <div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
</div>
 -->
<!--我的钱包模块-->
<div class="header2">
    <a href="FrmMore.userCenter" class="prev"></a>
    <div class="head_title font18">我的钱包</div>
    <a class="detail" href="FrmMyWallet.transactionDetails">交易明细</a>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>

    <!--余额-->
    <div class="headerBalance">
        <div class="headerBalance_up">
            <div class="moneyPic"><img src="../../img/wallet.png"></div>
            <div class="myBalance">
            	<c:if test="${money.items.overMoney_ != null}">
            		<p class="money_number_a1"><fmt:formatNumber value="${money.items.overMoney_}" pattern=".00"/></p>
            	</c:if>
                <c:if test="${money.items.overMoney_ eq  null}">
                	<fmt:formatNumber value="0" pattern=".00"/>
                </c:if>
                <p class="money_number_a2">钱包余额(元)</p>
            </div>
        </div>
        <div class="frozenAmount">
            <a>冻结金额：
            	<c:if test="${money.items.overMoney_  != null}">
                  	<fmt:formatNumber value="${money.items.overMoney_ }" pattern=".00"/>元
               	</c:if>
                <c:if test="${money.items.overMoney_  eq null}">
                    <fmt:formatNumber value="0" pattern=".00"/>元
                </c:if>
            </a>
        </div>
    </div>

    <!--充值-->
    <a href="FrmMyWallet.weixinCode">
	    <div class="recharge">
	        <div class="recharge_left">
	             <img src="../../img/yajin.png">
	             <span>充值</span>
	        </div>
	        <div class="recharge_right">
	            <img src="../../img/right.png">
	        </div>
	    </div>
    </a>

    <!--提现-->
    <a href="FrmMyWallet.weixinCodeT">
	    <div class="withdraw">
	        <div class="recharge_left">
	            <img src="../../img/withdraw.png">
	            <span>提现</span>
	        </div>
	        <div class="recharge_right">
	            <img src="../../img/right.png">
	        </div>
	    </div>
    </a>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
</body>
</html>