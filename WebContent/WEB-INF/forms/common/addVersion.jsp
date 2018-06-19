<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${cdn}/css/style.css"/> 
<title>版本控制</title>
<style>
	#subVersion{
		margin-left:108px;
		margin-top:20px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">添加版本</span>
    </div>

	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	
	<form id="versionU_" action="FrmVersionManagement.addVersion" enctype="multipart/form-data" method="post">
	    <div role="grid" class="group-box mt_20">
	        <div >
	        	<label>版本名称：</label><input type="text" name="versionName_" id="versionName_">
	        </div>
	        <div >
	        	<label>版本号：</label><input type="text" name="versionNum_" id="versionNum_">
	        </div>
	        <div>
	        	<label class="fl">版本文件：</label>
			 	<input type="file" name="versionFile_" id="versionFile_">			       
	 		 </div>
	         <div>
	        	<input type="button" value="提交" id="subVersion">
	         </div>
	    </div>
    </form>
 </div>
</body>
<script type="text/javascript">
	$("#subVersion").click(function(){
		var versionNum_ = $("#versionNum_").val();
		var versionFile_ = $("#versionFile_").val();
		var versionName_ = $("#versionName_").val();
		if(versionName_ == ""){
			alert("请输入版本名称！")
			return false;
		}
		if(versionNum_ == ""){
			alert("请输入版本号！")
			return false;
		}
		if(versionFile_ == ""){
			alert("请上传版本文件")
			return false;
		}
		$("#versionU_").submit();  
  	});
</script>
</html>