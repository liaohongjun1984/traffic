package com.duowan.yy.sysop.suc.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import com.idhoo.dhutil.util.TimeUtil;

public class SendSMS {
	
	static int connectTimeout = 10000;
	static int readTimeout = 10000;
	//static String charset="UTF-8";       //默认的字符解码
	static String charset="GBK";       //默认的字符解码
	
	
	  //post方式获取url页面并返回结果
    static String post(String AHost,String APara){
    	String result="";
    	URL url;
    	URLConnection conn;
    	try{
    		url = new URL(AHost);      
    		conn = url.openConnection(); 
    		conn.setDoOutput(true);
    		  
    		conn.setConnectTimeout(connectTimeout);
    		conn.setReadTimeout(readTimeout);

    		OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(),charset);     
    	  
    		out.write(APara);
    		out.flush();
    		out.close();
    		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),charset));
    		String line;
    		//得到html header头信息
    		//result=connection.getHeaderFields().toString();
    		while ((line = in.readLine()) != null) {
    			result += line;
    		}
    		return result;
    	  }
    	  catch(Exception e){
    		  e.printStackTrace();
    	  }finally{
        	  url=null;
        	  conn=null;
    	  }
    	  return result;
    }
	
    static String SendSMS(String host,String org,String usr,String pwd,String APhones,String msg,String sendTime)
	{
		String post_data;
        post_data="act=send&orgid="+org+"&username="+usr+"&passwd="+pwd+"&msg="+msg+"&destnumbers="+APhones+"&connkey=&sendTime="+sendTime;
		String res;
		try{
			res=post(host,post_data);
			return res;                                  
		}catch (Exception e) {
			e.printStackTrace();
			return "-9";
		}
	}

    //发送短信（可以指定定时时间）
    static String SendSMS(String host,String org,String usr,String pwd,String APhones,String msg,String sendTime,String Booktime)
    {
        String post_data;
		//$post_data="act=send&orgid=$org&username=$usr&passwd=$pwd&msg=$msg&destnumbers=$tel&connkey=&booktime=$booktime";
        post_data="act=send&orgid="+org+"&username="+usr+"&passwd="+pwd+"&msg="+msg+"&destnumbers="+APhones+"&connkey=&sendTime="+sendTime+"&booktime="+Booktime;
        
        String res;
    try{
        res=post(host,post_data);
        return res;                                  
    }catch (Exception e) {
        e.printStackTrace();
        return "-9";
    }
    }

    //发送短信（可以指定定时时间）
    static String querynum(String host,String org,String usr,String pwd)
	{
		String post_data;
		//$post_data="act=check&orgid=$org&username=$usr&passwd=$pwd&msg=$msg&destnumbers=$tel&connkey=";
        post_data="act=check&orgid="+org+"&username="+usr+"&passwd="+pwd+"&msg=&destnumbers=&connkey=";
    	String res;
		try{
			res=post(host,post_data);
			return res;                                  
		}catch (Exception e) {
			e.printStackTrace();
			return "-9";
		}
	}
    
	public static void main(String[] args) {
		String host  =  "http://api-dx.panzhi.net/http.php";
		String org   =  "50136";
		String usr   =  "send_code";
		String pwd   =  "idohoo00398";
		String APhones = "18565225818";
		String msg     = "验证码：34343 [朋友家]";

		String para="SendSMS";
		if(args.length>0)
			para=args[0];
		if (para.equalsIgnoreCase("SendSMS")){                        //发短信
			String result;
			String sendTime = TimeUtil.getCurDateTime();
			result=SendSMS(host,org,usr,pwd,APhones,msg,sendTime);
			System.out.println(result);
		}
		if (para.equalsIgnoreCase("SendBookedMsg")){                  //发定时短信
			String result;
			String booktime="2010-10-01 10:10:10";
			String sendTime="2010-10-01 10:10:10";
			result=SendSMS(host,org,usr,pwd,APhones,msg,sendTime,booktime);  
			System.out.println(result);
		}
		if (para.equalsIgnoreCase("querynum")){                       //查余额
			String result;
			String booktime="2010-10-01 10:10:10";
			result=querynum(host,org,usr,pwd);
			System.out.println(result);
		}
	}
}
