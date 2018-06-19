<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link rel="stylesheet" href="${cdn }/css/common.css">
    <title>一启享</title>
    <style>
        ul{
            display: inline;
            width:100%;
            font-size:0.254rem;
           
        }
        .header2{
            background-color: white;
        }
        
	/*待配置柜组*/
	.space_line{
	    width: 100%;
	    height: 4px;
	}
	.cabinet_num{
	    width: 100%;
	    background-color: #00aba9;
	}
	.cabinet_num li{
	    width: 100%;
	    background-color: white;
	    margin-bottom: 1px;
	    padding: 0.246rem;
	    font-size:12px;
	    color:red;  
	}
	.cabinet_num li span:first-child{
	color:#666;
	}
	.cabinet_num li span:last-child{
	color:#222;
	}
    </style>
</head>
<body>
<div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">待配置柜组
    </div>
</div>

<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
    <!--分隔线-->
    <div class="space_line"></div>
   
   <!--待配置柜组显示-->
    <ul class="cabinet_num">
      	<c:forEach items="${cabinet }" var="cat" varStatus="status">
            	<li><a href="FrmMyCabinet.deployCabinet?id=${cat.items.id_}"><span>柜组编号：</span><span>${cat.items.id_ }</span></a></li>
            </c:forEach>
            <li >
               <span>柜组编号：</span><span>4623236</span>
            </li>
            <li >
                <span>柜组编号：</span><span>4623236</span>
            </li>
            <li >
                <span>柜组编号：</span><span>4623236</span>
            </li>
            <li >
                <span>柜组编号：</span><span>4623236</span>
            </li>
        </ul> 
</div>
</body>
</html>