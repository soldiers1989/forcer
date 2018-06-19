<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../../files/common.css">
    <link rel="stylesheet" href="../../css/online_store.css">
    <script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>   
    <title>一启享</title>
 <style>
   .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    }
</style>
</head>
<body>

<!-- 头部 -->
<div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
</div>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">商品评价</div>
    <!-- <a class="more" href="#">设置</a> -->
</div>
<div id="mat"></div>

<!-- 评价等级切换 -->
<div class="evaluate_style">
    <ul class="evaluate_style_num flexLayout">
  		<li id="evaluate_all" class="${evaLevel_=='0'||evaLevel_==null?'evaluate_active':''}"><a href="FrmWeiPro.queryProEvaluate?evaLevel_=0&proId_=${proId_ }">全部(${sum })</a> </li>
		<li id="evaluate_nice" class="${evaLevel_=='1'?'evaluate_active':''}"><a href="FrmWeiPro.queryProEvaluate?evaLevel_=1&proId_=${proId_ }">好评(${praise })</a></li>
		<li id="evaluate_dedium" class="${evaLevel_=='2'?'evaluate_active':''}"><a href="FrmWeiPro.queryProEvaluate?evaLevel_=2&proId_=${proId_ }">中评(${average })</a></li>
		<li id="evaluate_bad" class="${evaLevel_=='3'?'evaluate_active':''}"><a href="FrmWeiPro.queryProEvaluate?evaLevel_=3&proId_=${proId_ }">差评(${badReview })</a></li>       
    </ul>
</div>
<c:if test="${empty value}">
 	<div  class="no_content">
		<img alt="" src="../../img/zwsj.png">
	 </div>
</c:if>
<!-- 商品评价详情 -->
<c:if test="${!empty value}">
<c:forEach items="${value }" var="value">
<div class="evaluate_message mb_10">
    <div class="evaluateUser_message flexLayout">
        <div class="evaluateUser_img"><img src="../../img/1.jpg" alt=""></div>
        <div class="evaluateUser_basic">
            <div class="evaluateUser_name">
            	<c:if test="${value.items.evaState_==0 }">匿名</c:if>
				<c:if test="${value.items.evaState_==1 }">${value.items.UserId_}</c:if>
            </div>
        </div>
        <div class="evaluateUser_grade">
            <ul class="evaluateUser_heart">
                <li>
                    <img src="../../img/heartA.png" alt="">
                    <img src="../../img/heartB.png" class="listImg" alt="">
                </li>
                <li>
                    <img src="../../img/heartA.png" alt="">
                    <img src="../../img/heartB.png" class="listImg" alt="">
                </li>
                <li>
                    <img src="../../img/heartA.png" alt="">
                    <img src="../../img/heartB.png" class="listImg" alt="">
                </li>
                <li>
                    <img src="../../img/heartA.png" alt="">
                    <img src="../../img/heartB.png" class="listImg" alt="">
                </li>
                <li>
                    <img src="../../img/heartA.png" alt="">
                    <img src="../../img/heartB.png" class="listImg" alt="">
                </li>
            </ul>
            <div class="evaluateUser_num">
           	 	<span class="evaluateUser_specificNum">
           	 		
					<c:if test="${value.items.evaLevel_==1 }">1分</c:if>
					<c:if test="${value.items.evaLevel_==2 }">2分</c:if>
					<c:if test="${value.items.evaLevel_==3 }">3分</c:if>
					<c:if test="${value.items.evaLevel_==4 }">4分</c:if>
					<c:if test="${value.items.evaLevel_==5 }">5分</c:if>
           	 	</span>
            </div>
        </div>
    </div>
    <a href="#" class="evaluateUser_goodsName">${value.items.proName_ }</a>
    <div class="evaluate_content">${value.items.evaContent_ }</div>
    <!-- 商品评价图片 -->
    <ul class="evaluate_img flexLayout">
    <c:forEach items="${value.items.imgPath_ }" var="img">
		<li><img alt="" src="${img}"></li>
	</c:forEach>    
    </ul>
    <div class="rent_message flexLayout">
        <div class="rent_time"><span>租用时间：</span>${value.items.payTime_ }</div>
        <div class="evaluate_praise">
            <img src="../../img/praise.png" alt="">
            <span>20</span>
        </div>
    </div>
</div>
</c:forEach>
</c:if>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script>

/* 每次刷新页面，默认选中评价等级，替换参数和值即可 */
/*  $(document).ready(function(){
	 var id;
	var flag = '${falg}';	
	 if(flag == 0){
		id = "evaluate_all";
	}else if(flag == 1){
		id = "evaluate_nice";
	}else if(flag == 2){
		id = "evaluate_medium";
	}else if(flag == 3){
		id = "evaluate_bad";
	}else{
		id = "evaluate_all";
	}
	 console.log(id);
	  $("#" + id).addClass("evaluate_active").show();
	
     $("#" + id).siblings().removeClass("evaluate_active");  
});  */

/* 根据分数显示数量 */
 $(document).ready(function(){


 }); 

    $(".evaluate_style_num").on("click","li",function(){
        $(this).addClass("evaluate_active").siblings().removeClass("evaluate_active");
    });
    $(function(){
        var heartNum = 3;
        $(".evaluateUser_heart li").each(function(index,e){
            if(index < heartNum) {
                $(this).addClass("heart_active").prevAll().addClass("heart_active");
                $(this).parent().siblings(".evaluateUser_num").find($(".evaluateUser_specificNum")).html(heartNum)
            }
        });
//        $(".evaluateUser_heart li").click(function(){
//            $(this).addClass("heart_active").prevAll().addClass("heart_active");
//            $(this).nextAll().removeClass("heart_active");
//            var n=$(".evaluateUser_heart li").index(this);
//            $(".evaluateUser_specificNum").html(n+1)
    });
//    })
</script>
</body>
</html>


	<%-- 		<ul>
				<li><a href="FrmWeiPro.queryProEvaluate?evaLevel_=0">全部(${sum })</a> </li>
				<li><a href="FrmWeiPro.queryProEvaluate?evaLevel_=1">好评(${praise })</a></li>
				<li><a href="FrmWeiPro.queryProEvaluate?evaLevel_=2">中评(${average })</a></li>
				<li><a href="FrmWeiPro.queryProEvaluate?evaLevel_=3">差评(${badReview })</a></li>
			</ul>
		</div>	
		<c:forEach items="${value }" var="value">
			<div>
				<p>
					<c:if test="${value.items.evaState_==0 }">匿名</c:if>
					<c:if test="${value.items.evaState_==1 }">${value.items.UserId_}</c:if>
					<c:if test="${value.items.evaLevel_==1 }">1分</c:if>
					<c:if test="${value.items.evaLevel_==2 }">2分</c:if>
					<c:if test="${value.items.evaLevel_==3 }">3分</c:if>
					<c:if test="${value.items.evaLevel_==4 }">4分</c:if>
					<c:if test="${value.items.evaLevel_==5 }">5分</c:if>
				</p>
				<p>${value.items.proName_ }</p>
				<p>${value.items.evaContent_ }</p>
				<c:forEach items="${value.items.imgPath_ }" var="img">
						<img alt="" src="${img}">
				</c:forEach>
				<p>购买于：${value.items.payTime_ }</p>
			</div>
				
		</c:forEach> --%>
