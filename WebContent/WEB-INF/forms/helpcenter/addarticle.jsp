<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
   <%--  <%@include file="../jspf/head1.jspf"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <%--  <%@include file="../jspf/head1.jspf"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加文章</title>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
	<!--编辑器插件-->
<link rel="stylesheet" type="text/css"
	href="${cdn}/admin/bianjiqi/styles/font-awesome.css" />
<link rel="stylesheet" type="text/css"
	href="${cdn}/admin/bianjiqi/styles/simditor.css" />
<link rel="stylesheet" type="text/css"
	href="${cdn}/admin/css/newAdd.css" />
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/module.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/uploader.js"></script>
<script type="text/javascript"
	src="${cdn }/admin/plugin/ckeditor/ckeditor.js"></script>
	<style>
		.mar{
		margin-left:10%;
		}
	</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加文章</span>
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
		<form action="FrmHelpcenter.addArticle" id="subForm">
			<div class="group-box" name="null" id="component1" visible="false">
				<label>标题：</label><input type="text"  id="leasetitle_" name="title_" maxlength="255">
			</div>
			<div class="group-box clearfloat" name="null" id="component1" visible="false">
				<label style="float:left">内容：</label>
				<div style="float:right;width:88%">
				<textarea id="editor" placeholder="这里输入内容" maxlength="1000" style="margin-left:10%;width: 290px; border-radius: 4px; padding: 10px; border: 1px solid #ddd;" rows="5" cols="15" name="content_"></textarea>			
				</div>
			</div>
		<div class="group-box" id="component4" >
			<input type="submit"  value="保存" style="margin-top:10px;">
		</div>
		</form>
	</div>
	
<!-- <div  id="mid-box">
	
	<div >
	    <a href="FrmHelpcenter" class="btnStyle">返回</a>
	</div>
	<form action="FrmHelpcenter.addArticle" id="subForm">
		
		<div>
			<span>标题：</span>
			<input type="text"  id="leasetitle_" name="title_" maxlength="255">
		</div>
		<div class="content_edit">
			<div>内容：</div>
			<textarea id="editor" placeholder="这里输入内容" maxlength="1000" style="width: 290px; border-radius: 4px; padding: 10px; border: 1px solid #ddd;" rows="5" cols="15" name="content_"></textarea>
		</div>
             <input type="submit"  value="保存">
	</form> -->
    <script type="text/javascript">
        var editorE = CKEDITOR.replace('editor');
    </script>
</div>
</body>
</html>