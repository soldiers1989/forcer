<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<div class="bartop min-bg" id="header">
	<div class="wrap">
		<h1 class="title">百姓健康信息服务平台</h1>
		<div class="head-men">
			<a href="javascript:;"><i class="icon"><img
					src="${cdn }/admin/images/icon/icon_head.png" width="14"
					height="14"> </i></a> <a href="javascript:;" class="name">${jspFile.handle.handle.params.UserCode }</a>|
			<a href="javascript:Loginexit();">退出</a>
		</div>
	</div>
</div>
<div class="forget-box">
	<form id="formid" action="FrmEditPhonePaswd.toFrmEditPhone2">
		<h3 class="min-col f16 mb_10">修改手机号</h3>
		<div class="mid-keytext" id="test" style="">
			<div class="mb_20 mt_20">
				<span class="lf-box">原始手机号:</span><input id="oldPhone" name="oldPhone" type="text" class="text" placeholder="请输入您的原始手机号码" />
			</div>
			<div class="mb_20 mt_20">
				 <span class="lf-box">手机验证码</span>
                <input name="validateCode" id="validateCode"  type="text" class="text wt-168" placeholder="输入验证码">
                <input  class="min-col get-scroe" onclick="getValidate()" type="button" id="btn" value="获得验证码" />
			</div>
			<div class="sumb mt_20 pt_20 btn">
				<input type="button" onclick = "checkUser()" class="for-btns" value="确定" style="display:inline-block;width:120px">
				<input type="button" onclick="javascript:window.history.go(-1);" class="for-btns" value="取消" style="display:inline-block;width:120px">
			</div>
		</div>
	</form>
</div>
<script src="${cdn}/admin/js/alertMsg.js"></script>
<script>
function checkUser(){
	var oldPhone = $("#oldPhone").val();
	var validateCode = $("#validateCode").val();
	var str = /^1\d{10}$/;
	if(oldPhone == ""){
		alertMsg("请输入原始手机号!");
		return false;
	}else{
		if(!str.test(oldPhone)) {
			alertMsg("原始手机号输入有误!");
			return false;
		}
	}
	if(validateCode==""){
		alertMsg("请输入验证码!"); 
		return false;
	}
	$.ajax({
		url: 'FrmEditPhonePaswd.checkOldPhone' ,
		dataType: 'json',
		type: 'post',
		cache: false,
		data: {"oldPhone":oldPhone },
		success: function (data) {
			if(data.status == "原始号码错误"){
				alertMsg(data.status);
			}else{
				$.ajax({
					url: 'FrmEditPhonePaswd.checkValidate',
					dataType: 'json',			
					type: 'post',
					cache: false,
					data: {"phone":oldPhone,"validateCode":validateCode},
					success: function (data) {
						if(data.status =="验证码错误"){
							alertMsg(data.status);
						}else{
							document.getElementById("formid").submit();
						}
			        },
					error: function() {
						alertMsg("网络异常");
					}
				});
			}
		}
	});
	
}

function getValidate(){
	var _this = $(this);
	var phonetest = /^1\d{10}$/;
	var oldPhone = $("#oldPhone").val();
	if(oldPhone == "") {
		alertMsg("请输入原始手机号码！")
		return false;
	}else{
		if(!phonetest.test(oldPhone)){
			alertMsg("原始手机号输入有错误！");
			return false;
		}
	}
	$.ajax({
		url: 'FrmEditPhonePaswd.checkOldPhone' ,
		dataType: 'json',
		type: 'post',
		cache: false,
		data: {"oldPhone":oldPhone },
		success: function (data) {
			if(data.status == "原始号码错误"){
				alertMsg(data.status);
			}else{
				$.ajax({
					url: 'FrmEditPhonePaswd.getValidate',
					dataType: 'json',
					type: 'post',
					cache: false,
					data: {"userName":oldPhone},
					success: function (data) {
						getPassCode(document.getElementById("btn"))
			        },			
					error: function() {
						alertMsg("网络异常");
					}
				});
			}
		}
	});
}
//倒计时
var wait=60; 
function getPassCode(o) {  
       if (wait == 0) {  
           o.removeAttribute("disabled");      
           o.style.cursor = "pointer";
           o.value="获得验证码";  
           wait = 60;  
       } else {  
           o.setAttribute("disabled", true);
           o.style.cursor = "no-drop";
           o.value="重新发送(" + wait + ")";  
           wait--;  
           setTimeout(function() {  
        	   getPassCode(o)  
           },  
           1000)  
       }  
}
</script>
</body>
</html>