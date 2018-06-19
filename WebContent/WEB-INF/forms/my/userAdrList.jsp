<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>地址管理</title>
<script type="text/javascript">
	
	function del(id){
		var msg = "您真的确定要删除吗？\n\n请确认！"; 
		 if (confirm(msg)==true){ 
		  $.ajax({
				url:"FrmAdrmanage.deleteadr",
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
	
	function def(id,userId){
		var obj = new AjaxObj();
		obj.ajax(id,userId);	 
	}
	
	function AjaxObj(){
		this.ajax = function(id,userId){
			$.ajax({
				url:"FrmAdrmanage.upDef",
				type:'get',
				data:{"id_":id,"userId_":userId},
				datatype:"text",
				success:function(data){
					 window.location.href="FrmOrder_Lease.execute?userId_="+userId+"&orderType_=${orderType_}&zhuCode_=${zhuCode_}"; 
				},
				error:function(){
				
				},	
			})
		}
	}
	
</script>
</head>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">地址管理</div>
    <!-- <div class="more"><img src="../../img/1.jpg" alt=""></div> -->
</div>
<body>
<div class="main_content" id="order_address">
    <div id="mat"></div>
	<div>
		<c:forEach items="${values }" var="value">
			<%-- <div>
				<a onclick="def('${value.items.id_}','${value.items.userId_}');" >
					<span>收件人：${value.items.name_}</span>
					<span>收件人电话：${value.items.telpho_}</span>
					<span>地址：${value.items.adr_}/${value.items.exactadr_}</span>
				</a>
			</div> --%>
			<div class="address_list">
				<a onclick="def('${value.items.id_}','${value.items.userId_}');" class="border_b">
					<div class="flexLayout font_16">
						<span class="list_left font16">${value.items.name_}</span>
						<span class="list_right font16">${value.items.telpho_}</span>
					</div>
					<div class="specific_address font_14">${value.items.adr_}/${value.items.exactadr_}</div>	
				</a>
			</div>
		</c:forEach>
	</div>
	<div style="height: .75rem;"></div>
	<a href="FrmAdrmanage.goIncreaseadr?mode=1&userId=${userid}&orderType_=${orderType_}&zhuCode_=${zhuCode_}" class="order_addAddress">添加收货地址</a>
</div>
</body>
</html>