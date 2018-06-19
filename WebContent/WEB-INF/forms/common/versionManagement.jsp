<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>版本控制</title>
<style>
	.tableWidth{
		width:10%;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">版本列表</span>
    </div>
	<form action="FrmCabinetAdImg.upCabinetAd" enctype="multipart/form-data" method="post" id="subForm">
	    <div role="grid" style="margin-top:20px;">
	        <div class="table">
	        <a href="FrmVersionManagement.addPage" class="btn_style mb_10">发布新版本</a>
	       		<table class="tbl">
	       		<tbody>
	       			<tr>
	       				<td class="t-head">序号</td>
	       				<td class="t-head">版本上传人</td>
	       				<td class="t-head">版本上传时间</td>
	       				<td class="t-head">版本名称</td>
	       				<td class="t-head">版本号</td>
	       				<td class="t-head">版本文件</td>
	       				<td class="t-head">操作</td>
	       			</tr>
	       			</tbody>
	       			<tbody class="t-body tc">
	       			<c:forEach items="${version }" var="var" varStatus="status">
		       			<tr>
                            <td>${status.index+1 }</td>
                            <td>${var.items.createUser_}</td>
		       				<td>${var.items.createDate_}</td>
		       				<td>${var.items.versionName_}</td>
		       				<td>${var.items.versionNum_}</td>
		       				<td><a href="${var.items.versionFile_}" class="btn_style">点击下载版本文件</a></td>
		       				<td><a onclick="del(${var.items.UID_ })" class="btn_style">删除</a></td>
		       			</tr>
	       			</c:forEach>
	       			</tbody>
	       		</table>
	        </div>
	    </div>
    </form>
 </div>
</body>
<script type="text/javascript">
	function getImgURL(node) {
		$.ajax({
			url : 'FrmSesameCredit.zhimaAuthInfoAuthorize',
			dataType : 'json',
			type : 'post',
			data : { 
				"name_" : name_,
				"card_" : card_
		    },
			cache : false,
			success : function(data) {
				alert("提交成功！");
				window.location.href = data;
			}
		});
	}
	function del(id_){
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg)==true){
			$.ajax({
				url : 'FrmVersionManagement.delVersion?id_='+id_,
				type : 'post',
				success : function(data) {
					if(data == "true"){
						alert("删除成功！");
						window.location.href = "FrmVersionManagement"; 
					}else{
						alert("删除失败！")
						window.location.href = "FrmVersionManagement"; 
					}
				}
			});
		}else{
			return false;
		}
	}
</script>
</html>