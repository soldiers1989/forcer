<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>关于我们（运维端）</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">关于我们</div>
</div>
<div class="main_content" id="maintenance_aboutUs">
    <div id="mat"></div>
    <div class="signExplain_content">主营的电商业务启享商城已成长为中国最大的自营式电商企业，保持了远快于行业平均增速的增长，依据目前的发展速度，2021年前将成为中国最大的B2C电商平台。启享商城致力于打造一站式综合购物平台，服务中国亿万家庭，3C、家电、消费品、服饰家居家装、生鲜和新通路（B2B）全品类领航发力满足消费者多元化需求。</div>
</div>
<%-- <c:forEach items="${values }" var="value" varStatus="status">
<!--文章标题${value.items.title_ }  -->
文章内容${value.items.content_ }
时间${value.items.date_ }
</c:forEach> --%>
</body>
</html>