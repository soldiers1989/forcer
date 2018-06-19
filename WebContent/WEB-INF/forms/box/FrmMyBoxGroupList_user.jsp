<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cnd }/files/common.css">
    <link rel="stylesheet" href="${cnd }/css/user.css">
    <link rel="stylesheet" href="${cnd }/css/online_store.css">
    <title>一启享</title>
    <style>
.cabinet_topAddress{
	height:1.4rem;
	background-color:white;
	margin-bottom:1px;
}
    .myGroupList_search{
    width:100%;
    height:0.729rem;
  	margin:0.1rem 0 0.1rem;
    }
    .myGroupList_search div{
    width:90%;
    height:100%;
    border-radius: 0.1rem;
  /*   padding-top:0.1rem; */
   
    background-color:#ededed;
    margin-left:5%;
   
    }
    .myGroupList_search img{
    width:0.271rem;
     padding-left:0.22rem;
     padding-right:0.2rem;
    }
    .myGroupList_search input{
    width:85%;
    height:100%;
     background-color:#ededed;
    border:none;
    color:#b3b3b3b3;
   
    }
    </style>
    <script type="text/javascript">
	function gotoSearchPage() {
		window.location="FrmMyBoxGroup.searchPage";
	}
</script>
</head>
<body>
<div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
    <div class="more"><span></span><span></span><span></span></div>
</div>
<div class="header1">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">附近柜</div>
</div>
  
<div class="main_content" >
    <div id="mat"></div>

    <!--   搜索框 -->
    <div class="myGroupList_search">
    	<div>
    		<img src="../../img/search1.png" alt="" onclick="gotoSearchPage()" />
    		<input type="text" class="searchBox"  placeholder="搜索你想要的" class="searchText" onclick="gotoSearchPage();">
    	</div>  
    </div>
    
    
    <!-- 地址 -->
    <c:forEach var="cabinet" items="${cabinets }">
	     <div class="cabinet_topAddress flexLayout" style="margin-bottom:1px;background-color:white" id="cabinets">
	    	<a href="FrmMyBoxGroup?cabinetId=${cabinet.items.id_ }" style="width:70%">
            <div class="cabinet_address_text" id="cabinet">
	    		<p>${cabinet.items.communityName_ }${cabinet.items.communityNum_ } </p>
	    		<p>${cabinet.items.address_ }</p>
	    	</div>
            </a>
         
	    	<div class="cabinet_address_img" style="width:1rem">
	    	   <a href="FrmMyBoxGroup.myBoxPosition?cabinetId=${cabinet.items.id_ }">
	    		<img src="${cnd }/img/address_icon.png" style="margin-left:.7rem">
	    		<p>(约${cabinet.items.distance }m)</p>
	    		 </a>
	    	</div>
           
	    </div>
    
	</c:forEach>
    
	<!--  底部链接 -->
     <div id="foot_mat"></div>
    <ul class="p_footer">
        <li>
            <a href="FrmRentWei">
                <div><img src="../../img/guiziA.png" alt=""></div>
                <div><img src="../../img/guiziB.png" class="listImg" alt=""></div>
                <div>首页</div>
            </a>
        </li>
        <li>
            <a href="FrmRentWei.queryFristId">
                <div><img src="../../img/femleiA.png" alt=""></div>
                <div><img src="../../img/fenleiB.png" class="listImg" alt=""></div>
                <div>分类</div>
            </a>
        </li>
        <li class="footActive">
            <a href="FrmMyBoxGroup.nearbyCabinet">
                <div><img src="../../img/nearbyA.png" alt=""></div>
                <div><img src="../../img/nearbyB.png" class="listImg" alt=""></div>
                <div>附近柜</div>
            </a>
        </li>
        <li>
            <a href="FrmMore.userCenter">
                <div><img src="../../img/wodeA.png" alt=""></div>
                <div><img src="../../img/wodeB.png" class="listImg" alt=""></div>
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