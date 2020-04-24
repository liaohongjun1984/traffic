package com.devops.suc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ReflashDatabase {

	
	public void init(String sql){
		  
		try {
			Class.forName("com.mysql.jdbc.Driver") ;
			String url = "jdbc:mysql://127.0.0.1:3306/traffic_police?useUnicode=true&amp;amp;characterEncoding=utf8&amp;amp;autoReconnect=true" ;    
		    String username = "root" ;   
		    String password = "abc123" ; 
		    Connection con = DriverManager.getConnection(url , username , password ) ;   
			
		    PreparedStatement pstmt = con.prepareStatement(sql) ; 
		    pstmt.executeUpdate();
		    
		    if(pstmt != null){   // 关闭声明   
		        try{   
		        	pstmt.close() ;   
		        }catch(SQLException e){   
		            e.printStackTrace() ;   
		        }   
		          }   
		          if(con != null){  // 关闭连接对象   
		         try{   
		        	 con.close() ;   
		         }catch(SQLException e){   
		            e.printStackTrace() ;   
		         }   
		          }  
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
	}
	
}
