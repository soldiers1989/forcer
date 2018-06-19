<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>

<!--中间内容-->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20">
       <span class="min-col f16">选择城市</span>
    </div>
    <div style="height: 500px;overflow:auto;padding: 0 100px;text-align: left;">
	    <form action="FrmAdData.copyData" method="post">
	     <input type="text" hidden="true" value="${UID_}" name="UID_"/>
	     <c:forEach var="item" items="${lists}">
	    	<label class="pb_10 mr_10" style="display: inline-table;"><input type="checkbox" name="corpNo_" value="${item.items.cityCode_}"/>${item.items.cityName_}</label>
	     </c:forEach>
	     <div class="tc">
	     	<div class="button mt_20 pt_20"><input type="submit" value="确定"/></div>
     	</div>
	    </form>
    </div>
</div>
<!-- end content -->

<%@include file="../ui/footer.jspf"%>