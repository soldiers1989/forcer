<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@  taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>提交反馈</title>
</head>
<style >
 	.no_content img{
    	position: absolute;
    	left: 50%;
    	top: 64%;
    	transform: translate(-50%,-50%)
    }
     .no_content{
      min-height:6rem;
      text-align: center;
    /*   padding: .51rem 0; */
      background-image:url('../../img/zwsj.png');
      background-position:center  1.5rem;
      background-repeat: no-repeat;
      background-size:40%;
    } 
</style>
<body>
<div class="header2">
    <a href="javascript:history.back(-1)" class="prev"></a>
    <div class="head_title font18">意见反馈</div>
    
</div>
<div class="main_content" id="idea_feedback">
    <div id="mat"></div>
     <form action="FrmFeedback.addFeedback" method="post" onsubmit="return check()">
         <input type="hidden" value="in" name="in">
         <textarea name="view_" id="view_" placeholder="请填写您要反馈的问题"></textarea>
         <div class="words_num font10 text-gray"><span class="specific_num1"><!-- 0</span>/ --><span class="target_num">200</span>字</div>
         <input type="submit" value="提交" class="more_submit text-gold font15">
     </form>
    <div class="feedback_title">反馈记录</div>
    <c:if test="${empty values }">
    	<div class="no_content">
    		 <%-- <img alt="" src="${cdn }/img/zwsj.png" style="width: 2.5rem;">  --%>
    	</div>
    </c:if>
    <c:if test="${not empty values }">
    <ul class="feedback_list">
        <c:forEach items="${values }" var="val">
            <li>
                <a href="FrmFeedback.feedBackDetail?id_=${val.items.id_ }">
                    <div class="font15">${val.items.view_ }</div>
                    <div class="font12 text-gray">${val.items.submit_time }</div>
                </a>
            </li>
        </c:forEach>
    </ul>
     </c:if>
</div>
<%--  <div>
 <form action="FrmFeedback.addFeedback" method="post" onsubmit="return check()">
 <input type="hidden" value="in" name="in">
      <textarea name="view_" id="view_" placeholder="请填写您要反馈的问题"></textarea>
      <div class="words_num"><span class="specific_num">200</span><span class="target_num">/200字</span></div>
    <input type="submit" value="提交">
 </form>
 </div>
<div>
    <h2>反馈记录</h2>
    <form action="">
        <c:forEach items="${values }" var="val">
            <a href="FrmFeedback.feedBackDetail?id_=${val.items.id_ }">
                <p>${val.items.view_ }</p>
                <p>
                    ${val.items.submit_time }
                </p>
            </a>
        </c:forEach>
    </form>
</div> --%>
</body>
<script type="text/javascript">
        function check() {
            var view_ = $("#view_").val().trim();
            var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
            if(view_ == ""|| view_== null){
                alert("反馈内容不可为空");
                return false;
            }
            if(regRule.test(view_)){
                alert("不支持表情");
                return false;
            }
            if(view_ != ""|| view_!= null){
            	 alert("感谢您提出的宝贵意见，我们会努力为大家提供更宝贵的服务");
            	 return true;
            }
        }
    </script>
</html>