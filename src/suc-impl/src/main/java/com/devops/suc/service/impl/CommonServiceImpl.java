package com.devops.suc.service.impl;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.springframework.stereotype.Service;

import com.devops.suc.service.CommonService;

@Service
public class CommonServiceImpl implements CommonService {

	@Override
	public List<String> getCurServerIps() {
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

}
