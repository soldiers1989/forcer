package com.huagu.common.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

/**
 *   用户登录验证工具
 */
public class LoginUtil {

	/** 用户sessionMap  */
	public static Map<String, String> sessionMap = new HashMap<>();
	
	/**
	 * 验证用户是否在其他设备上登录
	 * @param userCode  用户编号
	 * @param session  当前请求session
	 */
	public static boolean vaildateLogin(String userCode, HttpSession session){
		String oldSessionId = sessionMap.get(userCode);
		if(oldSessionId != null && !oldSessionId.equals(session.getId())){
			return false;
		}
		return true;
	}
}
