<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../jspf/head1.jspf"%>
<script type="text/javascript">
	window.localStorage.removeItem("menu-bx");
</script>
<script type="text/javascript" src="${cdn}/admin/js/echarts.min.js"></script>
<%@include file="../ui/head2.jspf" %> 
<!--中间内容-->
<style>
#mid-box{
	  position: relative;
}
/* #mid-box img.ic1{
	margin-top: 200px;
	margin-left: 50px;
	width: 500px;
}
#mid-box img.ic2{
	position: absolute;
	right:0;
	top:0;
	width: 1024px;
	z-index: -1
} */
.welcome{
	width:500px;
	height:250px;
	border:2px solid #48b2bd;
	color:#48b2bd;
	text-align:center;
	margin:auto;
	margin-top:20%;
	position:relative;
}
.text1{
	margin-top:55px;
	font-size:40px;
	line-height:100px;
}
.text2{
	font-size:30px;
	line-height:23px;
}
.mouse{
	position:absolute;
	bottom: -70%;
    left: -48%;
}
.mouse img{
	height:300px;
}
</style>
<div class="mid-box" id="mid-box">
<div class="welcome">
	<div class="text1">欢迎光临</div>
	<div class="text2">一启享后台管理系统</div>
	<div class="mouse">
		<%-- <img src="${cdn}/img/mouse.png" > --%>
	</div>
</div>
 	<%-- <img src="${cdn}/img/cs/welcom2.png" class="ic1">
    <img src="${cdn}/img/cs/welcom1.png" class="ic2">  --%> 
</div>
<!-- <script type="text/javascript">
window.onload=function(){
	var menbox = $("#men-bx");
	menbox.find("span.item").removeClass("curr");
	menbox.find("ul.menu-next").hide().find("a.two").removeClass("curr");
	menbox.find(".menus:eq(0)").find("span.item").addClass("curr").next("ul").show().find("a.two:eq(0)").addClass("curr"); 
	 
}

</script> -->
</body>
</html>