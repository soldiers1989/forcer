<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资讯详情查看</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">资讯详情</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	   		 <!-- <a href="FrmInformationList">返回</a> -->
	    	 <a href="FrmInformationList" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel tc mt_20">
		<div class="group-box" name="null"  visible="false">
			<label>创建时间：</label><input type="text" value="${info.items.date_ }" disabled="disabled">
		</div>
		<div class="group-box" name="null"  visible="false">
			<label>文章标题：</label><input type="text" value="${info.items.title_ }" disabled="disabled">
		</div>
		<div class="group-box" name="null"  visible="false">
			<label>文章内容：</label><input type="text" value="${info.items.content_ }" disabled="disabled">
		</div>
</body>
</html>