<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
<link rel="stylesheet" href="../../files/common.css">
<link rel="stylesheet" href="../../css/user.css">
<%@include file="../jspf/head1.jspf"%>
<title>芝麻信用</title>
<style>
.content{
	width:100%;
	height:100%;
	background-color:#fff;
}
	.zhima{
		width:100%;
		height:4rem;
		text-align:center;
		position:relative;
	}
	.zhima img{
		width:1.5rem;
		padding:.85rem 0;
		
	}
	.content .mess{
		width:80%;
		margin-left:10%;
		
	}
	.content .mess div{
		height:1rem;
		text-align:center;
		
	}
	.content .mess div span{
	margin-top:.4rem;
	}
		.content .mess div input{
			border:none;
			border-bottom:1px solid #000;
			width:70%;
			height:40%;
		}
		.confirm_btn{
		margin-top:.3rem;
		}
		.confirm_btn input{
			width:100% !important;
			height: 0.717rem !important;
			border:none;
			background-color: #88213d;
			color:#fff;
			border-radius: 0.358rem;
			
		}
		.zhima .text1{
			position:absolute;
			left:40%;
			bottom:.85rem;
		}
		.zhima .text{
			position:absolute;
			left:41%;
			bottom:0.6rem;
		}
</style>
</head>
<body>
	<!--我的钱包模块-->
	<div class="header2">
		<a href="javascript:history.go(-1);" class="prev"></a>
		<div class="head_title font18">减免押金</div>
	</div>
	<!--内容模块-->
		
		<!-- <div class="headerBalance"> -->
		<div class="content">
		<div id="mat"></div>
			<div class="zhima">
				<img alt="" src="${cdn }/img/zhima.png">
				<div class="text1 font20">芝麻信用</div>
				<!-- <div class="text2 font20"><span>zhima</span><span class="font17"> credit</span></div> -->
				 <div class="text font14">zhima credit</div> 
			</div>
			<div class="mess">
				<div><span class="font15">真实姓名：</span><input type="text" name="name_" id="name_"> </div>
				<div><span class="font15">身份证号：</span><input type="text" name="card_" id="card_"> </div>
				
			<div>
			<div class="confirm_btn"><input type="button" id="confirm" value="确认授权" ></div>
		</div>
		</div>
		
	</div>
	<script src="../../files/jquery-1.11.3.min.js"></script>
	<script type="text/javascript">
		//验证中文名称
		function isChinaName(name) {
			var pattern = /^[\u4E00-\u9FA5]{1,6}$/;
			return pattern.test(name);
		}

		// 验证手机号
		function isPhoneNo(phone) {
			var pattern = /^1[34578]\d{9}$/;
			return pattern.test(phone);
		}

		// 验证身份证 
		function isCardNo(card) {
			var pattern = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
			return pattern.test(card);
		}

		$("#confirm").click(function() {
			var name_ = $("#name_").val();
			var card_ = $("#card_").val();
			var str = '';

			// 判断名称
			if ($.trim(name_).length == 0) {
				str += '名称没有输入\n';
			} else {
				if (isChinaName($.trim(name_)) == false) {
					str += '名称不合法\n';
				}
			}

			// 验证身份证
			if ($.trim(card_).length == 0) {
				str += '身份证号码没有输入\n';
			} else {
				if (isCardNo($.trim(card_)) == false) {
					str += '身份证号不正确；\n';
				}
			}

			// 如果没有错误则提交
			if (str != '') {
				alert(str);
				return false;
			} else {
				alert('验证成功！');
				$.ajax({
					url : 'FrmSesameCredit.zhimaAuthInfoAuthorize',
					dataType : 'json',
					type : 'post',
					data : { 
						"name_" : name_,
						"card_" : card_
				    },
					cache : false,
					success : function(data) {
						alert("提交成功！");
						window.location.href = data;
					}
				});
			}
		});
	</script>
</body>
</html>