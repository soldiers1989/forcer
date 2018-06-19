<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页轮播图管理</title>
<style>
	.tableWidth{
		width:10%;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">添加轮播图</span>
    </div>
   <!--  <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div> -->

    <div role="grid" style="margin-top:40px;">
        <div class="table">
        
        <a href="FrmAdminHomeAdManage.toInsertHomeAd" class="min-col" style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">添加</a>
		<input type="hidden" name="imgId_" value="${value.items.imgId_ }">
            <table class="tbl" style="margin-top:5px">
            <caption align="top" style="font-size:20px;margin-bottom:20px">公众号轮播图维护列表</caption>
                <thead>
                   <tr>
                   		<th class="t-head tc tableWidth" >编号</td>
					    <th class="t-head tc tableWidth" >创建人</td>
				   		<th class="t-head tc tableWidth">创建时间</td>
					 	<th class="t-head tc tableWidth">图片</th>
					 	<th class="t-head tc tableWidth" >链接路径</td>
					 	<th class="t-head tc tableWidth" colspan="2">操作</th>
					</tr>
                </thead>
                <tbody class="t-body tc">
                <%-- <c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                <c:if test="${not empty values}"></c:if> --%> 
               <%--  <c:forEach items="${value}" var="lists" > 
               		 <p>${lists.items.UID_ }</p>
               		 <c:forEach items="${lists.items.imgPath_}" var="img">
               		 		<img src="${img }">
               		 <p>${lists.items.imgSrc_ }</p>
               		 </c:forEach>  
				</c:forEach> --%>
				<c:forEach items="${values }" var="lists">
                 	<tr> 
                 	<td>${lists.items.UID_ }</td>  
 					<td>${lists.items.createUser_ }</td> 
 					<td> 
 					${lists.items.createDate_ }
 						<%-- <fmt:formatDate value="${lists.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>  --%>
 					</td> 
					
                	 
					<td style="text-align: center;"> 
					<c:forEach items="${lists.items.imgPath_ }" var="img" > 
 						<img alt="" src="${img}" style="width:117px;"> 
 					</c:forEach> 
					</td>
 					<td>${lists.items.imgSrc_ }</td>  
 					<td><a class="btn_style" href="FrmAdminHomeAdManage.upLunBoAd?UID_=${lists.items.UID_}">修改</a></td> 
 					<%-- <td><a href="FrmAdminHomeAdManage.delHomeAd?imgId_=${lists.items.imgId_}">删除</a></td>  --%>
 					<td><a class="btn_style" href="javascript:if(confirm('您确定刪除吗?'))location='FrmAdminHomeAdManage.delHomeAd?imgId_=${lists.items.imgId_ }';">删除</a></td> 
				</tr> 
				</c:forEach>
                </tbody>
            </table>
            
			<table class="tbl" style="margin-top:100px;">
				<caption align="top" style="font-size:20px;margin-bottom:20px">中控屏视频维护列表</caption>
				<tbody>
					<tr>
						<tr>
							<th class="t-head tc">ID</th>
						    <th class="t-head tc">创建人</th>
						    <th class="t-head tc">创建时间</th>
						    <th class="t-head tc">视频</th>
						    <th class="t-head tc">操作</th>					  
						</tr>
                </tbody>
                <tbody class="t-body tc">
                <%-- <c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                <c:if test="${not empty values}"></c:if> --%>
		           <c:forEach items="${video}" var="video_list">
		           <input type="hidden" name="UID_" value="${video_list.items.UID_}">
		           <tr> 
		           	   <td>${video_list.items.imgId_ }</td>
		               <td>${video_list.items.createUser_ }</td>
		               <td>
		               ${video_list.items.createDate_ }
		               <%-- 	<fmt:formatDate value="${video_list.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
		               </td>
		               <td style="width:40%;"><video alt="" src="${video_list.items.vedioId_ }" controls="controls" style="width:100%"></video></td>
		               <td><a href="FrmAdminHomeAdManage.toupdateHomeAd?UID_=${video_list.items.UID_}" class="btn_style">修改</a></td>	               
		           </tr>
		           </c:forEach>
                </tbody>
            </table>
            
            <form action="" id="subForm"> 
			<table class="tbl" style="margin-top:100px;">
				<caption align="top" style="font-size:20px;margin-bottom:20px">智能柜轮播维护</caption>
				<tbody>
					<tr>
						<th class="t-head tc">序号</th>
					    <th class="t-head tc">柜子编号</th>
					    <th class="t-head tc">柜子轮播图</th>
					    <th class="t-head tc">操作</th>					  
					</tr>
                </tbody>
                <tbody class="t-body tc">
	                <c:forEach items="${cabinetId}" var="cabinetId" varStatus="status">
	                <tr>
							<td>${status.index + 1}</td>
						    <td>${cabinetId.items.id_}</td>
						    <c:if test="${empty cabinetId.items.imgPath_}">
						    	<td>暂无展示图片</td>
						    </c:if>
						    <c:if test="${!empty cabinetId.items.imgPath_}">
						    	<td><img alt="" src="${cabinetId.items.imgPath_}" height="160px" width="200px" ></td>
						    </c:if>
						    <td>
						    	<a href="FrmCabinetAdImg.upLunBoAd?id_=${cabinetId.items.id_}" class="btn_style">修改</a>
						    </td>				  
						</tr>
	                </c:forEach>
				</tbody>
            </table>
            </form>
              <c:if test="${pages.count >= 1}">  
      		  <div class="foot-page" align="center">
            	<a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                href="javascript:page(${pages.prior});">上一页</a> <a
                href="javascript:page(${pages.next});">下一页</a> <a
                href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if>
        </div>
    </div>
 </div>
<script type="text/javascript" src="../../admin/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript">
function page(pageno) {
    $("#subForm").append(
            '<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#subForm").submit();
}
</script>






	<%-- <div>
		<span>添加轮播图</span>
	</div>
	<hr>
	<div class="fanhui">
		<a href="javascript:window.history.go(-1);" class="min-col aButton">返回</a>
	</div>
	<a href="FrmAdminHomeAdManage.toInsertHomeAd">添加</a>
	<form action="">
		<input type="hidden" name="imgId_" value="${value.items.imgId_ }">
		<table>
			<tr>
			 	<td>创建人</td>
			 	<td>创建时间</td>
			 	<td>图片</td>
			 	<td>操作</td>
			 </tr>
			<tr>
				<td>${value.items.createUser_ }</td>
				<td>
					<fmt:formatDate value="${value.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
				<c:forEach items="${value.items.imgPath_ }" var="img">
				<img alt="" src="${img}">
				</c:forEach>
				</td>
				<td><a href="FrmAdminHomeAdManage.delHomeAd?imgId_=${value.items.imgId_ }">删除</a></td>
				<td><a href="javascript:if(confirm('您确定刪除吗?'))location='FrmAdminHomeAdManage.delHomeAd?imgId_=${value.items.imgId_ }';">删除</a></td>
			</tr>
		</table>
		
		  <hr color="blue" width="%60%" style="...."/>
           <input type="hidden" name="video" value="${video.items.UID_}">
        <table>
            <tr><td>创建人</td><td>创建时间</td><td>视频</td><td>操作</td><td>ID</td>
            </tr>
            <tr>
                <td>${video.items.createUser_ }</td>
                <td>${video.items.createDate_ }</td>
                <td>
                <video alt="" src="${video.items.vedioId_ }" controls></video>
                </td>
                <td><a href="FrmAdminHomeAdManage.toupdateHomeAd">修改</a></td>
                <td>${video.items.imgId_ }</td>
            </tr>
        </table>
	</form> --%>


</body>
</html>