/**
 * Created by Administrator on 2016/11/10 0010.
 */
/*
 * 本地存贮
 */
var stronge = window.localStorage;
var _tab = {
    _win:function (){
    	/*var browserWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
	    var win_h = $(window).height();
	    var win_w = $(window).width();
	    $("#menu-left").height(win_h-70);
	    $("#mid-box").height(win_h-70);
	    $(".login-ground").height(win_h-70);
	    if(browserWidth>=1360){
	    	$("#left-btn").hide()
	        if($("#mid-box").hasClass("on")){
	            $("#mid-box").css({
	                "margin-left":(win_w-1000)/2,
	            })
	        }else{
	            $("#menu-left").css({
	                "margin-left":(win_w-1360)/2,
	            })
	            $("#mid-box").css({
	                "margin-left":0,
	            })
	        }
	    }else{
	    	$("#left-btn").show();
	    	if($("#mid-box").hasClass("on")){
	            $("#mid-box").css({
	                "margin-left":"0",
	            })
	        	$("#mid-box").width(win_w);
	        }else{
	        	$("#menu-left").css({
	        		"position":"fixed",
	                "margin-left":"0",
	            })
	            $("#mid-box").css({
	                "margin-left":"310px",
	            })
	        	$("#mid-box").width(1000);
	        }
	    }*/
        
    },
    _c:function () {
        $("#mid-box").addClass("on");
        $("#menu-left").css({
            "width":"0"
        })
        var html = "<span id='show-menu'>&lt</span>"
        $("body").append(html)
        _tab._win();
    },
    _d:function () {
        $("#mid-box").removeClass("on");
        $(this).hide();
        $("#menu-left").css({
            "width":"300px"
        })
        _tab._win();
    },/*
    _e:function(){
    	var _this = $(this);
		$("#mid-box").find("div.tab_name a").removeClass("curr");
		_this.addClass("curr");
		stronge.setItem("taBox",encodeURI(_this.parent().html()));
    }*/
};
$(function(){
    $(window).resize(_tab._win);
    _tab._win();
    /*中间toolbar*/
    /*$("#mid-box").find("div.tab_name").on("click","a",_tab._e)*/
    /*点击展开左侧菜单*/
    $("#left-btn").on("click",_tab._c)
    /*点击隐藏左侧菜单*/
    $(document).on("click","#show-menu",_tab._d)
    $("#men-bx").on("click","span.item",function () {
    	var _this = $(this);
    	$("#men-bx").find("span.item").removeClass("curr");
    	_this.addClass("curr");
    	_this.parent().siblings().children("ul").stop().slideUp(200);
    	_this.next().slideToggle(200);
	    if(_this.next().has("li").length==0){
	    	$("#men-bx").find("ul").hide();
	    	$("#men-bx") .find("a.two").removeClass("curr");
	    	stronge.setItem("menu-bx",encodeURI($("#men-bx").html()));
	    	setTimeout(function(){
	    		window.location.href = _this.attr("data-url");
	    	},500)
	    	
	    }
    });
    $("#men-bx").on("click","a.two",function () {
        var _this = $(this);
        $("#men-bx").find("a.two").removeClass("curr");
        _this.addClass("curr")
        stronge.setItem("menu-bx",encodeURI($("#men-bx").html()));
    });
    //判断浏览器是否支持window.localStorage
    if(stronge && stronge.getItem("menu-bx")){
        var menbx = eval("decodeURI(stronge.getItem('menu-bx'))");
        $("#men-bx").empty().html(menbx);
    }/*
    if(stronge && stronge.getItem("taBox")){
    	var menbx = eval("decodeURI(stronge.getItem('taBox'))");
    	$("#mid-box").find("div.tab_name").empty().html(menbx);
    }*/
    !stronge && alert("抱歉!当前浏览器不支持本地存储,请升级或更换浏览器,获得更好的体验.")

})
/*全选*/
function fnChkeckByName(name,el){
	$(':checkbox[name='+name+']').prop('checked',$(el).is(":checked"))
}
function fnCheckLinkBtn(checkName,url){
	var params="";
	var arrs = $(':checkbox[name='+checkName+']:checked');
	$(arrs).each(function(){
		params+="&"+checkName+"="+$(this).attr("data-value");
	});
	if(arrs.length==0){
		alert('请先勾选');
		return;	
	}
	window.location.href=url+"?1=1"+params
}
function fnClearToolBar(toolbarId){
	$("#"+toolbarId+" :input[type='text']").val("");//clear input text
	$("#"+toolbarId+" select option:first").get(0).selected=true;//select selected first option
}
function fnSubmit(url,formId){
	$("#"+formId).attr("action",url).submit();
}
function fnRemoveRow(url,id){
	if(confirm("是否确认删除?")){
		window.location.href=url+"?UID_="+id;
	}
}
/*手机号验证*/
function checkMobile(sMobile){ 
	var flag=false;
    if((/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(sMobile))){ 
        flag=true;
    } 
    return flag;
} 
//退出登录
function Loginexit(){
	stronge.removeItem("menu-bx");
	setTimeout(function(){
		window.location.href="FrmAdminLogin.exit"
	},500)
	return true;
}

/* 输入的时候，验证健康卡号空格 */
function inputClick(BankNo) {
/*
	var reg = /^[0-9, ]*$/;
	var val = $(e).val();
	var leg = val.length;
	var k = event.keyCode;
	
	if(!reg.test(val)) {
		$(e).val(val.substring(0, leg - 1));
	} else {
		if(k != 8) {
			if(leg == 6 || leg == 11 || leg == 16) {
				$(e).val(val + " ");
			}
		}
	}*/
	if (BankNo.value == "") return;
    var account = new String (BankNo.value);
    account = account.substring(0,20); /*帐号的总数, 包括空格在内 */
    if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null)
    {
        /* 对照格式 */
        if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" +
                        ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null)
        {
            var accountNumeric = accountChar = "", i;
            for (i=0;i<account.length;i++)
            {
                accountChar = account.substr (i,1);
                if (!isNaN (accountChar) && (accountChar != " ")) accountNumeric = accountNumeric + accountChar;
            }
            account = "";
            for (i=0;i<accountNumeric.length;i++)
            { /* 可将以下空格改为-,效果也不错 */
                if (i == 6) account = account + " "; /* 帐号第四位数后加空格 */
                if (i == 10) account = account + " "; /* 帐号第八位数后加空格 */
                if (i == 14) account = account + " ";/* 帐号第十二位后数后加空格 */
                account = account + accountNumeric.substr (i,1)
            }
        }
    }
    else
    {
        account = " " + account.substring (1,7) + " " + account.substring (8,12) + " " + account.substring (13,17) + "-" + account.substring(18,21);
    }
    if (account != BankNo.value) BankNo.value = account;
    
//    动态修改表格的样式
    
    
}
