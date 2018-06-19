var prepay_id;
var paySign;
var appId;
var timeStamp;
var nonceStr;
var packageStr;
var signType;
var orderNo;

function weixintyzf(amount, body, openid) {
	$.ajax({
		async : false,
		type : 'post',
		url : 'FrmWeixinPay.tyzf',
		data : {
			'body' : body,
			'amount' : amount,
			'openid' : openid
		},
		dataType : 'json',
		success : function(data) {
			if (data.result == 'error') {
				alert(data.msg);
				return;
			}
			prepay_id = data.prepay_id;
			paySign = data.paySign;
			appId = data.appId;
			timeStamp = data.timeStamp;
			nonceStr = data.nonceStr;
			packageStr = data.packageStr;
			signType = data.signType;
			orderNo = data.orderNo;

			onBridgeReady();//调用微信支付接口
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("网络异常");
			return;
		}
	});
	
	
	function callpay(){
	    if (typeof WeixinJSBridge == "undefined"){
	        if( document.addEventListener ){
	            document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	        }else if (document.attachEvent){
	            document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
	            document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	        }
	    }else{
	        onBridgeReady();
	    }
	}
}


function onBridgeReady(){
    WeixinJSBridge.invoke(
        'getBrandWCPayRequest', {
           "appId"     : appId,     //公众号名称，由商户传入
           "timeStamp" : timeStamp, //时间戳，自1970年以来的秒数
           "nonceStr"  : nonceStr , //随机串
           "package"   : packageStr,
           "signType"  : 'MD5',  //微信签名方式：
           "paySign"   : paySign    //微信签名
        },
        function(res){
            if(res.err_msg == "get_brand_wcpay_request:ok" ) {
                alert("交易成功");
                window.location.href="FrmMyWallet";
                return;
            }
            if (res.err_msg == "get_brand_wcpay_request:cancel") {  
                alert("交易取消");  
                window.location.href="FrmMyWallet";
                return;
            }  
            if (res.err_msg == "get_brand_wcpay_request:fail") {  
                alert("支付失败"); 
                window.location.href="FrmMyWallet";
                return;
            }  
        }
    );
}


function ReturnForApp(remark){
	if (remark.indexOf("成功")>=0) {
		window.location.href='FrmActionResult?msg=订单完成!&url=FrmIndex&result=true';
	}else if (remark.indexOf("失败")>=0) {
		window.location.href='FrmActionResult?msg=订单未完成!&url=FrmIndex';
	}else{
		winBox(remark);
	}
}
