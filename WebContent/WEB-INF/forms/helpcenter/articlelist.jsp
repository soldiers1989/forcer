<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>帮助中心</title>
</head>
<script type="text/javascript">
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<script type="text/javascript">
    function del(id_) {
        var qr="确认要删除吗？";
        if(confirm(qr)==true){
            window.location.href="FrmHelpcenter.delArticle?id_="+id_;
        }
    }
    function update(id_) {
            window.location.href="FrmHelpcenter.upPage?id_="+id_;
    }
</script>
<script type="text/javascript">
$(function(){
$('#sub').on('click', function() {
    var startdate=$('#unlockDate_').val();
  var enddate=$('#endDate_').val();
  if(startdate != null && startdate!=""){
  if(startdate>enddate){ 
    alert("结束时间必须大于开始时间");
    return false;
    }
  }
    });
})
</script>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">帮助中心列表</span>
    </div>
    <form action="" method="post" >
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <a href="FrmHelpcenter.addPage" class="btn_style">新增</a>
        </div>
    </form>
    <form action="" id="subForm">
    	发布时间<input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="开始时间" value="${unlockDate_ }"/><font> -至- </font>
   		<input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="结束时间" value="${endDate_ }"/>
   		<input type="submit"  value="查询">
    </form>
    <div role="grid">
        <div class="table">
           <form action="" id="subForm">
           	 <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head">序号</th>
                        <th class="t-head">文章标题</th>
                        <th class="t-head">创建时间</th>
                        <th class="t-head">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc" id="userPage">
                    <%-- <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if> --%>
                    <c:if test="${not empty values}"></c:if>
                    <c:forEach items="${values }" var="value" varStatus="status">
                        <tr>
                            <td>${ status.index + 1}</td>
                             <td>${value.items.title_ }</td>
                            <td> ${value.items.addtime_ }</td>
                            <td>
                                <a onclick="update('${value.items.id_}');" class="btn_style mr_10">修改</a>
                                <a onclick="del('${value.items.id_}');" class="btn_style">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
           </form>
	    <c:if test="${pages.count >= 1}">
	        <div class="foot-page" align="center">
	            <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
	                href="javascript:page(${pages.prior});">上一页</a> <a
	                href="javascript:page(${pages.next});">下一页</a> <a
	                href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
	            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
	        </div>
	    </c:if>
        </div>
    </div>
</div>
<%-- 
    <table width="1000" border="5" cellspacing="5" cellpadding="5">
<tr>
    <th>序号</th>
    <th>文章标题</th>
     <th>创建时间</th>
        <th>操作</th>
</tr>
            <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
            <c:if test="${not empty values}"></c:if>
<c:forEach items="${values }" var="value" varStatus="status">
<tr>
     <td>${ status.index + 1}</td>
     <td>${value.items.title_ }</td>
    <td>${value.items.addtime_ }</td>
    <td><a onclick="update('${value.items.id_}');">修改</a>
    | <a onclick="del('${value.items.id_}');">删除</a>
    </td>
</tr>
</c:forEach>
</table>

<a href="FrmHelpcenter.addPage">新增</a>


 --%>
</body>
</html>