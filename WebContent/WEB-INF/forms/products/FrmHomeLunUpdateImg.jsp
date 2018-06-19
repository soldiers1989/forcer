<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改链接路径</title>

<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">修改链接路径</span>
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
	<form action="FrmAdminHomeAdManage.upLunBoAd?up=up" method="post" >
		<div class="group-box two" name="null" visible="false">
			<label >链接路径：</label>
			<input type="text" name="imgSrc_" value="${value_selId.items.imgSrc_}">
		</div>
		<div  class="group-box "  visible="false">
			<input type="hidden" name="UID_" value="${value_selId.items.UID_}">
			<input type="submit" value="修改" >
		</div>	
	</form>
	</div>
</div>
<%-- <form action="FrmNewslist.upNews" method="post" >
	<input type="text" name="content_" value="${values.items.content_}">
	<input type="hidden" name="id_" value="${values.items.id_}">
	<input type="submit" value="修改" >
</form> --%> 
</body>
</html>