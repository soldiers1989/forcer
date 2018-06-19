$(function(){
	/* 选择币种 */
	/*$('#currencyChose').on('click', function() {
        $('#moneyType').mobiscroll().treelist({
            theme : "ios7",
            lang : "zh",
            display : 'bottom',
            inputClass : 'tmp',
            headerText : "${rs_chooseMoney}",
            circular : [ true, false, false ],
            defaultValue : [ 1 ],
            setText : "${rs_alert}",
            cancelText : "${rs_cancel}",
            onSelect : function(valueText) {
                var curbz=$(this).find('li').eq(valueText).find('input').val();
                $('#choseResulet').val(curbz);
                var key = $(this).find('li').eq(valueText).find('input').attr('name')+"";
                var obj = new Function("return" + '${sys}')();//转换后的JSON对象
                var rate = obj[key];
                $("#moneyRate").val(parseFloat(rate));
                var amount = $("#amount").val();
                var price = $("#price").val();
                if (amount != null && amount !='' && price!=null && price!='') {
                    var getMoney = accMul(parseFloat(amount), accMul(price,rate))+'('+curbz+')';
                    $("#getMoney").val(getMoney);
                }
            },
            onChange : function(event, inst) {
                
            }
        });
        $("input[id^=moneyType]").focus();
    });*/
	
});

function mobiDate(node){
	$("#"+node).mobiscroll().date({ 
        theme: 'ios7', 
        display: 'bottom',
        mode: 'mixed', //日期选择模式
        dateFormat: 'yy-mm-dd', // 日期输出格式
        timeFormat: 'HH:ii:ss', // 日期输出格式
        dateOrder: 'yymmdd', //面板中日期排列格式
        timeWheels: 'HHiiss', //面板中日期排列格式
        setText: '确定', //确认按钮名称
        cancelText: '取消',//取消按钮名籍我
        dayText: '日', //面板中日文字
        monthText: '月', //面板中月文字
        yearText: '年', //面板中年文字
        endYear: 2020, //结束年份
        hourText: '时',
        minuteText: '分',
        secText: '秒',
        animate: 'slidevertical',
        lang: 'zh',
		onSelect : function(index) {
			$("#returnOverTime").val($("#returnOverTime1").val());
			
		}
    });
	$("input[id^="+node+"]").focus();

}

function mobiTreeList(inputNode,callback){
    $("#"+inputNode).mobiscroll().treelist({
        theme : "ios7",
        lang : "zh",
        display : 'bottom',
        inputClass : 'tmp',
        circular : [ true, false, false ],
        defaultValue : [ 1 ],
        setText : "确定",
        cancelText : "取消",
        onSelect : function(index) {
        	if(callback) callback(index);
        },
        onChange : function(event, inst) {
            
        }
    });
    $("input[id^="+inputNode+"]").focus();
}

function selectBank(node){
	mobiTreeList(node,function(index){
		var coinCode=$("#"+node).find('li').eq(index).find('.block201 .coinCode-left').text();
    	var coinCodeUID=$("#"+node).find('li').eq(index).find('.block201 .coinCode-right').text();
    	var bankCardName=$("#"+node).find('li').eq(index).find('.block201 .bankCardName-left').text();
    	var bankCardCode=$("#"+node).find('li').eq(index).find('.block201 .bankCardName-right').text();
    	
    	$("#bankName").val(bankCardName);
    	$("#coinCode").val(coinCode);
    	$("#bankCardCode").val(bankCardCode);
    	$("#bankCardUid").val(coinCodeUID);
    	$.post("FrmSellOutGuaDan.getDsdRate",{"bankBoinCode":coinCode},function(data){
    		var obj = eval('(' + data + ')');
    		console.log(obj);
    		console.log(obj.data);
    		$("#USDRate").val(obj.data);
    		$("#num").trigger("input");
    		//手续费
    		var percent = $("#poundage").val();
    		//单价
    		var rate = $("#rate").val();
    		var num = $("#num").val();
    		
    		var temp = parseFloat(num)-parseFloat(percent);
    		var temp2 = accMul(parseFloat(temp), parseFloat(rate));
    		var temp3 = accMul(parseFloat(temp2), parseFloat(obj.data));
    		//计算预计收款
    		$("#oriAmount").val(temp3);
    		var str = "("+num+"-"+percent+")x"+rate+"x"+obj.data+"="+temp3;
    		$(".block105 span").html(str);
    	});
    	USDRate_oninput();
    	
	});
	
	//解决js运算中由于浮点数相乘出现的bug
	function accMul(arg1,arg2){
	    var m=0;
	    var s1=arg1.toString();
	    var s2=arg2.toString();
	    try{m+=s1.split(".")[1].length}catch(e){}
	    try{m+=s2.split(".")[1].length}catch(e){}
	    return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
	}
}