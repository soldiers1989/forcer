<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>修改商务合作信息</title>
</head>
<body>
<form action="">
	<div>
	<input type="hidden" value="up" name="up">
	<input type="hidden" value="${bussiness.items.UID_}"  name="UID_">
		<span>商务合作</span>
		<textarea id="editor" style="width: 290px;border-radius: 4px;padding:10px; border: 1px solid #ddd;" rows="5" cols="15"
			name="content_">${bussiness.items.content_ }</textarea>
			<script type="text/javascript">
				CKEDITOR.replace('editor');
			</script>
	</div>
	<div>
		<input type="submit" value="提交">
	</div>
</form>
</body>
</html>