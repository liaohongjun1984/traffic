<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.sql.*" %>

<%

String sRet = "#100";

String url    = "jdbc:mysql://master.tyga.mysql.com:3307,slave.tyga.mysql.com:3307/tyja?useUnicode=true&characterEncoding=utf8&autoReconnect=true";
String dbName = "admin";
String dbPwd  = "ktz7d0T#sJLxUv9mm6Ky";

Connection conn = null;
try {
	Class.forName("com.mysql.jdbc.Driver"); 
    conn = DriverManager.getConnection(url,dbName,dbPwd);
	String sql = "select now() ";
			
	PreparedStatement pstmt = conn.prepareStatement(sql);		
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
		sRet = "#0";
		out.println("<a href='#0' title='���ݿ�����������ϵͳ��ǰʱ��" + rs.getString(1) + "'>#0</a>");			
	}
}catch(Exception e){
	if (e.getMessage().indexOf("Communication link failure: java.net.SocketException") >= 0) {
		sRet = "#1";
		out.println("<a href='#1' title='�޷��������ݿ�'>#1</a>");
	} else {
		sRet = "#2";
		out.println("<a href='#2' title='���ݿ����ӳ���'>#2</a>");
	}
	if (e.getMessage().indexOf("java.lang.NullPointerException") >= 0) {
		sRet = "#5";
		out.println("<a href='#5' title='���ݿ����ӳ���'>#5</a>");
	} else {
		sRet = "#3";
		out.println("<a href='#3' title='δ֪�쳣'>#3</a>");
	}
}finally{
		if(conn!=null){
			conn.close();	
		}		
}
%>