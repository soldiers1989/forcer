<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cldn}/js/jquery-1.9.1.min.js"></script>
<title>修改使用流程</title>
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
</head>
<body>
	<form action="FrmUseProcess.processModify" method="post" onsubmit="return check();">
		<p>
			<input type="hidden" name="up" value="up">
			<input type="hidden" name="UID_" value="${process.items.UID_ }">
		</p>
		<p>
			<span>使用流程</span>
			<textarea id="editor" style="width: 290px;border-radius: 4px;padding:10px; border: 1px solid #ddd;" rows="5" cols="15"
				name="content_">${process.items.content_ }</textarea>
			<script type="text/javascript">
				CKEDITOR.replace('editor');
			</script>
		</p>
		<p>
			<input type="submit" value="提交">
		</p>
	</form>
</body>
<script type="text/javascript">
	function check(){
		var content = $("#editor").val();
		if(content == null || content == ""){
			alert("您还没填写资料哪");
			return false;
		}
	}
</script>
</html>