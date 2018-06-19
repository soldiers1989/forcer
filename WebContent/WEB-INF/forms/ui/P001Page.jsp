<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<style>
.hide{display:none;}
</style>

<%@include file="head2.jspf" %> 

<!--中间内容-->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20">
       <span class="min-col f16">${title}</span>
    </div>
    
    <div class="tab_box mr_20 mt_20 ml_20 ui-bd-b">
	    <div class="tab_name">
	
	        <span class="curr"><a href="">用户报表</a></span>
	        <span><a href="">统计</a></span>
	        <span><a href="" class="last">交易记录</a></span>
	
	    </div>
	    <div class="sel-box">
	        <input type="text" value="广州" class="text">
	        <ul style="display: none">
	            <li>选择值</li>
	            <li>广州</li>
	            <li>深圳</li>
	        </ul>
    	</div>
    </div>
    
    <div class="tab_box pr_20 pl_20">
	    <div role="toolbar" class="fr mt_20 mb_20 pr_20">
	       ${toolbar}
	    </div>
    </div>
    
	<div role="grid">
		<div class="table">
			${grid}
		</div>
		${paging}
	</div>
	<!--分页-->
    <div class="tr mt_20 pr_20 pages">
            <a href="" class="item">首页</a>
            <a href="" class="item">1</a>
            <a href="" class="item">2</a>
            <a href="" class="item">3</a>
            <a href="" class="item">4</a>
            <a href="" class="item curr">5</a>
            <a href="javascript:void(0);" class="item none">...</a>
            <a href="" class="item">6</a>
            <a href="" class="item">下一页</a>
            <span>共10页</span>
            <input type="text" class="page-text">
            <input type="button" value="GO">
    </div>
</div>

<%@include file="footer.jspf"%>