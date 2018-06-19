<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
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
    .headSearch{
        background-color: transparent;
    }
    .headSearch img {
        position: absolute;
        left: 0.425rem;
        top: .255rem;
    }
    .headSearch input {
        width: 80%;
        border: 0;
        outline: none;
        height: 65%;
        background-color: white;
        border-radius: .34rem;
        padding-left: 0.6rem;
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        -ms-box-sizing: border-box;
        -o-box-sizing: border-box;
    }
    .no_result{
      height:100%;
      text-align: center;
      padding: .51rem 0;
      background-image:url('../../img/zwsj.png');
      background-position:center  1.5rem;
      background-repeat: no-repeat;
    }
    /* .no_result{
    	text-align: center;
    	padding: .51rem 0;
    } */
    .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    } 
    
</style>
</head>
<body>
<div class="header1">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">搜索</div>
</div>
<div id="mat2"></div>
 <form class="headSearch" style="top:.769rem;">
    <a id="searchIMG" class="search"><img src="../../img/search1.png" alt=""></a>
    <input type="text" class="searchBox font13"  id="searchText" placeholder="请输入要搜索的商品名称">
      <input type="hidden" id="lng" value="${lng}">
    <input type="hidden" id="lat" value="${lat}">
    <a class="searchBtn" id="searchBtn" style="float:none">搜索</a>
</form> 

</body>
<script type="text/javascript">
$("#searchIMG").on("click",function(){
	 var lng ="${lng}";
     var lat ="${lat}";
    var searchText = $("#searchText").val();
    window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
})
$("#searchBtn").on("click",function(){
	 var lng ="${lng}";searchBtn
     var lat ="${lat}";
    var searchText = $("#searchText").val();
    window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
})
</script>
</html>