<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../jspf/head1.jspf"%>
<style>
    .healthlist-box{
        overflow: hidden;
    }
    .healthlist-box .h-tab{
        width: 100%;
        overflow-x: auto;
        overflow-y: hidden;
        height: .8rem;
        text-align: center;
        line-height: .8rem;
    }
    .healthlist-box .h-tab ul li{
        float: left;
        height: .7rem;
        line-height: .8rem;
        padding: 0 .35rem;
        background: #fff;
        border-bottom: 2px solid #fff;
    }
    .healthlist-box .h-tab li.curr{
        border-bottom: 2px solid #48b2bd;
    }
    .healthlist-box .h-tab li.curr a{
        color: #48b2bd;
    }
    .healthlist-box .h-tab ul li a{
        display: block;
    }
</style>
<%@include file="../jspf/head2.jspf"%>
	<div class="tc" style="margin-top: 1rem">
	    <img src="${cdn}/img/small/develop.png" style="width:2.8rem">
	    <p class="mt_10 cl-999" >敬请期待</p>
  </div>
</body>
</html>