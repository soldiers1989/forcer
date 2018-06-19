<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cdn }/files/common.css">
    <link rel="stylesheet" href="${cdn }/css/maintenance.css">
    <link rel="stylesheet" href="${cdn }/files/swiper/swiper-3.3.1.min.css"/>
    <link href="http://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${cdn }/city/css/city-picker.css" rel="stylesheet" type="text/css" />
    <title>一启享</title>
    <style>
        .swiper-container{
            height: 3.431rem;
            background-color: white;
        }
        .swiper-slide {
            line-height: 3.431rem;
            text-align: center;
        }
        .myAddress_details{
        	padding-right:0;
        }
         #myAddress .city-picker-span{
	        border-bottom: 0
	    }
	    #myAddress .form-group{
	        margin-bottom: 0;
	    }
	    #myAddress .container{
	        margin: .17rem 0;
	        position: absolute;
	        right: 0.17rem;
	        width: 75%;
	        font-size:.222rem;
	    }
	    .attribute_list li a{
	    	width:auto;
	    }
    </style>
   
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">柜组属性</div>
    <div class="more edit">编辑</div>
    <div class="more save">保存</div>
</div>
<div class="main_content" id="cabinetGroup_attribute">
    <div id="mat"></div>
    <div class="cabinetGroup cabinetGroup_edit">
    	<input type="hidden" id="id_" value="${cabinet.items.id_ }">
    	<input type="hidden" id="managerId_" value="${cabinet.items.managerId_ }">
        <ul class="attribute_list">
            <li>
                <span class="attribute_hint">柜组名称：</span>
                <span>${cabinet.items.name_ }</span>
            </li>
            <li>
                <span class="attribute_hint">柜组编号：</span>
                <span>${cabinet.items.id_ }</span>
            </li>
            <li>
                <a href="#" class="flexLayout">
                    <span class="attribute_hint">柜组二维码：</span>
                    <div>
                        <span class="text-gold mr_10">查看</span>
                        <img src="../../img/rightArrows.png" alt="">
                    </div>
                </a>
            </li>
            <li>
            <div class="">
            
        <div class="myAddress_details flexLayout" id="myAddress">
          <span class="myAddress_hint" style="font-size:.222rem;color:#808080">柜组区域</span>
           <!--  <span class=" attribute_hint" style="font-size:.222rem">柜组区域</span> -->
            <div class="container">
                <div class="docs-methods" name="adr">
                    <div id="distpicker">
                        <div class="form-group">
                            <div style="position: relative;">
                                <input id="city-picker3" name="city-picker3" class="form-control" readonly type="text" value="${cabinet.items.ctName_ }" data-toggle="city-picker">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="width: .17rem;"><img alt="" src="${cdn }/img/rightArrows.png"> </div>
        </div>
    </div>
               <%--  <a href="#" class="flexLayout">
                    <span class="attribute_hint">柜组区域：</span>
                    
                     <span style="width: 75%;">${cabinet.items.ctName_ }</span>
                    <div><img src="../../img/rightArrows.png" alt=""></div> 
                </a> --%>
            </li>
            <li>
                <span class="attribute_hint">柜组GPS位置：</span>
                <span>${cabinet.items.address_ }</span>
            </li>
            <li>
                <span class="attribute_hint">配置人员&电话：</span>
                <span class="mr_10">张大大</span>
                <span>${cabinet.items.managerId_ }</span>
            </li>
            <li>
                <span class="attribute_hint">柜组组合：</span>
                <span class="mr_10">1+2</span>
                <span class="mr_10">1+3</span>
                <span class="mr_10">1+4</span>
                <span>1+5</span>
            </li>
        </ul>
        <div class="cabinet_sum flexLayout">
            <span class="attribute_hint">柜组箱数据汇总：</span>
            <div>
                <span class="mr_10">(租)大5个</span>
                <span class="mr_10">(租)中5个</span>
                <span class="mr_10">(租)小5个</span>
                <span>公益箱2个</span>
            </div>
        </div>
        <ul class="cabinetGoods_list mt_15 clearfix">
    	<c:forEach var="box" items="${boxCount}">
            <li>
                <a href="#">
                    <div class="cabinetGoods_img"><img src="../../img/3.jpg" alt=""></div>
                    <div class="cabinetGoods_num">${box.items.boxId_ }</div>
                </a>
            </li>
            <!-- <li>
                <a href="#">
                    <div class="cabinetGoods_img"><img src="../../img/3.jpg" alt=""></div>
                    <div class="cabinetGoods_num">A01</div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div class="cabinetGoods_img"><img src="../../img/3.jpg" alt=""></div>
                    <div class="cabinetGoods_num">A01</div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div class="cabinetGoods_img"><img src="../../img/3.jpg" alt=""></div>
                    <div class="cabinetGoods_num">A01</div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div class="cabinetGoods_img"><img src="../../img/3.jpg" alt=""></div>
                    <div class="cabinetGoods_num">A01</div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div class="cabinetGoods_img"><img src="../../img/3.jpg" alt=""></div>
                    <div class="cabinetGoods_num">A01</div>
                </a>
            </li> -->
        </c:forEach>
        </ul>
    </div>
    <div class="cabinetGroup cabinetGroup_save" style="display: none;">
        <!--轮播图-->
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide"><img src="../../img/1.jpg" alt=""></div>
                <div class="swiper-slide"><img src="../../img/2.jpg" alt=""></div>
                <div class="swiper-slide"><img src="../../img/3.jpg" alt=""></div>
                <div class="swiper-slide"><img src="../../img/4.jpg" alt=""></div>
            </div>
            <!--如果需要分页器-->
            <div class="swiper-pagination"></div>
            <!--如果需要导航按钮-->
            <!--<div class="swiper-button-prev"></div>-->
            <!--<div class="swiper-button-next"></div>-->
        </div>
        <ul class="attribute_list">
            <li>
                <span class="attribute_hint">柜组名称：</span>
                <span>${cabinet.items.name_ }</span>
            </li>
            <li>
                <span class="attribute_hint">柜组编号：</span>
                <span>${cabinet.items.id_ }</span>
            </li>
            <li>
                <span class="attribute_hint">柜组大小：</span>
                <span>长150m*</span>
                <span>宽150m*</span>
                <span>高150m</span>
            </li>
            <li>
                <span class="attribute_hint">柜组型号：</span>
                <span>中</span>
            </li>
            <li>
                <span class="attribute_hint">负责人：</span>
                <span>张大大</span>
            </li>
            <li>
                <span class="attribute_hint">启用状态：</span>
                <span>开</span>
            </li>
            <li class="flexLayout">
                <span class="attribute_hint">柜组用途：</span>
                <div>
                    <select>
                        <option value="">租赁柜组</option>
                        <option value="">公益柜组</option>
                    </select>
                </div>
            </li>
        </ul>
        <div class="cabinet_sum flexLayout">
            <span class="attribute_hint">柜组地址：</span>
            <div>${cabinet.items.address_ }</div>
        </div>
    </div>
</div>
<script src="${cdn }/city/js/jquery.js"></script>
    <script src="${cdn }/city/js/bootstrap.js"></script>
    <script src="${cdn }/city/js/city-picker.data.js"></script>
    <script src="${cdn }/city/js/city-picker.js"></script>
    <script src="${cdn }/city/js/main.js"></script>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script src="../../files/swiper/swiper-3.3.1.min.js"></script>
<script src="../../js/modal.js"></script>
<script src="../../js/common.js"></script>
<script>
    var mySwiper=new Swiper(".swiper-container",{
        direction:"horizontal",
        loop:true,
        autoplay:2000,
        autoplayDisableOnInteraction:false,

        pagination:".swiper-pagination",
        paginationClickable:true,

        prevButton:".swiper-button-prev",
        nextButton:".swiper-button-next"
    });
</script>
<script>
    // 柜组弹窗
    $("body").on("click",".cabinetGoods_list li a",function(){
        modalBox("A01","1");
    });

    //  编辑和保存页面切换
    $("body").on("click",".edit",function(){
        $(this).hide().next().show();
        $(".cabinetGroup_edit").hide().next().show();
    });
    $("body").on("click",".save",function(){
        $(this).hide().prev().show();
        $(".cabinetGroup_save").hide().prev().show();
    })

   	function addBox() {
		if ($("#num_").val() == null || $("#num_").val() == "") {
			alert("编号不能为空！");
			return;
		}
		if ($("#type_").val() == null || $("#type_").val() == "") {
			alert("类型不能为空！");
			return;
		}
		if ($("#size_").val() == null || $("#size_").val() == ""){
			alert("大小不能为空！");
			return;
		}
		var num_ = $("#num_").val();
		var type_ = $("#type_").val();
		var size_ = $("#size_").val();
		var id_ = $("#id_").val();
		var managerId_ = $("#managerId_").val();
		addBox(id_, num_, type_, size_, managerId_);
		return;
	}
</script>
<script type="text/javascript" src="${cdn}/js/box/box.js"></script>
</body>
</html>