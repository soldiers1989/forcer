<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
${jspPage.script}
${jspPage.css}
<style>
body{
	background: #f5f5f5
}
</style>
<%@include file="head2.jspf"%>
	<div class="conent" id="content">
		<div class="forget-box">
			<h3 class="min-col f16 mb_10">${title}</h3>
			<div class="tip">
				<ul>
					<c:if test="${nowStep == 1}">
						<li class="tl curr"><i class="one icon"></i><p>${lblStep1}</p></li>
						<li class="tc "><i class="two icon"></i><p>${lblStep2}</p></li>
						<li class="tr "><i class="over icon"></i><p>${lblStep3}</p></li>
					</c:if>
					<c:if test="${nowStep == 2}">
						<li class="tl"><i class="one icon"></i><p>${lblStep1}</p></li>
						<li class="tc curr "><i class="two icon"></i><p>${lblStep2}</p></li>
						<li class="tr "><i class="over icon"></i><p>${lblStep3}</p></li>
					</c:if>
					<c:if test="${nowStep == 3}">
						<li class="tl"><i class="one icon"></i><p>${lblStep1}</p></li>
						<li class="tc "><i class="two icon"></i><p>${lblStep2}</p></li>
						<li class="tr curr"><i class="over icon"></i><p>${lblStep3}</p></li>
					</c:if>
				</ul>
			</div>
			<c:if test="${nowStep == 1}">
				<div class="mid-keytext" id="test" style="">
					<div class="mb_20 mt_20">
						<%-- <span class="lf-box">${text.lable}</span> <input name="${text.name}" type="text" class="text" placeholder="${text.tip}"> --%>
						${txtAuthentication}
					</div>
					<div>
						<%-- <span class="lf-box">${mobileLable}</span> 
						<input type="text" name="${mobileName}" class="text wt-168" placeholder="${mobileTip}"> --%>
						${txtVerification}
						<!-- <span class="min-col get-scroe">获得验证码</span> -->
						${lblVerification}
					</div>
					<div class="sumb mt_20 pt_20">
						<!-- <input type="button" name="loginSubmit" class="btn for-btns" value="立即提交"> -->
						${btnLogin}
					</div>
					<div class="tr mt_20" style="padding-right: 100px">
						${lblLoginTip}${lblLogin}
					</div>
				</div>
			</c:if>
			<c:if test="${nowStep == 2}">
				<div class="mid-keytext" id="test" style="">
					<div class="mb_20 mt_20">
						<%-- <span class="lf-box">${text.lable}</span> <input name="${text.name}" type="text" class="text" placeholder="${text.tip}"> --%>
						${txtReSetPassword}
					</div>
					<div class="mb_20 mt_20">
						<%-- <span class="lf-box">${text.lable}</span> <input name="${text.name}" type="text" class="text" placeholder="${text.tip}"> --%>
						${txtNewReSetPassword}
					</div>
					<div class="sumb mt_20 pt_20">
						<!-- <input type="button" name="loginSubmit" class="btn for-btns" value="立即提交"> -->
						${btnLogin}
					</div>
					<div class="tr mt_20" style="padding-right: 100px">
						${lblLoginTip}${lblLogin}
					</div>
				</div>
			</c:if>
			<c:if test="${nowStep == 3}">
				<!--已完成-->
				<div class="pt_20 pb_20 mid-keytext" id="compty" style="display: block;">
					<div class="tc pt_20 pb_20 mt_20 mb_20">
						<img src="${cdn}/admin/images/icon/icon_big_over.png" style="display:inline-block;vertical-align: middle;" class="mr_10">
						<%-- 尊敬的用户:<br>密码重置成功,请使用新的密码<a href="${loginUrl}" class="min-col"> 登录</a> --%>
						<span class="tl" style="display: inline-block;vertical-align: middle;">${lblSubject}<br/>${lblSubjectInfo}${lblLogin}</span>
					</div>
				</div>
			</c:if>
		</div>
	</div>
<%@include file="footer.jspf"%>