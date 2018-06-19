<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
<!-- <div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">我的捐赠</div>
</div> -->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">公益捐赠</div>
</div>

<!-- 我的捐赠列表 -->
<%-- <div class="main_content" id="my_donate">
    <div id="mat"></div>
    <ul class="donate_list">
        <li>
            <a class="flexLayout" href="#">
                <div class="donate_content">
                    <div class="donate_name font14">佳能750D单反相机</div>
                    <div class="donate_num font14">数量：1</div>
                    <div class="donate_time font11">2018-01-15 16:20</div>
                </div>
                <div class="donate_more"><img src="${cdn }/img/rightArrows.png" alt=""></div>
            </a>
        </li>
        <li>
            <a class="flexLayout" href="#">
                <div class="donate_content">
                    <div class="donate_name font14">佳能750D单反相机</div>
                    <div class="donate_num font14">数量：1</div>
                    <div class="donate_time font11">2018-01-15 16:20</div>
                </div>
                <div class="donate_more"><img src="${cdn }/img/rightArrows.png" alt=""></div>
            </a>
        </li>
        <li>
            <a class="flexLayout" href="#">
                <div class="donate_content">
                    <div class="donate_name font14">佳能750D单反相机</div>
                    <div class="donate_num font14">数量：1</div>
                    <div class="donate_time font11">2018-01-15 16:20</div>
                </div>
                <div class="donate_more"><img src="${cdn }/img/rightArrows.png" alt=""></div>
            </a>
        </li>
    </ul>
</div> --%>
<%-- <c:forEach items="${values }" var="value" varStatus="status">
    ${value.items.explain_}
    </c:forEach> --%>

<!-- 公益捐赠 -->
<div class="main_content" id="benefit_donate">
    <div id="mat"></div>
    <div class="donate_hint font13">从事商务合作的企业或者人必须有一定的资格，合作双方必须签订正式的合作意向，或者签订合同，必须为此次商务合作做好充分的准备，并为此负法律责任</div>
    <div class="donate_img"><img alt="" src="${cdn }/img/1.jpg"> </div>
    <div class="donate_hint font13">从大的方向来讲，社会行业分为制造业，零售业，服务业，农业。从互联网领域来讲又分为传统互联网和移动互联网，细分下去还有门户，搜索引擎，网络服务，网游，视频网站，电商，互联网基础服务，远程教育等。在行业认识上其实很多新人都有个误区，认为过度包装能够增强自信，提高达成合作的可能。事实上无论行业大小都有自己的优势和价值，无需妄自菲薄，也没必要自我吹嘘。</div>
    <div class="donate_img"><img alt="" src="${cdn }/img/2.jpg"> </div>
</div>
</body>
</html>