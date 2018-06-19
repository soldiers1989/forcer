<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试</title>
</head>
<body>
	<div class="header2">
		<div class="head_title font18">测试ios提交</div>
	</div>
	<div class="main_content" id="my_set">
		<div id="mat"></div>
		<div class="list">
			<form action="FrmCommunityList.testJson" id="consultForm" enctype="multipart/form-data" method="post">
				<input type="text" name="text_" id="text_"> 
				<input type="file" name="file_" id="file_">
				
				<input type="button" value="提交" onclick="sendMessage()"/>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	function consultSubmit(obj) {
		var formData = new FormData($("#consultForm")[0]);
		var serializeUrl = $("#consultForm").serialize();
		var text_ = $('#text_').val();
		var file_ = $('#file_').val();
		alert(text_ + file_)
		alert("formData:" + formData);
		alert("serializeUrl:" + serializeUrl);
		$("#consultForm").submit();
		/* $.ajax({
			url : "FrmCommunityList.testJson",
			type : "POST",
			data : {
				"file_" : file_,
				"text_" : text_
			},
			dataType : "json",
			success : function(data) {
				if(data == true){
					alert("有值");
				}else{
					alert("没值");
				}
			},
			error : function(data) {
			}
		}) */
	}
	function sendMessage() {
		alert($("#file_").val());
	    // 没有选择文件
	    if($("#file_").val() != null) {
	    	alert(1);
	        var formData = $("#consultForm").serialize();
	        $.post("FrmCommunityList.testJson", formData, function(data) {
	        	if(data == true){
					alert("有值1");
				}else{
					alert("没值1");
				}
	        });
	    }else {
	    	alert(2);
		    // 选择了文件
	        var formData = new FormData($("#consultForm")[0]);
	        $.ajax({
	            url: 'FrmCommunityList.testJson',
	            type: 'POST',
	            data: formData,
	            async: true,
	            cache: false,
	            contentType: false,
	            processData: false,
	            success: function (data) {
	            	if(data == 'true'){
						alert("有值");
					}else{
						alert("没值");
					}
	            }
	        });
	    }
	}
</script>
</html>