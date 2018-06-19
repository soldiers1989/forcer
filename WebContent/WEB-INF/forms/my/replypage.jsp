<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
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
<head> 
<title>意见回复</title> 
</head> 
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">反馈详情</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	<a href="FrmFeedback" class="btn_style">返回</a>
	    	<!-- <a href="javascript:window.history.go(-1);" class="btn_style">返回</a> -->
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
<div class="easyui-panel tc mt_20">
		<form name="form" method="post" action="FrmFeedback.reply" onsubmit="return check();" >
			<div class="group-box" name="null" id="component1" visible="false">
				<label>反馈内容：</label>${values.items.view_}
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>反馈时间：</label>${values.items.submit_time }
			</div>
			<div class="group-box clearfloat" name="null" id="component1" visible="false">
				<label style="float:left">回复内容：</label>
				<div style="float:right;width:88%">
				<!-- <textarea id="editor" placeholder="这里输入内容" maxlength="1000" style="margin-left:10%;width: 290px; border-radius: 4px; padding: 10px; border: 1px solid #ddd;" rows="5" cols="15" name="content_"></textarea>-->				
				<textarea id="editor" style="width: 290px;border-radius: 4px;padding:10px; border: 1px solid #ddd;" rows="5" cols="15" name="reply_"  >${values.items.reply_ }</textarea>
				<script type="text/javascript">
					CKEDITOR.replace('editor');
				</script>
			</div>
			</div>
	<div class="group-box " name="null" id="component1" visible="false">
			<input type="submit"  value="回复" style="margin-top:10px;width:100px;margin-left:106px !important" class="btn_style"> 
		</div>
		<input type="hidden" name="replyid_" value="${values.items.replyid_ }">
		<input type="hidden" name="id_" value="${values.items.id_ }">
		</form>
	</div>





<%-- 
	<p><a href="FrmFeedback">返回</a></p>
	<div>
	<p>反馈内容:<label>${values.items.view_}</label></p>
	<p>反馈时间:<label>${values.items.submit_time }</label></p>
	
	<form name="form" method="post" action="FrmFeedback.reply" onsubmit="return check();" >
		<!-- <textarea name="reply_" id="text" cols="15" rows="3"  style="resize:none;"style="overflow-x:scroll;overflow-y:hidden;"></textarea>   
		<span id="span"></span> -->
		<span>回复内容：</span>
		<textarea id="editor" style="width: 290px;border-radius: 4px;padding:10px; border: 1px solid #ddd;" rows="5" cols="15"
									name="reply_"  >${values.items.reply_ }</textarea>
				<script type="text/javascript">
					CKEDITOR.replace('editor');
				</script>
		<input type="hidden" name="replyid_" value="${values.items.replyid_ }">
		<input type="hidden" name="id_" value="${values.items.id_ }">
		<input type="submit" value="回复" >
	</form>
	</div>  --%>
</body>
<script type="text/javascript">
	CKEDITOR.replace('editor');
</script>
<script type="text/javascript">
		function check() {
			var editor = CKEDITOR.instances['editor'].getData();
			editor = editor.replace("<p>","").replace("</p>","");			
			 var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
			if(editor == ""){
				alert("反馈内容不可为空");
				return false;
			}
			if(regRule.test(editor)){
				alert("不支持表情");
				return false;
			}  
		}
	</script> 
</html>