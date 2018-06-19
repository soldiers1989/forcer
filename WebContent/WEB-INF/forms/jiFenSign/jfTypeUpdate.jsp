<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cldn}/js/jquery-1.9.1.min.js"></script>
<title>修改积分类型</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">修改积分类型</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel tc mt_20">
	<form action="FrmJiFenType.typeUpdate" method="post"  onsubmit="return check();">
		<input type="hidden" value="${detail.items.UID_ }" name="UID_" >
		<input type="hidden" value="up" name="up">
		<div class="group-box" name="null" id="component1" visible="false">
			<label>积分类型：</label>
			<!-- <select name="type_">
			<option value="0">邀请积分</option>
			<option value="1">签到积分</option>
			</select>
			 -->
			<c:if test="${detail.items.type_== 1}">
				邀请
			</c:if> 
			<c:if test="${detail.items.type_== 0}">
				签到
			</c:if>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>积分值：</label>
			<input type="text" value="${detail.items.integral_ }" name="integral_" id="integral_">
		</div>
		<div class="group-box" id="component4">
		<input type="submit" value="提交">
	</div>
	</form>	
	</div>
</div> 

	
<%-- <form action="FrmJiFenType.typeUpdate" method="post"  onsubmit="return check();">
	<p><input type="hidden" value="${detail.items.UID_ }" name="UID_" ></p>
	<p><input type="hidden" value="up" name="up"></p>
	<p>积分类型：
		<!-- <select name="type_">
			<option value="0">邀请积分</option>
			<option value="1">签到积分</option>
		</select>
		 -->
		<c:if test="${detail.items.type_== 1}">
			邀请
		</c:if> 
		<c:if test="${detail.items.type_== 0}">
			签到
		</c:if>
		
	</p>
	<p>积分值：<input type="text" value="${detail.items.integral_ }" name="integral_" id="integral_"></p>
	<p><input type="submit" value="提交"></p>
	<p><a href="FrmJiFenType">返回</a></p>
</form> --%>
</body>
<script type="text/javascript">
  function check(){
	  var integral = $("#integral_").val();
	  var regNum = /^[0-9]*$/;
	  if(integral == ""){
		  alert("积分值不可为空");
		  return false;
	  }if(!regNum.test(integral)){
		  alert("积分值输入格式有误，只可为数字");
		  return false;
	  }if(integral.length>15){
		  alert("积分值数值过长");
		  return false;
	  }
  }
</script>
</html>