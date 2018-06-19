<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cdn }/files/common.css">
    <link rel="stylesheet" href="${cdn }/css/user.css">
    <title>我要捐赠</title>
    <style>
        ul{
            display: inline;
        }
        ul li{
        	float:left;
        }
        .donation_detail_line{
      	    width: 0.85rem;
		    height: 0;
		    border-bottom: .01rem dashed #a0791a !important;
		    float: right;
		    padding-top: 0.382rem;
        }
    </style>
</head>
<body>
<!-- <div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
</div>  -->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">我要捐赠</div>
</div>
<div class="main_content" id="manual">
    <div id="mat"></div>

    <!--我要捐赠流程-->
    <div class="donation">
        <div class="donation_detail" >
           <div class="detail_text"></div> 
            <ul>
                <li>
                    <div class="donation_detail_ico">
                        <img class="donation_detail_img" src="../../img/love_donation.png">
                        <div class="donation_detail_line"></div>
                        <div class="donation_detail_explain">我要捐赠</div>
                    </div>
                </li>

                <li>
                    <div class="donation_detail_ico">
                        <img class="donation_detail_img" src="../../img/open.png">
                        <div class="donation_detail_line"></div>
                        <div class="donation_detail_explain">启享柜开启</div>
                    </div>
                </li>

                <li>
                    <div class="donation_detail_ico">
                        <img class="donation_detail_img" src="../../img/putinto.png">
                        <div class="donation_detail_line"></div>
                        <div class="donation_detail_explain">放置物品</div>
                    </div>
                </li>
                <li >
                    <div class="donation_detail_ico">
                        <img class="donation_detail_img" src="../../img/finish.png">
                        <div class="donation_detail_explain">点击完成</div>
                    </div>
                </li>

            </ul>
        </div>
    </div>

	<form action="FrmDonation.donationInsert" method="post" onsubmit="return check();">
	<input type="hidden" name="in" value="in">
    <!--填写捐赠信息文字-->
    <div class="donationText">
        <p>填写捐赠信息</p>
    </div>
    <!--填写捐赠信息-->
    <div class="writeDonationMessage">
        <div class="itemMess">
            <div class="itemMess_left"><p>物品描述</p></div>
            <div class="itemMess_right">
                <input type="text" name="proRemark_" id="proRemark_" placeholder="请输入物品描述">
            </div>
        </div>
        <div class="itemMess">
            <div class="itemMess_left"><p>物品数量</p></div>
            <div class="itemMess_right">
                <input type="text" name="productNum_" id="productNum_" placeholder="请输入物品数量">
            </div>
        </div>
        <div class="itemMess">
            <div class="itemMess_left"><p>物品规格</p></div>
            <div class="itemMess_right">
                <select name="proGuiGe_">
					<option value="0">大</option>
					<option value="1">小</option>
					<option value="2">中</option>
				</select>
            </div>
        </div>
        <div class="uploadPic">
            <ul>
                <li class="firstUploadPic"><div ><img src="../../img/photo-bg.png"></div><p>上传图片</p></li>
            </ul>
        </div>
        <div class="submitInBottom">
            <p><a href="FrmDonation.explainqShow">捐赠说明：</a><span>衣物用于公益，书籍用于免费共享</span></p>
            <input type="submit" value="我要捐赠"/>
        </div>
    </div>

</div>


</form>
<script type="text/javascript">
	function check(){
			var proRemark = $("#proRemark_").val();
			var productNum = $("#productNum_").val();
			var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
			var regNum = /^[0-9]*$/;
			if(proRemark == null || proRemark == ""){
				alert("物品描述不可为空");
				return false;
			}if(productNum == null || productNum == ""){
				alert("物品数量不可为空");
				return false;
			}if(regRule.test(proRemark)){
				alert("暂不支持表情");
				return false;
			}if(!regNum.test(productNum)){
				alert("数量只可为数字");
				return false;
			}		
	}
</script>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>

</body>
</html>   
    