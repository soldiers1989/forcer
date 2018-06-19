package com.huagu.pay.enums;

import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.EnumUtils;

/**
 * 
 * @ClassName: PlatformEnum
 * @Description: 微信还是支付宝，得到支付类型
 * @author tj
 * @date 2017年7月25日 下午5:51:40
 *
 */
public enum PlatformEnum {
	
	weixin("A"),alipay("B"),A("微信"),B("支付宝");
	
	private String value;
	
	PlatformEnum(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	public static String getKey(String value) {
		Map<String, PlatformEnum> emap = EnumUtils.getEnumMap(PlatformEnum.class);
		Set<String> keys = emap.keySet();
		for (String key :  keys) {
			if (value.equals(emap.get(key).value)) {
				return emap.get(key).name();
			}
		}
		return null;
	}

}
