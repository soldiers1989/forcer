package com.huagu.common.forms;

import org.apache.log4j.Logger;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jmis.form.AbstractForm;

/**
 * @ClassName: FrmMessage
 * @Description: 消息页面公共接口
 * @author
 * @date
 *
 */
public class FrmMessage extends AbstractForm {

	private static Logger log = Logger.getLogger(FrmMessage.class);

	@Override
	public IPage execute() throws Exception {
		return null;
	}

	/**
	 * 添加消息接口
	 */
	public static void addMsgInfo(IHandle handle, String title_, String content_, String type_, TDateTime tDateTime, String sendOb_,
			String sender_,String userCode_) throws Exception  {
		
		String typeInfo = null;
		switch (type_) {
		case "1":
			typeInfo = "订单消息";
			break;
		case "2":
			typeInfo = "系统消息";
			break;
		case "3":
			typeInfo = "运维消息";
			break;
		default:
			System.out.println("default");
			break;
		}
		log.info("正在添加 " + typeInfo + "类型消息。。。");
        LocalService addMsg = new LocalService(handle, "SvrMessage_Insert");
		if(!addMsg.exec("title_",title_,"content_",content_,"type_",type_,"sendTime_",tDateTime,"sendOb_",sendOb_,"sender_",sender_,"userCode_",userCode_)){
			log.info("添加 " + typeInfo + "类型消息失败。。。");
		}else{
			log.info("添加 " + typeInfo + "类型消息成功。。。");
		}
	}

	public static void main(String[] args) {
		//FrmMessage.addMsgInfo(this, "1", "15071506306", "junit 测试消息", "junit 测试消息", "master", "www.baidu.com");
	}
	
	public boolean logon() {
		return true;
	}
}
