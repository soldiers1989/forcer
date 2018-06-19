package com.huagu.more.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

public class FrmMore extends AbstractForm {

    /**
     * @describe 更多的菜单列
     * @author 王姣
     * @date 2018年3月9日上午11:17:27
     * @return
     */
    @Override
    public IPage execute() throws Exception {
        JspPage jsp = new JspPage(this, "more/more.jsp");
        return jsp;
    }

    /**
     * 个人中心我的总页面
     * 
     * @author 王姣
     * @date 2018年3月9日上午11:20:01
     * @return
     */
    public IPage userCenter() throws Exception {
		JspPage jsp = new JspPage(this, "more/userCenter.jsp");
		String userCode = this.getUserCode();
        if ("".equals(userCode))
            userCode = "17620458925";
        
        // 查询优惠券总数
        LocalService getCoupon = new LocalService(this, "SvrCouponAll.getCouponAll");
        if (!getCoupon.exec("userCode", userCode))
            throw new RuntimeException();
        jsp.add("couponAll", getCoupon.getDataOut().getCurrent());

        LocalService svr = new LocalService(this, "SvrUserInfoQuery");
        if (!svr.exec("userCode", userCode))
            throw new RuntimeException();
        jsp.add("user", svr.getDataOut().getCurrent());

        // 查询今日签到总数 和 已签到天数
        LocalService svr1 = new LocalService(this, "SvrUserSign");
        if (!svr1.exec("userCode", userCode))
            throw new RuntimeException();
        jsp.add("sum", svr1.getDataOut().getHead().getField("sum")); // 今日签到总数
        jsp.add("sumSign", svr1.getDataOut().getHead().getField("sumSign"));// 已签到天数

        // 查询我的总积分
        LocalService svrSignNum = new LocalService(this, "SvrMySignNum");
        if (!svrSignNum.exec("userCode_", userCode))
            throw new RuntimeException();
        jsp.add("signNum", svrSignNum.getDataOut().getCurrent());

        LocalService svr2 = new LocalService(this, "SvrOrder_My.getTotCashPledge");
        if (!svr2.exec("userId_", userCode))
            throw new RuntimeException();
        jsp.add("totCashPledge_", svr2.getDataOut().getCurrent().getString("totCashPledge_"));

        jsp.add("userCode_", userCode);
        return jsp;
    }

    /**
     * 签到
     * 
     * @author 王姣
     * @date 2018年3月9日下午3:30:15
     * @return
     */
    public IPage sign() throws Exception {
        JsonPage json = new JsonPage(this);
        LocalService svr = new LocalService(this, "SvrSign");
        /*String userCode_ = null;
        if("".equals(userCode_))
        	userCode_ = this.getUserCode();
        
        if("".equals(userCode_))
        	userCode_ = this.getRequest().getParameter("userId");
        
        Record head = svr.getDataIn().getHead(); 
        head.setField("userCode_", userCode_);*/
        String userCode = this.getUserCode();
        if ("".equals(userCode)) {
            userCode = "17620458925";
        }
        if (!svr.exec("userCode", userCode)) {
            json.setData(false);
            throw new RuntimeException();
        }
        json.setData(true);
        return json;
    }

    /**
     * 签到页面
     * 
     * @author 王姣
     * @date 2018年4月4日下午4:15:14
     * @return
     */
    public IPage lijiqiandao() throws Exception {
        JspPage jsp = new JspPage(this, "more/FrmSign.jsp");		
        String userCode = this.getUserCode();
        if ("".equals(userCode)) {
            userCode = "17620458925";
        }
        LocalService svr = new LocalService(this, "SvrUserInfoQuery");
        if (!svr.exec("userCode", userCode))
            throw new RuntimeException();
        jsp.add("user", svr.getDataOut().getCurrent());

        // 查询今日签到总数 和 已签到天数
        LocalService svr1 = new LocalService(this, "SvrUserSign");
        if (!svr1.exec("userCode",userCode))
            throw new RuntimeException();
        jsp.add("sum", svr1.getDataOut().getHead().getField("sum")); // 今日签到总数
        jsp.add("sumSign", svr1.getDataOut().getHead().getField("sumSign"));// 已签到天数
        jsp.add("createTime_", svr1.getDataOut().getRecords());// 拿到我的签到时间
        jsp.add("userCode_", userCode);
        return jsp;
    }

    /**
     * 取消签到
     * 
     * @author 王姣
     * @date 2018年3月9日下午3:49:04
     * @return
     */
    public IPage concerSign() throws Exception {
        JsonPage json = new JsonPage(this);
        /* String userCode_ = this.getUserCode(); */
        LocalService svr = new LocalService(this, "SvrCancelSign");
        /*
         * Record head = svr.getDataIn().getHead(); head.setField("userCode_",
         * userCode_);
         */
        if (!svr.exec()) {
            json.setData(false);
            throw new RuntimeException();
        }
        json.setData(true);
        return json;
    }

    /**
     * 签到说明，前台展示
     * 
     * @author 王姣
     * @date 2018年4月4日上午9:21:24
     * @return
     */
    public IPage signExplain() throws Exception {
        JspPage jsp = new JspPage(this, "more/signExplain.jsp");
        LocalService svr = new LocalService(this, "SvrSignExplain");
        if (!svr.exec()) {
            throw new RuntimeException(svr.getMessage());
        }
        jsp.add("explains", svr.getDataOut().getCurrent());

        return jsp;
    }

    /**
     * 减免押金
     * 
     * @author lxf
     * @date 2018年5月8日
     * @return
     */
    public IPage reliefDeposit() throws Exception {
        JspPage jsp = new JspPage(this, "more/reliefDeposit.jsp");
		// 取当前登录用户的身份证信息
		LocalService getUserCard = new LocalService(this, "SvrUserCard");
		if(!getUserCard.exec("type_", "s"))
            throw new RuntimeException(getUserCard.getMessage());
		
		if("".equals(getUserCard.getDataOut().getString("zhimaNum_")) || getUserCard.getDataOut().getString("zhimaNum_") ==null)
			jsp.add("zhima", "0");
		else
			jsp.add("zhima", getUserCard.getDataOut().getString("zhimaNum_"));
		
		if("".equals(getUserCard.getDataOut().getString("cardNum_")) || getUserCard.getDataOut().getString("cardNum_") ==null)
			jsp.add("cardNum_", "0");
		else
			jsp.add("cardNum_","1");
		
		
		//查询各个分之间的
		LocalService getCreditDeploy = new LocalService(this, "SvrGetCreditDeploy");
		if (!getCreditDeploy.exec())
			throw new RuntimeException(getCreditDeploy.getMessage());

		jsp.add("credit", getCreditDeploy.getDataOut().getRecords().get(0).getString("money_"));
		jsp.add("credit1", getCreditDeploy.getDataOut().getRecords().get(1).getString("money_"));
		jsp.add("credit2", getCreditDeploy.getDataOut().getRecords().get(2).getString("money_"));
		jsp.add("credit3", getCreditDeploy.getDataOut().getRecords().get(3).getString("money_"));
		jsp.add("credit4", getCreditDeploy.getDataOut().getRecords().get(4).getString("money_"));
		
        return jsp;
    }

    /**
     * 绑定手机号跳转
     * 
     * @author lxf
     * @date 2018年5月8日
     * @return
     */
    public IPage bindPhoneNumber() throws Exception {
        JspPage jsp = new JspPage(this, "more/reliefDeposit.jsp");
        return jsp;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
