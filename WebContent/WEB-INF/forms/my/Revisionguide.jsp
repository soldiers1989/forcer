<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<head>
<script type="text/javascript">
function upd(id){
		$.ajax({
			url:"FrmGuideList.updArcitle",
			type:'post',
			data:{"id_":id},
			datatype:"text",
			success:function(data){
				location.reload();
				alert("修改成功");
			},
			error:function(){
			}	
		})
	}


function checkForm(){
	var content=$.trim($("#content").val());
	  var title=$.trim($("#title").val());
	  if(title==""){
		  alert("文章标题不能空");
		  return false;
	  }else if(content==""){
		  alert("文章内容不能空");
		  return false;
	  }
	  
	  return true;
}




</script>
<body>

	<form name="form" method="post" action="FrmGuideList.updArcitle1" onsubmit="return checkForm()";>
		文章标题&nbsp;&nbsp;&nbsp;<input type="text" name="title" id="title" value="${values.items.title_}"/>
		文章内容&nbsp;&nbsp;&nbsp;</br>
		<textarea rows="10" cols="30"
			style="overflow: scroll:overflow-x:hidden" name="content" id="content">${values.items.content_ }</textarea>
		<input type="hidden" name="id_" value="${values.items.id_ }">
		<input type="submit" value="修改">&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
</body>
</html>