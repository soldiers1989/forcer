<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>物品电子条码状态查询与变更</title>
<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">物品电子条码状态查询与变更</span>
    </div>
    <div id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmNode_queryUpdate" method="post" id="rentForm" class="mb_10">
                    <label>按物品主电子条码</label>
                    <input type="text" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> 
                    <label>按物品归属机构</label>
                    <input type="text" name="homeAgency_" value="${homeAgency_ }" placeholder="请输入搜索的关键字"> 
                    <label>按物品状态</label>
                    <input type="text" name="nodeState_" value="${nodeState_ }" placeholder="请输入搜索的关键字"> 
                    <label>按变更时间</label>
<%--                     <input type="date" name="updateDate_" value="${updateDate_ }" placeholder="请输入搜索的关键字">  --%>
                     <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="updateDate_"  placeholder="变更时间" value="${updateDate_ }"/>
                    <input type="submit" value="查询" class="mb_0">
                </form>  
            </div>
            <div class="fr rightSide">
            <a href="FrmExcel?service=SvrQueryPro_ByCabinet.nodeQueryUpdate&amp;exportKey=SvrQueryPro_ByCabinet.nodeQueryUpdate&amp;templateId=nodeQueryUpdate" class="btn_style mb_0">导出电子标签</a>
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">一级分类</th>
                        <th class="t-head tc">二级分类</th>
                        <th class="t-head tc">物品名称</th>	
                        <th class="t-head tc">物品主条码</th>
                        <th class="t-head tc">物品归属机构</th>
                        <th class="t-head tc">物品当前状态</th>
                        <th class="t-head tc">单据发起人</th>
                        <th class="t-head tc">状态变更时间</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${value}" var="val">
                        <tr>
                        <td>${val.items.fristName_ }</td>
                        <td>${val.items.twoName_ }</td>
                        <td>${val.items.proName_ }</td>
                        <td>${val.items.zhuCode_ }</td>
                        <td>${val.items.homeAgency_ }</td>
                        <td>
                       	   <c:if test="${val.items.nodeState_=='0' }">
                       		 初始录入
                           </c:if>
                              <c:if test="${val.items.nodeState_=='1' }">
                       		 在库
                           </c:if>
                              <c:if test="${val.items.nodeState_=='2' }">
                       		在柜
                           </c:if>
                              <c:if test="${val.items.nodeState_=='3' }">
                       		在租
                           </c:if>
                              <c:if test="${val.items.nodeState_=='4' }">
                       		在途
                           </c:if>
                              <c:if test="${val.items.nodeState_=='5' }">
                       		 已售
                           </c:if>
                        </td>
                        <td>${val.items.operateManName_ }</td>
                        <td>${val.items.updateDate_ }</td>
                        <td><a href="FrmNode_queryUpdate.updateZaiKu?zhuCode_=${val.items.zhuCode_ }">变更为在库</a></td>
                       
             <%--            
                        
                            <td>${val.items.fristName_ }</td>
                            <td>${val.items.twoName_ }</td>
                            <td>${val.items.proName_ }</td>
                            <td>${val.items.zhuCode_ }</td>
                            <td>${val.items.homeAgency_ }</td>
                            
                            <c:if test="${val.items.nodeState_=='0' }">
                            <td>初始录入</td>
                            </c:if>
                             <td>${val.items.createUser_ }</td>
                            
                            <c:if test="${val.items.nodeState_=='1' }">
                            <td>在库</td>
                             <td>${val.items.createUser_ }</td>
                            </c:if>
                            
                             <c:if test="${val.items.nodeState_=='2' }">
                            <td>在柜</td>
                            </c:if>
                            
                             <c:if test="${val.items.nodeState_=='3' }">
                             <td>在租</td>
                             <td>${val.items.userId_ }</td>
                            </c:if>
                            
                             <c:if test="${val.items.nodeState_=='4' }">
                            <td>在途</td>
	                            </c:if>
                            
                            <c:if test="${val.items.nodeState_=='5' }">
                            <td>已售</td>
                             <td>${val.items.userId_ }</td>
                            </c:if>
                            <td>${val.items.operateManName_ }</td>
                            <td>${val.items.updateDate_ }</td>
                            <td><a href="FrmNode_queryUpdate.updateZaiKu?zhuCode_=${val.items.zhuCode_ }">变更为在库</a></td>
                       --%>  </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
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
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
    function del() {
      var msg = "您确定要删除吗？";
      if (confirm(msg) == true) {
        return true;
      } else {
        return false;
      }
    }
</script>
</body>
</html>