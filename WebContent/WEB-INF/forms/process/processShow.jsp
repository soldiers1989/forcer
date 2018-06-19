<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" type="text/css" href="${cdn }/css/common.css">
    <link rel="stylesheet" type="text/css" href="${cdn }/css/user.css">
    <title>使用流程</title>
    <style>
       ul{
           display: inline;
       }
       ul li{
           float: left;
       }
    </style>
</head>
<body>
<div class="header">
<input type="hidden" value="${type }">
    <c:if test="${type == 'guide'}">
    	<a href="FrmGuideList.Guide" class="prev"></a>
    </c:if>
    <c:if test="${type != 'guide'}">
    	<a href="javascript:history.go(-1);" class="prev1"></a>
    </c:if>
        <div class="head_title font18">使用流程</div>
</div>
    <div class="main_content" id="manual">
        <div id="mat"></div>
        <div class="rent" >
            <div class="rent_detail">
                <div class="detail_text">租机流程</div>
                <ul>
                    <li>
                        <div class="rent_detail_ico">
                            <img class="rent_detail_img" src="${cdn }/img/commodity.png">
                            <div class="rent_detail_line"></div>
                        </div>
                        <div class="rent_detail_explain">挑选商品</div>
                    </li>

                    <li>
                        <div class="rent_detail_ico">
                            <img class="rent_detail_img" src="${cdn }/img/sign.png">
                            <div class="rent_detail_line"></div>
                        </div>
                        <div class="rent_detail_explain">选择租期</div>
                    </li>
                    <li>
                        <div class="rent_detail_ico">
                            <img class="rent_detail_img" src="${cdn }/img/pay.png">
                            <div class="rent_detail_line"></div>
                        </div>
                        <div class="rent_detail_explain">预付租金</div>
                    </li>
                    <li>
                        <div class="rent_detail_ico">
                            <img class="rent_detail_img" src="${cdn }/img/get.png">
                            <div class="rent_detail_line"></div>
                        </div>
                        <div class="rent_detail_explain">获取商品</div>
                    </li>
                    <li>
                        <div class="rent_detail_ico">
                            <img class="rent_detail_img" src="${cdn }/img/return.png">
                        </div>
                        <div class="rent_detail_explain">归还商品</div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="donation">
            <div class="donation_detail" >
                <div class="detail_text">捐赠流程</div>
                <ul>
                    <li>
                        <div class="donation_detail_ico">
                            <img class="donation_detail_img" src="${cdn }/img/love_donation.png">
                            <div class="donation_detail_line"></div>
                            <div class="donation_detail_explain">我要捐赠</div>
                        </div>
                    </li>

                    <li>
                        <div class="donation_detail_ico">
                           <img class="donation_detail_img" src="${cdn }/img/open.png">
                            <div class="donation_detail_line"></div>
                           <div class="donation_detail_explain">启享柜开启</div>
                        </div>
                    </li>

                    <li>
                        <div class="donation_detail_ico">
                           <img class="donation_detail_img" src="${cdn }/img/putinto.png">
                            <div class="donation_detail_line"></div>
                           <div class="donation_detail_explain">放置物品</div>
                        </div>
                    </li>
                    <li>
                        <div class="donation_detail_ico">
                        <img class="donation_detail_img" src="${cdn }/img/finish.png">
                        <div class="donation_detail_explain">点击完成</div>
                        </div>
                    </li>

                </ul>
            </div>
        </div>
        <div class="onlineRent">
            <div class="onlineRent_detail">
                <div class="detail_text">线上租赁流程</div>
                <ul>
                    <li>
                        <div class="onlineRent_detail_ico">
                            <img class="onlineRent_detail_img" src="${cdn }/img/commodity.png">
                            <div class="onlineRent_detail_line"></div>
                        </div>
                        <div class="onlineRent_detail_explain">挑选商品</div>
                    </li>

                    <li>
                        <div class="onlineRent_detail_ico">
                            <img class="onlineRent_detail_img" src="${cdn }/img/sign.png">
                            <div class="onlineRent_detail_line"></div>
                        </div>
                        <div class="onlineRent_detail_explain">选择租期</div>
                    </li>
                    <li>
                        <div class="onlineRent_detail_ico">
                            <img class="onlineRent_detail_img" src="${cdn }/img/pay.png">
                            <div class="onlineRent_detail_line"></div>
                        </div>
                        <div class="onlineRent_detail_explain">预付租金</div>
                    </li>
                    <li>
                        <div class="onlineRent_detail_ico">
                            <img class="onlineRent_detail_img" src="${cdn }/img/get.png">
                            <div class="onlineRent_detail_line"></div>
                        </div>
                        <div class="onlineRent_detail_explain">获取商品</div>
                    </li>
                    <li>
                        <div class="onlineRent_detail_ico">
                            <img class="onlineRent_detail_img" src="${cdn }/img/return.png">
                        </div>
                        <div class="onlineRent_detail_explain">归还商品</div>
                    </li>
                </ul>
            </div>
        </div>
    </div>

</div>

<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
</body>
</html>