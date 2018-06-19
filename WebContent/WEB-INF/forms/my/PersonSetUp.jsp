<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设置（运维端）</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">设置</div>
</div>
<div class="main_content" id="maintenance_set">
    <div id="mat"></div>
    <div class="list">
        <ul class="message_list">
            <li>
                <a class="flexLayout" href="FrmJumpPage.updatePasswordYunWei">
                    <div class="list_left">修改密码</div>
                    <div class="list_right"><img alt="" src="${cdn }/img/rightArrows.png"></div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="FrmJumpPage.serviceAgreementYunWei">
                    <div class="list_left">服务协议</div>
                    <div class="list_right"><img alt="" src="${cdn }/img/rightArrows.png"></div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="FrmJumpPage.helpCenterYunWei">
                    <div class="list_left">使用帮助</div>
                    <div class="list_right"><img alt="" src="${cdn }/img/rightArrows.png"></div>
                </a>
            </li>
            <li class="border_b">
                <a class="flexLayout" href="FrmJumpPage.aboutUsYunWei">
                    <div class="list_left">关于我们</div>
                    <div class="list_right"><img alt="" src="${cdn }/img/rightArrows.png"></div>
                </a>
            </li>
        </ul>
    </div>
    <div class="service_number">
        <a href="FrmJumpPage.phoneYunWei">
            <span class="font15 text-gray">客服电话</span>
            <span class="font15 text-gold ml_10">0755-23359516</span>
        </a>
    </div>
</div>
    <!-- <p><a href="FrmJumpPage.updatePasswordYunWei">修改密码</a></p>
    <p><a href="FrmJumpPage.serviceAgreementYunWei">服务协议</a></p>
    <p><a href="FrmJumpPage.helpCenterYunWei">使用帮助</a></p>
    <p><a href="FrmJumpPage.aboutUsYunWei">关于我们</a></p>
    <p><a href="FrmJumpPage.phoneYunWei">客服电话</a></p> -->
</body>
</html>