<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cldn}/js/jquery-1.9.1.min.js"></script>
<title>修改积分</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">修改积分</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    <!-- <a href="FrmJifenSign">返回</a> -->
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	<div class="easyui-panel tc mt_20">
		<form action="FrmJifenSign.jiFenUpdate" method="post" onsubmit="return check();">
		<input type="hidden" value="up" name="up">
		<input type="hidden" value="${jifen.items.UID_}" name="UID_">
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">积分等级：</label>
			<input type="text" name="grade_" value="${jifen.items.grade_ }" id="grade_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">积分值：</label>
			<input type="text" name="num_" value="${jifen.items.num_ }" id="integral_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">积分说明：</label>
			<input type="text" name="remark_" value="${jifen.items.remark_ }" id="remark_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<input type="submit" value="提交" style="width:100px;color:#fff;margin-left:206px !important;">
		</div>
	</form>
	</div>
</div>

	<%-- <form action="FrmJifenSign.jiFenUpdate" method="post" onsubmit="return check();">
		<input type="hidden" value="up" name="up">
		<input type="hidden" value="${jifen.items.UID_}" name="UID_">
		<p><span>积分等级:</span><input type="text" name="grade_" value="${jifen.items.grade_ }" id="grade_"></p>
		<p><span>积分值:</span><input type="text" name="num_" value="${jifen.items.num_ }" id="integral_"></p>
		<p><span>积分说明:</span><input type="text" name="remark_" value="${jifen.items.remark_ }" id="remark_"></p>
		<p><input type="submit" value="提交"></p>
		<p><a href="FrmJifenSign">返回</a></p>
	</form> --%>
</body>
<script type="text/javascript">
	function check(){
		var grade = $("#grade_").val();
		var integral = $("#integral_").val();
		var remark_ = $("#remark_").val();
		var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
		var regNum = /^[0-9]*$/;
		if(grade == "" || integral == "" || remark_ == ""){
			alert("请确认是否填写完整!");
			return false;
		}if(regRule.test(grade)){
			alert("暂不支持表情!");
			return false;
		}if(regRule.test(remark_)){
			alert("暂不支持表情!");
			return false;
		}}if(integral.length>10){
			alert("长度过长!");
			return false;
		}if(grade.length>15){
			alert("长度过长!");
			return false;
		}
	}
</script>
</html>