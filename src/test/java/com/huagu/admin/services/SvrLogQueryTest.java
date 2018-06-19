package com.huagu.admin.services;

import static org.junit.Assert.*;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.AppHandle;
import cn.cerc.jdb.core.Record;

public class SvrLogQueryTest {

	@Before
	public void setUp() throws Exception {
	}

	public void test() {
		LocalService getAllLogQuery = new LocalService(new AppHandle(), "SvrLogQuery");
		Record headIn = getAllLogQuery.getDataIn().getHead();

		headIn.setField("corpNo_", "727000");
		
		assertTrue(getAllLogQuery.exec());
		System.out.println(getAllLogQuery.getDataOut().getRecords());
	}
	
	public void test1() {
		LocalService getAllLogQuery = new LocalService(new AppHandle(), "SvrAddUserMoney");
		Record headIn = getAllLogQuery.getDataIn().getHead();

		headIn.setField("totalFee_", "1");
		
		assertTrue(getAllLogQuery.exec());
		System.out.println(getAllLogQuery.getDataOut().getRecords());
	}
	
	@Test
	public void test2() {Date date = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		// 柜子编码
		String cobId_ = sdf.format(date);
		// 柜子箱子数量
		String labelInfo = "[{\"childAnt\":1,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":1,\"numOrder\":1,\"press\":false},{\"childAnt\":2,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":2,\"numOrder\":2,\"press\":false},{\"childAnt\":3,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":3,\"numOrder\":3,\"press\":false},{\"childAnt\":4,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":4,\"numOrder\":4,\"press\":false},{\"childAnt\":5,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":5,\"numOrder\":5,\"press\":false},{\"childAnt\":6,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":6,\"numOrder\":6,\"press\":false},{\"childAnt\":7,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":7,\"numOrder\":7,\"press\":false},{\"childAnt\":8,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":8,\"numOrder\":8,\"press\":false},{\"childAnt\":9,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":9,\"numOrder\":9,\"press\":false},{\"childAnt\":10,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":10,\"numOrder\":10,\"press\":false},{\"childAnt\":11,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":11,\"numOrder\":11,\"press\":false},{\"childAnt\":12,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":12,\"numOrder\":12,\"press\":false}]";
	
		LocalService getAllLogQuery = new LocalService(new AppHandle(), "SvrControlSyncLabelInfo");
		Record headIn = getAllLogQuery.getDataIn().getHead();

		headIn.setField("cabinetId", cobId_);
		headIn.setField("labelInfo", labelInfo);
		
		assertTrue(getAllLogQuery.exec());
		System.out.println(getAllLogQuery.getDataOut().getRecords());
	}

}
