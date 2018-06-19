<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script type="text/javascript" > 
	
	function del(id){
			var msg = "您真的确定要删除吗？\n\n请确认！"; 
			 if (confirm(msg)==true){ 
			  $.ajax({
					url:"FrmFeedback.deleopinion",
					type:'post',
					data:{"id_":id},
					datatype:"text",
					success:function(data){
						alert("删除成功");
						location.reload();
					},
					error:function(){
					
					},	
				})	 
			 }else{ 
			  return false; 
			 } 
						 
		
			}
	</script>
<title>后台回复</title>
</head>

<body>
	<c:forEach  var="val" items="${values }">
	<div>
	<input type="text" name="view" readonly value="${val.items.view_}"/><br>
	<input type="text" name="time" readonly value="${val.items.submit_time }">
	</div>
	<input type="button" name="del" value="删除" onclick="del('${val.items.id_}');">
	<a href="FrmFeedback.addreply?id_=${val.items.id_}&falg=1">回复</a>
	</c:forEach>
</body>
</html>