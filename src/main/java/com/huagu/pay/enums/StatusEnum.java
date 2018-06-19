package com.huagu.pay.enums;

import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.EnumUtils;

/**
 * 
 * @ClassName: StatusEnum
 * @Description: 支付订单状态
 * @author tj
 * @date 2017年7月25日 下午5:51:59
 *
 */
public enum StatusEnum {
	
	notPay("A"), paying("B"), paySuccess("C"), payCancel("D"), payFail("E"), out("F"), outSuccess("G"), outFail("H"),
	A("未支付"),B("支付中"),C("支付成功"),D("支付取消"),E("支付失败"),F("提现中"),G("提现成功"),H("提现失败");
	
	private String value;
	
	StatusEnum(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	public static String getKey(String value) {
		Map<String, StatusEnum> emap = EnumUtils.getEnumMap(StatusEnum.class);
		Set<String> keys = emap.keySet();
		for (String key :  keys) {
			if (value.equals(emap.get(key).value)) {
				return emap.get(key).name();
			}
		}
		return null;
	}

}
