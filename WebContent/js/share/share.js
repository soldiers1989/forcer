    //点击分享商品详情
    var appId= "";
    var timestamp= "";
    var nonceStr= "";
    var signature= "";
    $("#share").on('click',function(){
        /*$(this).addClass("footActive");*/
        $.ajax({
            url : "FrmMap.getWX",
            dataType : 'json',
            type : 'post',
            cache : false,
            async : false,
            data : {
                "fullPath" : location.href.split('#')[0],
            },
            success : function(data) {
                if(data.appId!=''){
                    appId=data.appId;
                    timestamp=data.timestamp;
                    nonceStr=data.nonceStr;
                    signature=data.signature;
                    shareAppMessage();
                    $("#chooseType").css('display','block');
                }else{
                    $("#chooseType").css('display','none');
                    alert("分享失败");
                }
            },
            error : function() {
                alert("运行错误，请稍后再试");
            }
        });
    })
    $(".cancel").on('click',function(){
        $("#chooseType").css('display','none');
    })
//分享给好友
function shareAppMessage(){
    wx.config({
        debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId : appId, // 必填，企业号的唯一标识，此处填写企业号corpid
        timestamp : timestamp, // 必填，生成签名的时间戳
        nonceStr : nonceStr, // 必填，生成签名的随机串
        signature : signature,// 必填，签名，见附录1
        jsApiList : ['onMenuShareAppMessage','onMenuShareTimeline']// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });
    wx.ready(function() {
        var desc = $("#proName_").val();
        var imgUrl = $("#twoImgUrl_").val();
        wx.onMenuShareAppMessage({
            title: '一启享', // 分享标题
            desc: desc, // 分享描述
            link: location.href.split('#')[0], // 分享链接
            imgUrl: imgUrl, // 分享图标
            type: 'link', // 分享类型,music、video或link，不填默认为link
            dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
            success: function () {
                alert("分享成功");
                $("#chooseType").css('display','none');
            },
            cancel: function () {
                $("#chooseType").css('display','none');
            },
            fail: function (res) {  
                alert("分享失败，请重新尝试");  
            }
        });
        //分享到朋友圈
        wx.onMenuShareTimeline({
            title: '一启享', // 分享标题
            link: location.href.split('#')[0], // 分享链接
            imgUrl: imgUrl, // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
                alert("分享成功");
                $("#chooseType").css('display','none');
            },
            cancel: function () {
                $("#chooseType").css('display','none');
            }
        });
    });
    wx.error(function(res) {
        alert("出错了：" + res.errMsg);//这个地方的好处就是wx.config配置错误，会弹出窗口哪里错误，然后根据微信文档查询即可。
    });
}
