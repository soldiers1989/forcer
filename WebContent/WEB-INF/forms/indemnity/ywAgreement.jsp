<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>一启享</title>
</head>
<body>
	<h2>运维协议</h2>
	<div>
		<label>${ywagreement.items.title_ }</label>
		<div class="content_edit group-box clearfloat" id="component1" >
			<div style="width:88%;margin-top:20px;">
				<textarea  id="editor"  maxlength="1000" style="width: 290px; border-radius: 4px; padding: 10px; border: 1px solid #ddd;" rows="5" cols="15" name="content_" >${ywagreement.items.content_ }</textarea>
			</div>
		</div>	
	</div>
	    <script type="text/javascript">
        var editorE = CKEDITOR.replace('editor');
    </script>
</body>
</html>