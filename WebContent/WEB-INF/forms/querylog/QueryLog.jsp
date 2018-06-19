<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享</title>
</head>
<!-- <script language="javascript" type="text/javascript" src="../../admin/My97DatePicker/WdatePicker.js"></script> --> 
<style>
   .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    }
</style>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<script type="text/javascript">
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
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
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">日志操作查询</span>
    </div>
   <form action="FrmOperationLog.checklog" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                   <!--  开始时间<input class="Wdate" type="text" onClick="WdatePicker()" name="startTime_">-结束时间<input class="Wdate" type="text" onClick="WdatePicker()" name="endTime_"> 
                  -->  
                  <input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
                  <input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
                   <select name="operateType_" id="operateType_" >
                       	 <option value="0" <c:if test="${operateType_ eq '0' || operateType_ eq null }">selected="selected"</c:if> >全部</option>
				         <option value="查询" <c:if test="${operateType_ eq '查询' }">selected="selected"</c:if> >查询</option>
				         <option value="添加" <c:if test="${operateType_ eq '添加' }">selected="selected"</c:if> >添加</option>
				         <option value="修改" <c:if test="${operateType_ eq '修改' }">selected="selected"</c:if> >修改</option>
				         <option value="删除" <c:if test="${operateType_ eq '删除' }">selected="selected"</c:if> >删除</option>
					</select>
                </div>
               
            </div>
            <div class="fr rightSide">
                <input type="submit" value="查询">
                <a href="FrmExcel?service=SvrgetUserList&amp;exportKey=SvrgetUserList&amp;templateId=UserList">
				<input type="button" value="查询结果导出"></a>
            </div>
        </div>
    </form>
    
    <div role="grid">
        <div class="table" >
        <form  id="subForm">
            <table class="tbl">
                <tbody>
                 <tr >
			        <th class="t-head tc">序号</th>
			        <th class="t-head tc">日期/时间</th>
			        <th class="t-head tc">类型</th>
			        <th class="t-head tc">操作行为</th>
			        <th class="t-head tc">操作人</th>
			        <th class="t-head tc">操作IP</th>
			        <th class="t-head tc">详情</th>			        
			    </tr>
                </tbody>
                <tbody class="t-body tc">
                   <%--  <c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
				   --%>  <c:if test="${not empty values}"></c:if>
				    <c:forEach items="${values }" var="value" varStatus="status">
				    <tr>
				        <td>${ status.index + 1}</td>
				        <td>${value.items.operateData_}
				        </td>
				        <td>${value.items.operateType_}</td>
				        <td>${value.items.operate_}</td>
				        <td>${value.items.operateUser_}</td>
				        <td>${value.items.operateAdress_}</td>
				        <td>${value.items.operateDetail_}</td>
				    </tr>
				    </c:forEach>
                        
                </tbody>
            </table>
            </form>
        </div>
    </div>  
    <c:if test="${pages.count >= 1}">
            <div class="foot-page" align="center">
                <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                    href="javascript:page(${pages.prior});">上一页</a> <a
                    href="javascript:page(${pages.next});">下一页</a> <a
                    href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
                总条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
            </div>
    </c:if>




<%-- 日志操作查询
<form action="FrmOperationLog.checklog" method="post">
开始时间<input class="Wdate" type="text" onClick="WdatePicker()" name="startTime_">
结束时间<input class="Wdate" type="text" onClick="WdatePicker()" name="endTime_"> 
<select name="operateType_" id="operateType_" >
         <option value="查询">查询</option>
         <option value="添加">添加</option>
         <option value="修改">修改</option>
         <option value="删除">删除</option>
</select>
<input type="submit" value="查询">
<a href="FrmExcel?service=SvrgetUserList&amp;exportKey=SvrgetUserList&amp;templateId=UserList">
<input type="button" value="查询结果导出"></a>
</form>
    

<form  id="subForm">
    <table border="1">
    <tr >
        <th>序号</th>
        <th>日期/时间</th>
        <th>类型</th>
        <th>操作行为</th>
        <th>操作人</th>
        <th>操作IP</th>
        <th>详情</th>
        
    </tr>
    <c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
    <c:if test="${not empty values}"></c:if>
    <c:forEach items="${values }" var="value" varStatus="status">
    <tr>
        <td>${ status.index + 1}</td>
        <td>${value.items.operateData_}</td>
        <td>${value.items.operateType_}</td>
        <td>${value.items.operate_}</td>
        <td>${value.items.operateUser_}</td>
        <td>${value.items.operateAdress_}</td>
        <td>${value.items.operateDetail_}</td>
    </tr>
    </c:forEach>
</table>
 </form>
    
    
    
    <c:if test="${pages.count >= 1}">
            <div class="foot-page" align="center">
                <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                    href="javascript:page(${pages.prior});">上一页</a> <a
                    href="javascript:page(${pages.next});">下一页</a> <a
                    href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
                总条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
            </div>
    </c:if> --%>
</div> 
  
</body>
<script type="text/javascript">
function page(pageno) {
    $("#subForm").append(
            '<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#subForm").submit();
}
</script>
</html>