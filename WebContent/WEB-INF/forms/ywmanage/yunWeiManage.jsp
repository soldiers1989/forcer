<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<link rel="stylesheet" href="${cdn }/css/order.css">
<style type="text/css">
  .isActive a{
    color:red !important;
    /* background-color:rgba(207, 176, 101, 0.5);
    color:#fff; */
    
  }
  h2{
    color:#808080;
  }
  .yunweiBill{
  	width:100%;
  	background-color:#fff;
  }
  .orderAll{
  	width:100%;
  	background-color:#fff;
  	margin-top:.2rem;
  }
  .indmnityDetail .indmnityMess{
  	width:75%;
  	line-height:.35rem;
  }
  .indmnityDetail .indmnityMess{
  	
  }
  .font222{
  	color:#222;
  }
  .font999{
  	color:#999;
  }
  .indmnityDetail .indmnityImg img{
  width: 1.604rem;
	height: 1.058rem;
	}
  .indmnityImg .guizi{
	background-color: #cfb065;
	color:#fff;
	position:absolute;
	bottom:0rem;
  	width: 1.5rem;
    height: 0.384rem;
    text-align:center;
    font-size: 0.205rem;
    line-height:0.384rem;
  }
  .indmnityDetail .indmnityImg{
  	position:relative;
  }
  .indmnityDetail{
  	padding-bottom:.2rem;
  }
  .indmnity{
  	
  }
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">运维管理</div>
</div>
<div class="main-contnet" id="maintain_management">
    <div id="mat"></div>
    <div class="house_box">
      <select class="house_estate house_estate1 font13"><option>A小区</option></select>
      <select class="house_estate house_estate2 font13"><option>红场花园小区</option></select>
    </div>
    <ul class="nav_bar4 nav_bar flexLayout" style="width: 100%;">
      <li class="font16 isActive" ><a href="#">运维单</a></li>
      <li class="font16"><a href="#">补货单</a></li>
      <li class="font16"><a href="#">调货单</a></li>
      <li class="font16"><a href="#">赔付单</a></li>
  </ul>
  
<%--      <ul class="mt_10 management_contnent">
       <li>
         <a href="#" class="flexLayout">
           <div class="management_img">
             <div><img alt="" src="${cdn }/img/1.jpg"> </div>
             <div class="cabinetGoods_num font12">A01</div>
           </div>
           <div class="management_details">
             <div class="font15">联想拯救者游戏笔记本电脑</div>
             <div class="font12"><span class="text-gray">上报人: </span>张大大</div>
             <div class="font12"><span  class="text-gray">上报时间: </span>2017-11-10  08:02:00</div>
           </div>
         </a>
       </li>
       <li>
         <a href="#" class="flexLayout">
           <div class="management_img">
             <div><img alt="" src="${cdn }/img/2.jpg"> </div>
             <div class="cabinetGoods_num font12">A01</div>
           </div>
           <div class="management_details">
             <div class="font15">联想拯救者游戏笔记本电脑</div>
             <div class="font12"><span class="text-gray">上报人: </span>张大大</div>
             <div class="font12"><span  class="text-gray">上报时间: </span>2017-11-10  08:02:00</div>
           </div>
         </a>
       </li>
       <!-- <li>图片</li>
       <li>联想拯救者游戏笔记本电脑</li>
       <li>张大大</li>
       <li>上报时间：</li> -->
     </ul> --%>
     
     <div class="orderAll">
     <!--  运维单 -->
       <div class="yworder">
		  <%-- <div class="indmnity ">
			    <div class="indmnityDetail flexLayout border_b">
			    	<div class="indmnityImg"><img src="${cdn }/img/1.jpg"></div>
			    	<div class="indmnityMess">
			    		<div class="font14">佳能750D单反相机</div>
			    		<div class="font999 font12">上报人：<span class="font222">￥200</span></div>
			    		<div class="font999 font12">上报时间：<span class="font222">￥200</span></div>
			    	</div>
			    </div>
		   </div> --%>
   		<c:forEach items="${yunweis }" var="yunwei">
   		 <a href="FrmYwManage.lookYunWeiDetails?operateId_=${yunwei.items.operateId_ }">
          <div class="indmnity ">
			    <div class="indmnityDetail flexLayout border_b">
			    	<div class="indmnityImg"><img src="${yunwei.items.proZsImges_ }" alt="" class=""><div class="guizi">${yunwei.items.boxId_ }</div></div>
			    	<div class="indmnityMess">
			    		<div class="font14">${yunwei.items.proName_ }</div>
			    		<div class="font999 font12">上报人：<span class="font222">${yunwei.items.userName }</span></div>
			    		<div class="font999 font12">上报时间：<span class="font222"><fmt:formatDate value="${yunwei.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
			    	</div>
			    </div>
		   </div>
		   </a>
        </c:forEach>
      </div>
  <!--  <h2>补货单</h2>  -->
   <div class="yworder">
	   <c:forEach items="${addGoods }" var="bh">
		   <a href="FrmYwManage.lookBuHuoDetails?operateId_=${bh.items.operateId_ }">
		      <div class="indmnity ">
				    <div class="indmnityDetail flexLayout border_b">
				    	<div class="indmnityImg"><img src="${bh.items.proZsImges_ }" alt="" class="border_0"></div>
				    	<div class="indmnityMess">
				    		<div class="font14">${bh.items.proName_ }</div>
				    		<div class="font999 font12">上报人：<span class="font222">${bh.items.userName }</span><div class="guizi">${yunwei.items.boxId_ }</div></div>
				    		<div class="font999 font12">上报时间：<span class="font222"><fmt:formatDate value="${bh.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
				    	</div>
				    </div>
			   </div>
		    </a>
		</c:forEach>
	  </div>
	   
     <%--  <c:forEach items="${addGoods }" var="bh">
        <a href="FrmYwManage.lookBuHuoDetails?operateId_=${bh.items.operateId_ }">
          <p>${bh.items.boxId_ }</p>
          <p><img alt="" src="${bh.items.proZsImges_ }"></p>
          <p>${bh.items.proName_ }</p>
          <p>${bh.items.userName }</p>
          <p>
            <fmt:formatDate value="${bh.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
          </p>
        </a>
      </c:forEach> --%>
      <!-- <h2>调货单</h2>  -->
      <div class="yworder">
	      <c:forEach items="${diaohuos }" var="dh">
		       <a href="FrmYwManage.lookDiaoHuoDetails?operateId_=${dh.items.operateId_ }">
			      <div class="indmnity">
					    <div class="indmnityDetail flexLayout border_b">
					    	<div class="indmnityImg"><img src="${dh.items.proZsImges_ }" alt="" class="border_0"><div class="guizi">${dh.items.boxId_ }</div></div>
					    	<div class="indmnityMess">
					    		<div class="font14">${dh.items.proName_ }</div>
					    		<div class="font999 font12">上报人：<span class="font222">${dh.items.userName }</span></div>
					    		<div class="font999 font12">上报时间：<span class="font222"><fmt:formatDate value="${dh.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
					    	</div>
					    </div>
				</div>
			</a>
		</c:forEach>
	</div>  
     <%--  <h2>调货单</h2> 
        <c:forEach items="${diaohuos }" var="dh">
          <a href="FrmYwManage.lookDiaoHuoDetails?operateId_=${dh.items.operateId_ }">
            <p>${dh.items.boxId_ }</p>
            <p><img alt="" src="${dh.items.proZsImges_ }"></p>
            <p>${dh.items.proName_ }</p>
            <p>${dh.items.userName }</p>
            <p>
              <fmt:formatDate value="${dh.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>
          </a> 
        </c:forEach>--%>
     
      <!--  <h2>赔付单</h2>  -->
      <div class="yworder">
	      <div class="indmnity ">
				    <div class="indmnityDetail flexLayout border_b">
				    	<div class="indmnityImg"><img src="${cdn }/img/1.jpg"><div class="guizi">A01</div></div>
				    	<div class="indmnityMess">
				    		<div class="font14">佳能750D单反相机</div>
				    		<div class="font999 font12">上报人：<span class="font222">￥200</span></div>
				    		<div class="font999 font12">上报时间：<span class="font222">￥200</span></div>
				    	</div>
				    </div>
			   </div>
	      </div>
     </div>
   
   
   
      </div>
       <%--  <c:forEach items="${yunweis }" var="yunwei">
          <a href="FrmYwManage.lookYunWeiDetails?operateId_=${yunwei.items.operateId_ }">
             <p>${yunwei.items.boxId_ }</p>
            <p>
                <img alt="" src="${yunwei.items.proZsImges_ }">
            </p>
            <p>${yunwei.items.proName_ }</p>
            <p>${yunwei.items.userName }</p>
            <p>
              <fmt:formatDate value="${yunwei.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>
          </a>
        </c:forEach>
      </div> --%>
      
 
     <%-- <div class="yworder">
      <h2>调货单</h2> 
        <c:forEach items="${diaohuos }" var="dh">
          <a href="FrmYwManage.lookDiaoHuoDetails?operateId_=${dh.items.operateId_ }">
            <p>${dh.items.boxId_ }</p>
            <p><img alt="" src="${dh.items.proZsImges_ }"></p>
            <p>${dh.items.proName_ }</p>
            <p>${dh.items.userName }</p>
            <p>
              <fmt:formatDate value="${dh.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>
          </a>
        </c:forEach>
     </div> --%>
    
</div>
<script type="text/javascript">
$(".yworder").hide();
$(".yworder").eq(0).show();
$("body").on("click", ".nav_bar4 li",function(){
  $(this).addClass('isActive').siblings().removeClass('isActive');
  $(".yworder").eq($(this).index()).show().siblings().hide();
  
})

</script>
</body>
</html>