package com.devops.suc.logic;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.devops.suc.model.DomainWeights;

/**
 * 登录helper
 * @author wangxichun
 *
 */
public class LoginHelper {
	
	/**
	 * 获取客户端真实的IP(在使用代理服务器的情况下).
	 * 
	 * @return 客户端的真实IP
	 */
	public static String getRealIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip==null || "".equals(ip)) {
			ip = request.getRemoteAddr();
		}
		else {
			ip = ip.split(", ")[0].trim();
			if ("127.0.0.1".equals(ip) || !isLicitIp(ip)) {
				ip = request.getRemoteAddr();
			}
		}
		if (ip == null) {
			ip = "";
		}
		return ip;
	}
	/**
	 * 判断是否为合法的ip.
	 * <p>
	 * 
	 * @param ip
	 * @return NONE
	 */
	public static boolean isLicitIp(String ip) {
		if(ip!=null && !"".equals(ip)){
			return false;
		}
		String regex = "^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(ip);
		if (!m.find()) {
			return false;
		}
		return true;
	}
	
	
	public static List<String> getCurServerIps(){
	    List<String> ips = new ArrayList<String>();
	    try{
	        Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
	        while (interfaces.hasMoreElements()) {
	            NetworkInterface interfaceN = (NetworkInterface)interfaces.nextElement();
	            Enumeration<InetAddress> ienum = interfaceN.getInetAddresses();
	            while (ienum.hasMoreElements()) {
	                InetAddress ia = ienum.nextElement();
	                String adress = ia.getHostAddress().toString();
	                if( adress.length() < 16) {
	                	if(!adress.startsWith("127") && adress.indexOf(":") <= 0){
	                		ips.add(adress);
	                	}
	                }
	            }
	        }
	    }
	    catch(Exception e){
	        e.printStackTrace();
	    }
	    return ips;
	}
	/**
	 * 取得权限最高的第一个url
	 * @param domains		--
	 * @param basePath		--
	 * @param port			--
	 * @return
	 */
	public static String getDomainsWelcomeUrl(List<DomainWeights>  domains,String basePath,String port){
		String tmpPath =basePath;
		String r = "";
		if (domains != null) {
			for (DomainWeights domain : domains) {
				basePath = "http://" + domain.getHost() + port;
				try {
					String url = basePath + "/survival.jsp";
					//r = HttpUtils.doGet2(url, 2000, 2000);
				} catch (Exception e) {
					e.printStackTrace();
					r = "";
				}
				if (r != null && "1".equals(r.trim())) {
					break;
				} else {
					basePath = "";
				}
			}
		}
		if (basePath == null || "".equals(basePath)) {// 设置默认域名
			basePath = tmpPath;
		}
		return basePath;
	}
}
