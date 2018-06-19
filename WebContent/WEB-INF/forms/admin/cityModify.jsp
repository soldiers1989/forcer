<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../jspf/head1.jspf"%>
<script type="text/javascript">
function submitForm(){
	if($("#id").val() == ''){
		// 新增
	 	$.post("FrmCityManage.checkCorpNoIsExist",{"corpNo":$("#corpNo").val()},function(resp){
			if(resp == "true"){
				alert("账号已存在");
			}else{
				$("#form").submit();
			}
		}); 
	}else{
		// 修改
		$("#form").submit();
	}
}
</script>
<%@include file="../jspf/head2.jspf"%>
<header class="head">
	<i class="fa fa-angle-left"></i> 城市管理
</header>
<div>
	<form action="FrmCityManage.executeUpdate" method="post" id="form">
		<input type="hidden" value="${cityInfo.items.UID_ }" name="id" id="id">
		<div>
			<label>账号类型：</label> <span> <input type="radio" value="0"
				name="corpType"
				<c:if test="${cityInfo.items.corpType_ == 0 }"> checked="checked" </c:if>>城市
				&nbsp;&nbsp; <input type="radio" value="1" name="corpType"
				<c:if test="${cityInfo.items.corpType_ == 1 }"> checked="checked" </c:if>>运营
			</span>
		</div>
		<div>
			<label for="corpNo">账号：</label> <span><input type="text"
				value="${cityInfo.items.corpNo_ }"
				<c:if test="${cityInfo.items.UID_ != null }">  readonly="readonly" </c:if>
				name="corpNo" id="corpNo" placeholder="账号"></span>
		</div>
		<div>
			<label for="shortName">城市简称：</label> <span><input type="text"
				value="${cityInfo.items.shortName_ }" name="shortName"
				id="shortName" placeholder="城市简称"></span>
		</div>
		<div>
			<label for="name">城市全称：</label> <span><input type="text"
				value="${cityInfo.items.name_ }" name="name" id="name"
				placeholder="城市全称"></span>
		</div>
		<div>
			<label for="wxAccount">城市微信公众号：</label> <span><input
				type="text" value="${cityInfo.items.wx_account_ }" name="wxAccount"
				id="wxAccount" placeholder="城市微信公众号"></span>
		</div>
		<div>
			<label for="wxAccount">状态：</label> <span> <input type="radio"
				value="0" name="status"
				<c:if test="${cityInfo.items.status_ == 0 }"> checked="checked" </c:if>>
				未启用 &nbsp; <input type="radio" value="1" name="status"
				<c:if test="${cityInfo.items.status_ == 1 }"> checked="checked" </c:if>>
				使用中 &nbsp; <input type="radio" value="2" name="status"
				<c:if test="${cityInfo.items.status_ == 2 }"> checked="checked" </c:if>>
				已停用 &nbsp;
			</span>
		</div>
		<div>
			<input type="button" value="提交" onclick="submitForm()"/>
		</div>
	</form>
</div>
<%@include file="../jspf/adminFooter.jspf"%>