package com.huagu.myService.forms;

import java.util.Base64;

import javax.servlet.http.HttpServletResponse;

import com.huagu.common.tools.QrcodeUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.core.ClientDevice;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

/**
 *  @describe 我的服务
 *  @author 王姣
 *  @date   2018年3月12日上午10:39:53
 *  @return  
 */
public class FrmMyServices extends AbstractForm {

	/**
	 *  @describe 邀请好友
	 *  @author 王姣
	 *  @date   2018年3月12日上午9:52:16
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "service/inviteFriend.jsp");
		LocalService svr = new LocalService(this, "SvrGetUserInfo.getUserInfo");
		String  userCode ;
		if(getUserCode() != null ){
			userCode = this.getUserCode();
		}else{
			userCode = "17620458925";
		}
		if (!svr.exec("userCode", userCode)) {
			throw new RuntimeException(svr.getMessage());
		}
		String addr = this.getRequest().getHeader("Host");
		addr =new ServerConfig().getProperty("app.rootSite");
		String code = Base64.getEncoder().encodeToString(this.getUserCode().getBytes("UTF-8"));
		String url = "http://" + addr + "/forms/FrmLogin" ;
		jsp.add("device", new ClientDevice(this).getDevice());
		jsp.add("url", url);  
		jsp.add("name_", svr.getDataOut().getHead().getField("name_"));
		return jsp;
	}
	
	/**
	 * 生成二维码
	 * @author 王姣
	 * @date 2018年3月12日上午11:29:44
	 * @return 
	 */
	public IPage createQR() throws Exception {
		HttpServletResponse response = this.getResponse();
		response.setContentType("image/jpg");
		LocalService svr = new LocalService(this, "SvrGetUserInfo.getUserInfo");
		/*String userCode = getRequest().getParameter("userCode");*/
		String  userCode ;
		if(getUserCode() != null ){
			userCode = this.getUserCode();
		}else{
			userCode = "17620458925";
		}
		if (!svr.exec("userCode", userCode)) {
			throw new RuntimeException(svr.getMessage());
		}
		String id = svr.getDataOut().getHead().getString("id_");
		String addr = this.getRequest().getHeader("Host");
		addr =new ServerConfig().getProperty("app.rootSite");
		String code = Base64.getEncoder().encodeToString(this.getUserCode().getBytes("UTF-8"));
		String logoPath = this.getRequest().getServletContext().getRealPath("/images/sharemomoda.png");
		// QrcodeUtil.createStreamQrcodeWithLogo(300, 300, "http://" + addr +
		// "/forms/FrmPhoneRegistered?id=" + code,
		// logoPath, this.getResponse().getOutputStream());
		String url = String.format("%s/forms/FrmLogin?userId=%s", addr, id);
		QrcodeUtil.createStreamQrcode(300, 300, url,
				this.getResponse().getOutputStream());
		return null;
	}
	
	/**
	 * 我的分享
	 * @author 王姣
	 * @date 2018年4月8日下午3:46:16
	 * @return
	 */
	public IPage myShare() throws Exception{
		JspPage jsp = new JspPage(this, "service/myShare.jsp");
		//得到我的信息
		LocalService svtInfo = new LocalService(this, "SvrMyInfoShow");
		if(!svtInfo.exec()){
			throw new RuntimeException(svtInfo.getMessage());
		}
		jsp.add("myInfo", svtInfo.getDataOut().getCurrent());
		
		//得到我的邀请总数
		LocalService svrMyShare = new LocalService(this, "SvrMyShare");
		if(!svrMyShare.exec()){
			throw new RuntimeException(svrMyShare.getMessage());
		}
		//我的邀请人数
		jsp.add("shareNum", svrMyShare.getDataOut().getHead().getField("shareNum"));
		
		//得到分享人
		LocalService svrShare = new LocalService(this, "SvrMyShareQuery");
		if(!svrShare.exec()){
			throw new RuntimeException(svrShare.getMessage());
		}
		jsp.add("shares", svrShare.getDataOut().getRecords());
		return jsp;
	} 
	
	@Override
	public boolean logon() {
		return  true;
	}

}
