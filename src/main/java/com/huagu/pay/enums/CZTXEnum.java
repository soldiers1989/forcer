package com.huagu.pay.enums;

import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.EnumUtils;
import org.junit.Test;

/**
 * 
 * @ClassName: CZTXEnum
 * @Description: 充值还是提现，得到类型
 * @author tj
 * @date 2017年7月25日 下午5:51:21
 *
 */
public enum CZTXEnum {
	
	recharge("A"),upOut("B"),pay("C"),getMoney("D"),A("充值"),B("提现"),C("支付"),D("技师收款");
	
	private String value;
	
	private CZTXEnum(String value) {
		this.value = value;	
	}
	
	public String getValue() {
		return this.value;
	}
	
	public static String getKey(String value) {
		Map<String, CZTXEnum> emap = EnumUtils.getEnumMap(CZTXEnum.class);
		Set<String> keys = emap.keySet();
		for (String key :  keys) {
			if (value.equals(emap.get(key).value)) {
				return emap.get(key).name();
			}
		}
		return null;
	}
	
}
