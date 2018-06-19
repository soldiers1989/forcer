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
<title>修改捐赠说明</title>
</head>
<body>
	<form action="FrmDonation.updateExplain" method="post" onsubmit="return check();"> 
	<input type="hidden" value="${explain.items.UID_ }">
	<input type="hidden" value="up" name="up">
		<div>
		<span>捐赠说明：</span>
			<textarea id="editor" style="width: 290px;border-radius: 4px;padding:10px; border: 1px solid #ddd;" rows="5" cols="15"
							name="explain_"  >${explain.items.explain_ }</textarea>
							<script type="text/javascript">
								CKEDITOR.replace('editor');
							</script>
		</div>
		<div>
			<input type="submit" value="提交">
		</div>
	</form>
</body>

<script type="text/javascript">
	function check(){
		var  description_ = $("#editor").val();
		if(description_ == ""){
			alert("内容不可为空");
			return false;
		}
	}
</script>
</html>