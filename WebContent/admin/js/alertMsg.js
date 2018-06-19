//表单错误提示信息
function alertMsg(val){
	var html = '<div id="msg" class=" tc mt_10 pt_10" style="center;color:red"></div>';
	$("body").append(html);
	$("#msg").empty().html(val);
	setTimeout(function(){
		$("#msg").remove();
	},2000)
	
}
function AlertInfo(mesg){
	alert(mesg)
}