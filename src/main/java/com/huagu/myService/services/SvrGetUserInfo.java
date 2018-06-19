package com.huagu.myService.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.BuildQuery;

public class SvrGetUserInfo extends CustomService {
	
	/**
	 * 获取用户标识
	 * @author 王姣
	 * @date 2018年3月13日上午10:37:42
	 * @return
	 */
	public boolean getUserInfo() {
		String userCode = getDataIn().getHead().getString("userCode");
		BuildQuery f = new BuildQuery(this);
		f.byField("code_", userCode);
		f.add("select id_ ,name_ from %s", appdb.S_Userinfo);
		DataSet ds = f.open();
		getDataOut().getHead().setField("id_", ds.getString("id_"));
		getDataOut().getHead().setField("name_", ds.getString("name_"));
		return true;
	}

}
