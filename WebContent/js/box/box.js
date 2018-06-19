function addBox(id_, num_, type_, size_, managerId_) {
	$.ajax({
		async : false,
		type : 'post',
		url : 'FrmMyCabinet.addDeployCabinetBox',
		data : {
			'id_' : id_,
			'num_' : num_,
			'type_' : type_,
			'size_' : size_,
			'managerId_' : managerId_
		},
		dataType : 'json',
		success : function(data) {
			if(data == true){
				alert('添加成功！');
			}else{
				alert('服务器繁忙！')
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("网络异常");
			return;
		}
	});
}
	
	
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
                window.location.href="FrmMyWallet.recharge";
            }
            if (res.err_msg == "get_brand_wcpay_request:cancel") {  
                alert("交易取消");  
            }  
            if (res.err_msg == "get_brand_wcpay_request:fail") {  
                alert("支付失败"); 
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
