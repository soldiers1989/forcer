/**
 * Created by Administrator on 2018/2/8.
 */
$(".p_footer").on("click","li",function(){
    $(this).addClass("footActive").siblings().removeClass("footActive");
});
