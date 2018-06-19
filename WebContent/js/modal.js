/**
 * Created by Administrator on 2018/2/8.
 */
//只有一个确定按钮弹出窗
function modal(content){
    var oDiv=document.createElement("div");
    oDiv.className="mars";
    oDiv.innerHTML=
        "<div id='container'>"+
        "<p id='content'>"+content+"</p>"+
        "<div class='confirm'>确定</div>"+
        "</div>";
    var oStyle=document.createElement("style");
    oStyle.innerHTML=
        ".mars{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
        "#container{"+"width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;"+"}"+
        "#content{"+"width:100%;font-size: .34rem;text-align: center;line-height: .51rem;word-break: break-all;font-family: PingFang-SC-Medium;color: #4f4f4f;padding: .68rem .255rem;margin:0;box-sizing: border-box;-webkit-box-sizing: border-box;"+"}"+
        ".confirm{"+" width: 100%;font-size: .315rem;text-align: center;height:.765rem;line-height: .765rem;background: white;border-top:1px solid #ccc;color: #a0791a;cursor:pointer;border-radius: 0 0 3px 3px;-webkit-border-radius: 0 0 3px 3px;"+"}"+
        document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
    document.body.insertBefore(oDiv,document.body.children[0]);

    $("body").on("click",".confirm",function(){
        $(".mars").hide()
    })
};


//有确定、取消两个按钮弹出窗(有取消按钮)
function modalCancel(content){
    var oDiv=document.createElement("div");
    oDiv.className="mars1";
    oDiv.innerHTML=
        "<div id='container1'>"+
        "<p id='content1'>"+content+"</p>"+
        "<div class='flex'>"+
        "<div class='cancel1 modalBtn'>取消</div>"+
        "<div class='confirm1 modalBtn'>确定</div>"+
        "</div>"+
        "</div>";
    var oStyle=document.createElement("style");
    oStyle.innerHTML=
        ".mars1{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
        "#container1{"+"width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;-webkit-border-radius:3px;margin: 0;"+"}"+
        "#content1{"+"width:100%;font-size: .34rem;text-align: center;line-height: .51rem;word-break: break-all;font-family: PingFang-SC-Medium;color: #4f4f4f;padding: .68rem .255rem;margin:0;box-sizing: border-box;-webkit-box-sizing: border-box;border-bottom:1px solid #ccc;"+"}"+
        ".flex{"+"display:flex;width:100%;font-size: .315rem;height:.765rem;line-height: .765rem;"+"}"+
        ".modalBtn{"+" width: 50%;text-align: center;height:.765rem;line-height: .765rem;background: white;color: #a0791a;cursor:pointer;"+"}"+
        ".confirm1{"+"border-radius:0 0 3px 0;-webkit-border-radius:0 0 3px 0;"+"}"+
        ".cancel1{"+"border-right: 1px solid #ccc;border-radius:0 0 0 3px;-webkit-border-radius:0 0 0 3px;"+"}";
    document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
    document.body.insertBefore(oDiv,document.body.children[0]);

    $("body").on("click",".confirm1",function(){
        $(".mars1").hide();
    });
    $("body").on("click",".cancel1",function(){
        $(".mars1").hide();
    });
};

//报修归还弹出窗
function modalReturn(){
    var oDiv=document.createElement("div");
    oDiv.className="mars1";
    oDiv.innerHTML=
        "<div id='container1'>"+
        "<div class='return_title font19'>请选择</div>"+
        "<div class='return_content'><div class='report_style details_content'><span class='return_hint font14'>报修类型：</span><button type='button' class='btnActive'>他人责任</button><button type='button'>自己责任</button></div><div class='return_style details_content'><span class='return_hint font14'>归还方式：</span><button type='button' class='btnActive'>箱柜归还</button><button type='button'>快递归还</button></div>" +
        "</div>"+
        "<div class='flex'>"+
        "<div class='confirm1 modalBtn'>确定</div>"+
        "<div class='cancel1 modalBtn'>取消</div>"+
        "</div>"+
        "</div>";
    var oStyle=document.createElement("style");
    oStyle.innerHTML=
        ".mars1{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
        "#container1{"+"width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;-webkit-border-radius:3px;margin: 0;"+"}"+
        ".return_title{"+"text-align:center;padding: .255rem 0;"+"}"+
        ".return_content{"+"padding: 0 .45rem .255rem;border-bottom: 1px solid #ccc;"+"}"+
        ".details_content{"+"padding: .255rem 0;"+"}"+
        ".details_content button{"+"color: #808080;padding: .1rem .17rem;border: 1px solid #ccc;border-radius: 3px;-webkit-border-radius: 3px;background-color: white;margin-left: .17rem;"+"}"+
        ".details_content .btnActive{"+"background-color: rgba(240, 131, 0, 0.2);border: solid 1px rgba(207, 176, 101, 0.2);color: #a0791a;"+"}"+
        "#content1{"+"width:100%;font-size: .34rem;text-align: center;line-height: .51rem;word-break: break-all;font-family: PingFang-SC-Medium;color: #4f4f4f;padding: .85rem .255rem;margin:0;box-sizing: border-box;-webkit-box-sizing: border-box;border-bottom:1px solid #e6e6e6;"+"}"+
        ".flex{"+"display:flex;width:100%;font-size: .306rem;height:.765rem;line-height: .765rem;"+"}"+
        ".modalBtn{"+" width: 50%;text-align: center;height:.765rem;line-height: .765rem;background: white;color: #a0791a;cursor:pointer;"+"}"+
        ".confirm1{"+"border-right: 1px solid #ccc;border-radius:0 0 0 3px;-webkit-border-radius:0 0 0 3px;"+"}"+
        ".cancel1{"+"border-radius:0 0 3px 0;-webkit-border-radius:0 0 3px 0;"+"}";
    document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
    document.body.insertBefore(oDiv,document.body.children[0]);

    $("body").on("click",".cancel1",function(){
        $(".mars1").hide();
    });
    $("body").on("click",".confirm1",function(){
        $(".mars1").hide();
    });
    $(".return_content").on("click",".details_content button",function(){
        $(this).addClass("btnActive").siblings().removeClass("btnActive");
    });
};

//捐赠成功弹出窗
function modalSuccess(id){
    var oDiv=document.createElement("div");
    oDiv.className="mars";
    oDiv.innerHTML=
        "<div id='container'>"+
        "<div class='success_content'>"+
        "<div class='success_title font19'>尊敬的<span class='donate_id'>"+id+"</span>用户</div>"+
        "<div class='success_hint font16'>感谢您为公益事业贡献一份力量</div>"+
        "</div>"+
        "<div class='confirm'>确定</div>"+
        "</div>";
    var oStyle=document.createElement("style");
    oStyle.innerHTML=
        ".mars{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
        "#container{"+"width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;"+"}"+
        ".success_content{"+"line-height: .68rem;text-align: center;padding: .255rem 0;"+"}"+
        ".success_title{"+"color: #1a1a1a;"+"}"+
        ".success_title .donate_id{"+"color: #a0791a;"+"}"+
        ".success_hint{"+"color: #4f4f4f;"+"}"+
        ".confirm{"+" width: 100%;font-size: .315rem;text-align: center;height:.765rem;line-height: .765rem;background: white;border-top:1px solid #ccc;color: #a0791a;cursor:pointer;border-radius: 0 0 3px 3px;-webkit-border-radius: 0 0 3px 3px;"+"}"+
        document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
    document.body.insertBefore(oDiv,document.body.children[0]);

    $("body").on("click",".confirm",function(){
        $(".mars").hide()
    })
};

//箱子属性弹出窗(有取消按钮)
function modalBox(id,num){
    var oDiv=document.createElement("div");
    oDiv.className="mars1";
    oDiv.innerHTML=
        "<div id='container1'>"+
        "<div class='box_title font18'><span>"+id+"</span>箱子属性</div>"+
        "<div class='box_content font14'>" +
        "<div class='box_number box_message font18'><span class='box_hint'>箱子编号：</span><span class='fr' id='num_'>"+num+"</span></div>"+
        "<div class='box_purpose box_message font18'><span class='box_hint'>箱子用途：</span><select class='fr' id='type_' style='margin-right: -0.13rem;'><option value=''>租赁柜组</option></select></div>"+
        "<div class='box_size box_message font18'><span class='box_hint'>箱子型号：</span><select class='fr' id='size_'><option value=''>大型</option><option value=''>中型</option><option value=''>小型</option></select></div>"+
        "</div>"+
        "<div class='flex'>"+
        "<div class='cancel1 modalBtn'>取消</div>"+
        "<div class='confirm1 modalBtn'>确定</div>"+
        "</div>"+
        "</div>";
    var oStyle=document.createElement("style");
    oStyle.innerHTML=
        ".mars1{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
        "#container1{"+"width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;-webkit-border-radius:3px;margin: 0;"+"}"+
        ".box_title{"+"text-align: center;padding:.51rem 0 .255rem;color: #333333;"+"}"+
        ".box_content{"+"font-size: .238rem;text-align: left;padding: 0 .425rem .51rem;"+"}"+
        ".box_message{"+"height: .765rem;line-height: .935rem;border-bottom: 1px solid #e6e6e6;font-size: .238rem"+"}"+
        ".box_message select{"+"margin-top: .2rem;border: 0;"+"}"+
        ".box_hint{"+"color: #999999;"+"}"+
        ".flex{"+"display:flex;width:100%;font-size: .315rem;height:.765rem;line-height: .765rem;"+"}"+
        ".modalBtn{"+" width: 50%;text-align: center;height:.765rem;line-height: .765rem;background: white;color: #a0791a;cursor:pointer;"+"}"+
        ".confirm1{"+"border-radius:0 0 3px 0;-webkit-border-radius:0 0 3px 0;"+"}"+
        ".cancel1{"+"color: #333333 !important;border-right: 1px solid #ccc;border-radius:0 0 0 3px;-webkit-border-radius:0 0 0 3px;"+"}";
    document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
    document.body.insertBefore(oDiv,document.body.children[0]);

    $("body").on("click",".confirm1",function(){
        $(".mars1").hide();
    });
    $("body").on("click",".cancel1",function(){
        $(".mars1").hide();
    });
};