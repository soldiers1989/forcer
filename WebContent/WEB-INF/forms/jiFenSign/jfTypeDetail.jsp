<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>积分类型详情</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">积分类型详情</span>
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
		<div class="group-box" name="null" id="component1" visible="false">
			<label>积分类型：</label><input type="text" value="${detail.items.type_ == '0'?'签到积分':'邀请积分' }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>所属模块：</label><input type="text" value="${detail.items.type_ == '0'?'签到':'邀请' }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>积分值：</label><input type="text" value="${detail.items.integral_ }" disabled="disabled">
		</div>	
	</div>
</div>
	<%-- <p>积分类型：<label>${detail.items.type_ == '0'?"签到积分":"邀请积分" }</label></p>
	<p>所属模块：<label>${detail.items.type_ == '0'?"签到":"邀请" }</label></p>
	<p>积分值：<label>${detail.items.integral_ }</label></p>
	<p><a href="FrmJiFenType">返回</a></p> --%>
</body>
</html>