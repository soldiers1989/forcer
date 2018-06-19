<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cdn }/files/common.css">
    <link rel="stylesheet" href="${cdn }/css/user.css">
    <title>捐赠说明</title>
    <style>   
    .donationExplain{
        width:6rem;
        height:9.475rem;
        text-align:left;
        padding:0.4rem 0.2rem 0.2rem 0.2rem;
        text-indent:25px
        }
    </style>
</head>

<body>

	<!-- 头部一一启享 -->
	<div class="header">
	    <a href="javascript:history.go(-1);" class="prev"></a>
	    <div class="head_title font18">一启享</div>
	</div>
	
	<!-- 头部捐赠说明 -->
	<div class="header2">
	    <a href="javascript:history.go(-1);" class="prev"></a>
	    <div class="head_title font18">捐赠说明</div>
	</div>
	
	<!-- 捐赠说明详情 -->
	<div class="main_content" id="manual">
	    <div id="mat2"></div>
	    <!--捐赠说明-->
	    <div class="donationExplain"> 
	     	<p>${explain.items.explain_ }</p>
	    </div>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>

</body>
</html>   
    