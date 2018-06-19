<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
   <%--  <%@include file="../jspf/head1.jspf"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>

<title>一启享</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加等级积分</span>
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
		<form action="FrmJifenSign.levelInsert" method="post">
		<input type="hidden" value="in" name="in">
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">等级：</label>
			<input type="text" name="grade_" placeholder="请输入积分等级">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">积分值：</label>
			<input type="text" name="num_" placeholder="请输入积分值">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">等级说明：</label>
			<input type="text" name="remark_" placeholder="请输入等级说明">
		</div>
		<div class="group-box" id="component4" style="margin-left:30%">
			<input type="submit" value="提交" style="margin-top:10px;"/>		
		</div>	
	</form>
	</div>
</div>
	
	
<!-- <h2>添加积分等级</h2>
<form action="FrmJifenSign.levelInsert" method="post">
	<input type="hidden" value="in" name="in">
	<p>等级：<input type="text" name="grade_" placeholder="请输入积分等级"></p>
	<p>积分值：<input type="text" name="num_" placeholder="请输入积分等级"></p>
	<p>等级说明：<input type="text" name="remark_" placeholder="请输入积分等级"></p>
	<p><input type="submit" value="提交"></p>
	<p><a href="FrmJifenSign">返回</a></p>
</form>  -->
</body>
</html>