<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@  taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>运维端意见反馈</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">意见反馈</div>
    
</div>
<div class="main_content" id="idea_feedback">
    <div id="mat"></div>
     <form action="FrmFeedback.addFeedback" method="post">
         <input type="hidden" value="in" name="in">
         <textarea name="view_" id="view_" placeholder="请填写您要反馈的问题"></textarea>
         <div class="words_num font10 text-gray"><span class="specific_num1">0</span>/<span class="target_num">200</span>字</div>
         <input type="submit" value="提交" class="more_submit text-gold font15">
     </form>
    <div class="feedback_title">反馈记录</div>
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
</div>
</body>
<!-- <script type="text/javascript">
        function check() {
            var view_ = $("#view_").val();
            var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
            if(view_ == ""){
                alert("反馈内容不可为空");
                return false;
            }
            if(regRule.test(view_)){
                alert("不支持表情");
                return false;
            }
        }
    </script> -->
</html>