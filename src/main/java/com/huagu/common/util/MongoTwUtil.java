package com.huagu.common.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.cerc.jdb.core.Record;

/**
 * mongo数据转换工具
 * 将竖表数据的多条记录，转换成一条数据
 * 
 */
public class MongoTwUtil {
	
	public static Map<String, Record> getMapRecord(List<Record> records){
		Map<String, Record> map = new HashMap<>();
		for (Record ds : records) {
			Record record = map.get(ds.getString("UID_"));
			if(record == null){
				record = new Record();
				map.put(ds.getString("UID_"), record);
			}
			record.setField(ds.getString("code_"), ds.getString("value_"));
		}
		return map;
	}
}