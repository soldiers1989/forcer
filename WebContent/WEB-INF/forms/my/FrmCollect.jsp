<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<link rel="stylesheet" href="${cdn }/css/order.css">
<title>一启享</title>
<style>
    #fristName_{
            border: 0; 
            background: transparent;
    }
    .header1 .more{
        width: .5rem;
        text-align: right;
    }
    .header1 input{
        background-color: transparent;
        border: 0;
        color: #ffffff;
        -webkit-appearance: button;
        width: 1.3rem;
    }
    .head_title img{
        width: 0.3rem;
        height: .17rem;
        margin-left: .1rem;
    }
    .head_title.rotateActive img{
        transform: rotate(-180deg);
        /*transition: all .2s linear;*/
    }
    .head_title select option{
        /*background-color: #88213d;*/
        background-color: #00000085;
    }
    .homepage_commodity_name {
        padding: .17rem .255rem;
    }
    .homepage_commodity_img {
        height: 1.8rem;
        width: 100%;
    }
    .homepage_commodity_img img {
        width: 100%;
        height: 100%;
    }
    .indmnityDetail .indmnityImg {
    width: 35%;
}
.indmnityDetail .indmnityImg img{
	width:100%;
	height:100%:
}
.homepage_commodity_img{
	height:1.5rem;
}
.cabinet_address{
    padding: .05rem.1rem;
    line-height:normal !important;
    text-align:center;
}
.indmnityDetail .indmnityImg img{
	border:none;
}
.indmnityDetail .indmnitySelect{
	width:10%;
	margin-top: .7rem;
}
.titleDetail{
	width: 100%;
    font-size: .239rem;
}
.anonymity{
	padding:0;
}
.indmnity{
	margin-top:0;
	margin-bottom:.2rem;
    padding-bottom:.1rem; 
}
.edit{
	float:right;
}
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class=" font18">
     <div class="head_title font18">收藏商品</div>
       <!--  <input type="text" value="我的收藏" readonly="readonly"/> -->
        <!-- <span id="delete">删除</span> -->
        <a class="more" href="#">编辑</a>
    </div>
</div>
<div class="main_content" id="rent_list">
    <div id="mat"></div>
    <c:if test="${ empty collects}">
        <div class="noCard"><img src="${cdn }/img/collectNone.png" alt=""></div>
    	<div class="noCard_tishi">您的收藏夹为空</div>
        </c:if>
    <c:if test="${not empty collects}">
    <div class="no_content">
            <%-- <ul class="online_commodityList clearfix">
            <c:forEach items="${collects}" var="collect">
                <li>
                    <a href="FrmWeiPro?zhuCode_=${collect.items.zhuCode_}">
                        <div class="homepage_commodity_img">
                        <img src="${collect.items.proZsImges_ }" alt="">
                        </div>
                        <div class="cabinet_address">
                        ${collect.items.communityName_}${collect.items.boxId_}号箱子
                        </div>
                        <div class="homepage_commodity_name">
                        ${collect.items.proName_ }
                        </div>
                        <c:if test="${collect.items.isDiscount_ eq 0 }">
                            <div class="homepage_commodity_price"><span class="red">￥${collect.items.dayRentMoney_ }</span></div>
                        </c:if>
                        <c:if test="${collect.items.isDiscount_ eq 1 }">
                            <div class="homepage_commodity_price"><span class="red">￥${collect.items.discountPrice_ }</span><span class="old_price">￥${collect.items.dayRentMoney_ }</span></div>
                        </c:if>
                        <div class="cash_pledge text-gold font10 tl pl_15"><span>押金：￥</span>${collect.items.cashPledge_ }</div>
                    </a>
                    <input type="checkbox" name="sel" class="selt" data-key="${collect.items.proId_}">
                </li>
                 </c:forEach>
            </ul> --%>
                <c:forEach items="${collects}" var="collect">
                <div class="indmnity " >
			    	<div class="indmnityTitle border_b flexLayout anonymity">
			    		<div class="anonymity_img selectAll">
			    			 <img src="../../img/successA.png" alt="">
			           		 <img src="../../img/successB.png" alt="" class="listImg">
			    		</div>
			            <div class="titleDetail">
			    			<span class="addr">${collect.items.proName_ }</span>
							<span class="way">寄送到柜</span>
						</div>
			    	</div>
				    <div class="indmnityDetail flexLayout anonymity">
				   		<div class="indmnitySelect anonymity_img">
				            <img src="../../img/successA.png" alt="">
				            <img src="../../img/successB.png" alt="" class="listImg">
				   		</div>
				   		<a href="FrmWeiPro?zhuCode_=${collect.items.zhuCode_}" class="flexLayout">
					    	<div class="indmnityImg">
						    	 <div class="homepage_commodity_img">
		                        <img src="${collect.items.proZsImges_ }" alt="">
		                        </div>
		                        <div class="cabinet_address">
		                        ${collect.items.communityName_}${collect.items.boxId_}号箱子
		                        </div>
					    	<%-- <img src="${collect.items.proZsImges_ }"><div class="box font137">${details.items.communityName_ }</div> --%>
					    	</div>
					    	<div class="indmnityMess">
					    		<div class="font14">${collect.items.proName_ }</div>
					    		<div class="mon">
					    			<c:if test="${collect.items.isDiscount_ eq 0 }">
			                            <div class="homepage_commodity_price"><span class="red">￥${collect.items.dayRentMoney_ }</span></div>
			                        </c:if>
			                        <c:if test="${collect.items.isDiscount_ eq 1 }">
			                            <div class="homepage_commodity_price"><span class="red">￥${collect.items.discountPrice_ }</span><span class="old_price">￥${collect.items.dayRentMoney_ }</span></div>
			                        </c:if>
			                    </div>
					    		<div class="yajin">押金<span>${collect.items.cashPledge_ }</span></div>
					    	</div>
				    	<%-- <div class="indmnityMore"><img alt="" src="${cdn }/img/right.png"></div> --%>
				    	 </a>
				    </div>
			   </div>
			   </c:forEach>
    </div>
     </c:if> 
    <c:if test="${!empty msg}">
        <div style="color: red;" class="msg">${msg}</div>
    </c:if>
</div>
 
</body>
<script type="text/javascript">
$(function(){
    //批量删除
    $("#delete").click(function(){
        var proIds = "";
        $(".selt").each(function(){
            if($(this).prop("checked")){
                proIds += $(this).attr('data-key')+","; 
            }
        });
        if(proIds==""){
            alert("您没有选中任何一个要删除的收藏！");
        }else{
            del(proIds);
        }
    });
    function del(proIds){
        $.ajax({
            url: "FrmCollect.delete",
            type: "post",
            dataType: "json",
            data: {
                "proIds":proIds
            },
            success: function(data){
                if(data.status =='success'){
                    alert(data.msg);
                    window.location.href="FrmCollect";
                }else{
                    alert(data.msg);
                    return;
                }
            },
            error: function(){
                alert("删除失败，请稍后再试!");
            }
        });
    }
    
    $("body").on("click",".anonymity .anonymity_img",function(){
    	if($(".more").text()=="删除"){
	    	var attr = $(this).attr("class").split(" ")[1];
	    	if(attr == "selectAll"){
	    		if($(this).hasClass("imgActive")){
	                $(this).parent().parent().find(".anonymity_img").removeClass("imgActive");
	            }else{
	            	$(this).parent().parent().find(".anonymity_img").addClass("imgActive");
	            }
	    	}
	    	else{   		
	    		if($(this).hasClass("imgActive")){
	                $(this).removeClass("imgActive");
	            }else{
	                $(this).addClass("imgActive");
	            }
	    	}
    	}
       /*  if($(this).hasClass("imgActive")){
            $(this).removeClass("imgActive");
        }else{
            $(this).addClass("imgActive");
        } */
    });
    $(".more").on("click",function(){
    	var text = $(this).text();
    	if(text == "删除"){
    		$(this).text("编辑");
    		$(".anonymity_img").removeClass("imgActive");
    	}
    	if(text == "编辑"){
    		$(this).text("删除");
    		$(".selectAll").addClass("imgActive")
    	}
    })
})
</script>
</html>