package com.huagu.more.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
/**
 *  @describe 个人中心-我的-积分管理
 *  @author 王姣
 *  @date   2018年4月4日上午10:55:43
 *  @return  
 */
public class FrmIntegral extends AbstractForm {

	/**
	 *  @describe 积分说明
	 *  @author 王姣
	 *  @date   2018年4月4日上午11:00:03
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "more/integralExplainShow.jsp");
		LocalService svr = new LocalService(this, "SvrIntegralExplain");
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("explains", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 编辑积分说明
	 * @author 王姣
	 * @date 2018年4月4日下午2:34:39
	 * @return
	 */
	public IPage editIntegral() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrEditIntExp");
			Record head = svr.getDataIn().getHead();
			head.setField("explain_", this.getRequest().getParameter("explain_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmIntegral");
		}else{
			JspPage jsp = new JspPage(this, "more/editInteExp.jsp");
			LocalService svr = new LocalService(this, "SvrGetInEXbyId");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			jsp.add("explains", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	/**
	 * 我的积分
	 * @author 王姣
	 * @date 2018年4月4日下午2:02:23
	 * @return
	 */
	public IPage integral() throws Exception{
		JspPage jsp = new JspPage(this, "more/myIntegral.jsp");
		LocalService svr = new LocalService(this ,"SvrMySignNum");
		String userCode = this.getUserCode();
        if ("".equals(userCode)) 
            userCode = "17620458925";
		if(!svr.exec("userCode_", userCode))
			throw new RuntimeException(svr.getMessage());
		jsp.add("integral", svr.getDataOut().getCurrent());
		
		//我的积分记录
		LocalService svrSignRecords = new LocalService(this ,"SvrMySignRecords");
		if(!svrSignRecords.exec("userCode_", userCode))
			throw new RuntimeException(svrSignRecords.getMessage());
		jsp.add("myIntegrals" ,svrSignRecords.getDataOut().getRecords());
		
		return jsp;
	}

	/**
	 * 积分说明
	 * @author 王姣
	 * @date 2018年4月4日下午2:54:41
	 * @return  
	 */
	public IPage jiFenExplain() throws Exception{
		JspPage jsp = new JspPage(this, "more/jifenExplainShow.jsp");
		LocalService svr = new LocalService(this, "SvrIntegralExplain");
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("explains", svr.getDataOut().getCurrent());
		return jsp;
	}
	@Override
	public boolean logon() {
		return true;
	}
}
