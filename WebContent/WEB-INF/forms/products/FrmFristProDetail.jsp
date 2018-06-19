<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../../files/common.css">
    <link rel="stylesheet" href="../../css/online_store.css">
    <title>一启享</title>
    <style>
    .main_content1{
    	font-family: MicrosoftYaHei;
   		width: 100%;
    }
    	.classify_list{
	    	position: fixed;
	   		left: 0;
	    	height: 86%;
    	}
    	.classify_message{
    		width:4.77rem;
    		float:right;
    		height: 86%;
    		margin-bottom:1rem;
    	}
    	.classify_message li {
	    	width: 1.5rem;
	    }
	    /* .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
   .clearfloat{zoom:1} */
    </style>
</head>
<body>
<div class="header1">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">商品分类</div>
</div>
<div class="main_content1" id="commodity_classify">
    <div id="mat"></div>
    <ul class="classify_list fl " id="frist">
        <%--  <li>
          <a href="FrmRentWei.queryFristId?fristNameId_=${val.items.fristNameId_}">
         <div class="${empty val.items.fristNameId_ ? 'listActive':''}"  style="display: block"></div>全部
         </a>
         </li> --%>
          <li class="${empty fristNameId_ ? 'listActive':''}" >
          <a href="FrmRentWei.queryFristId">
         	<div class="identification fl "></div>全部
         </a>
         </li>
    	<c:forEach items="${value }" var="val">
				<li class="${val.items.fristNameId_==fristNameId_? 'listActive':''}">
                    <a href="FrmRentWei.queryFristId?fristNameId_=${val.items.fristNameId_}">
    					<div class="identification fl"></div><div>${val.items.fristName_ }
    						<input type="hidden" name="fristNameId_" value="${val.items.fristNameId_ }"/>
    					</div>
                    </a>
				</li>
		</c:forEach>
    </ul>
    
    <ul class="classify_message" style="display: block">
        <c:forEach items="${products }" var="product">
            <li class="fl">
                <a href="FrmRentWei.queryByFristId?fristNameId_=${product.items.fristNameId_ }&twoNameId_=${product.items.twoNameId_}">
                    <div class="commodity_img"><img src="${product.items.twoImgUrl_}" alt=""></div>
                    <div class="commodity_name font12 tc">${product.items.twoName_}</div>
                </a>
            </li>
        </c:forEach>
        <div id="foot_mat"></div>
    </ul>
    <c:if test="${!empty msg}">
        <div style="color: red;" class="msg">${msg}</div>
        </c:if>
    <div id="foot_mat"></div>
    
 	<!-- 底部链接 -->
    <ul class="p_footer">
        <li>
            <a href="FrmRentWei">
               <%--  <div><img src="${cnd }/img/indexA.png" alt=""></div>
                <div><img src="${cnd }/img/indexB.png" class="listImg" alt=""></div> --%>
                 <div><img src="../../img/guiziA.png" alt=""></div>
                <div><img src="../../img/guiziB.png" class="listImg" alt=""></div>
                <div>首页</div>
            </a>
        </li>
        <li class="footActive">
            <a href="FrmRentWei.queryFristId">
               <%--  <div><img src="${cnd }/img/classifyA.png" alt=""></div>
                <div><img src="${cnd }/img/classifyB.png" class="listImg" alt=""></div> --%>
                 <div><img src="../../img/femleiA.png" alt=""></div>
                <div><img src="../../img/fenleiB.png" class="listImg" alt=""></div>
                <div>分类</div>
            </a>
        </li>
        <li>
            <a href="FrmMyBoxGroup.nearbyCabinet">
                <!-- <div><img src="../../img/fujinA.png" alt=""></div>
                <div><img src="../../img/fujinB.png" class="listImg" alt=""></div> -->
                <div><img src="../../img/nearbyA.png" alt=""></div>
                <div><img src="../../img/nearbyB.png" class="listImg" alt=""></div>
                <div>附近柜</div>
            </a>
        </li>
        <li>
            <a href="FrmMore.userCenter">
                <div><img src="${cnd }/img/wodeA.png" alt=""></div>
                 <div><img src="${cnd }/img/wodeB.png" class="listImg" alt=""></div>
                <div>我的</div>
            </a>
        </li>
    </ul>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script src="../../js/modal.js"></script>
<script src="../../js/common.js"></script>
<script>
    $(".classify_list").on("click","li",function(){
        $(this).addClass("listActive").siblings().removeClass("listActive");
        $(this).find(".identification").show().parent().siblings().find(".identification").hide();
        $(".classify_message").hide();
        $(".classify_message").eq($(this).index(0)).show();
    })
</script>
</body>
</html>