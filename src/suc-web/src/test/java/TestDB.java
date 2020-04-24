import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;


public class TestDB {

	public static void main(String[] args) throws SQLException {
	     try { 
	          Class.forName("com.mysql.jdbc.Driver"); 
	     } catch(ClassNotFoundException e) { 
	          System.out.println("找不到驱动程序"); 
	     }	
       String url = "jdbc:mysql://118.186.241.50:3306,118.186.241.50:3306/empty?useUnicode=true&amp;amp;characterEncoding=utf8&amp;amp;autoReconnect=true";
       Connection conn = DriverManager.getConnection(url,"empty","abc123");	
       ResultSet  resu = conn.createStatement().executeQuery("show tables");
       while(resu.next()){
    	   System.out.println(resu);
       }
	}
}
