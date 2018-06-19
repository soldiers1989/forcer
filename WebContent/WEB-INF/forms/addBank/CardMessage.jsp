
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
  <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<div class="head_title font18">银行卡信息</div>
	</div>
<div class="main_content">
    <div id="mat"></div>
    <form action="" method="post">
	    <div class="card_mess">
	        <div class="type"><span class="span1">卡类型</span><input type="text" name="bankName" value="中国农业银行储蓄卡" id="bankName"></div>
	        <div class="type"><span class="span1">卡号</span><input type="text" name="BankCard" value="${BanKCard}" id="BanKCard"></div>
	    </div>
	    <div class="agree"><input type="checkbox" id="checkBox" checked="checked"><img src="${cdn }/img/checkbox_choose.png" alt="" class="checkImg"><span>同意</span><a href="FrmViewProtocol.Protocolcontent?type_=6" class="service">《服务协议》</a></div>
	    <input type="hidden" name="cardType" value="储蓄卡" id="cardType">
	    <input type="hidden" name="userName" value="${userName}" id="userName">
	    <!-- <input type="submit" value="下一步"  class="submitCard"/> -->
	    <input type="button" value="下一步"  class="submitCard"/>
    </form>
    <!-- <div class="next next-margin"><span>下一步</span></div> -->

</div>
	<%-- <div class="main_content" id="cash_pledge">
		<div id="mat"></div>
		<form action="FrmAddBank.addBankCarkMessage" method="post">
		<p>卡类型：<input type="text" name="bankName" value="中国农业银行"><input type="text" name="cardType" value="储蓄卡"></p>
		<p>卡号：<input type="text" name="BankCard" value="${BanKCard}"></p>
		<p>用户名：<input type="hidden" name="userName" value="${userName}"></p>
		<p><input type="checkbox" checked="checked">同意《服务协议》</p>
		<input type="submit" value="下一步" />
		</form>
	</div> --%>
</body>
<script type="text/javascript">

$(function(){
   
    $(".agree input[type='checkbox']").change(function() {
      if($(this).is(':checked')){
            $(".checkImg").attr("src","${cdn }/img/checkbox_choose.png")
        }
        else{
            $(".checkImg").attr("src","${cdn }/img/checkbox_unchoose.png")
        }
    });

});
 $("body").on("click",".submitCard",function(){
    	var BanKCard= $("#BanKCard").val();
    	var bankName= $("#bankName").val();
    	var cardType= $("#cardType").val();
    	var userName= "${userName}";
    	var isCheckBox = document.getElementById("checkBox").checked;
    	
    	if(BanKCard == null || BanKCard.length<16){
    		modalNext();
    		return false;
    	}
    	if(bankName == null || bankName.length<0){
    		modalNext();
    		return false;
    	}
    	if(!isCheckBox){
			alert("请先阅读《服务协议》");
			return;
		}
    	//else $(function(BanKCard,bankName,cardType,userName){
			$.ajax({
				url : 'FrmAddBank.addBankCarkMessage',
				dataType : 'json',
				type : 'post',
				async : false,
				data : {
					BanKCard : BanKCard,
					bankName : bankName,
					cardType : cardType,
					userName : userName
				},
				success : function(data) {
					if (data == false) {
						alert("添加失败");
						window.location.href="FrmAddBank";
					} else {
						alert("添加成功");
						window.location.href="FrmAddBank";
					}
				}
			});
		//})
    })
</script>
<script>
 function modalNext(){
     var oDiv=document.createElement("div");
     oDiv.className="mars";
     oDiv.innerHTML=
         "<div id='container'>"+
         "<div class='success_content'>"+
         "<div class='success_hint font16'>该卡暂时不能开通快捷支付，请使用其它卡</div>"+
         "</div>"+
         "<div class='confirm'>确定</div>"+
         "</div>";
     var oStyle=document.createElement("style");
     oStyle.innerHTML=
         ".mars{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
         "#container{"+"width: 80%;background: white;position: absolute;top: 45%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;"+"}"+
         ".success_content{"+"line-height: .4rem;text-align: center;padding: .5rem .77rem;"+"}"+
         ".success_title{"+"color: #1a1a1a;"+"}"+
         ".success_title .donate_id{"+"color: #a0791a;"+"}"+
         ".success_hint{"+"color: #4f4f4f;"+"}"+
         ".confirm{"+" width: 100%;font-size: .315rem;text-align: center;height:.765rem;line-height: .765rem;background: white;border-top:1px solid #ccc;color: #a0791a;cursor:pointer;border-radius: 0 0 3px 3px;-webkit-border-radius: 0 0 3px 3px;"+"}"+
         document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
     document.body.insertBefore(oDiv,document.body.children[0]);

     $("body").on("click",".confirm",function(){
         $(".mars").hide()
     })
 };
</script>
</html>