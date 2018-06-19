package com.huagu.common.util;

public class HideStringUtil {

	public static String hideCardNo(String cardNo) {
		if (cardNo.length() >= 10) {
			String start = cardNo.substring(0, 4);
			String end = cardNo.substring(cardNo.length() - 4);
			cardNo = start + " **** **** " + end;
		}
		return cardNo;
	}

	public static String hideMobile(String mobile) {
		if (mobile.length() >= 10) {
			String start = mobile.substring(0, 3);
			String end = mobile.substring(mobile.length() - 4);
			mobile = start + "*****" + end;
		}
		return mobile;
	}

	public static String hideIdCard(String idCardNo) {
		if (idCardNo.length() >= 10) {
			String start = idCardNo.substring(0, 3);
			String end = idCardNo.substring(idCardNo.length() - 4);
			idCardNo = start + " **** **** " + end;
		}
		return idCardNo;
	}

	public static String hideName(String name) {
		if (name.length() > 1)
			name = "*" + name.substring(1);
		return name;
	}

}
