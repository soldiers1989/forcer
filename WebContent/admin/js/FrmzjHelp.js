$(function(){
	console.log(11111);
	$(".tbl").find("tr th:eq(0)").attr("width",'50');
	$(".tbl").find("tr th:eq(1)").attr("width",'150');
	$(".tbl td").attr("height",'50px');
	$(".tbl tr").css("height-min","1em");
	$(".table tr td").eq(2).addClass("content_width");
})