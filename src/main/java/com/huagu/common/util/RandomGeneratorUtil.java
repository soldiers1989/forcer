package com.huagu.common.util;


/**
 * 随机数生成器
 * 
 * @author
 * 
 */
public class RandomGeneratorUtil {


	public static String createRandomNum(int count) {
		// 验证码
		String vcode = "";
		for (int i = 0; i < count; i++) {
			vcode = vcode + (int) (Math.random() * 9);
		}
		return vcode;
	}

}
