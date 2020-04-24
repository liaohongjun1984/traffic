import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.idhoo.dhutil.resource.ClassDesc;
import com.idhoo.dhutil.resource.MethodDesc;
import com.idhoo.dhutil.resource.SearchResource;


public class ResourceDB {
	
	private static int app_id = 1;
	
	public static void main(String[] args) throws SQLException{
	     try { 
	          Class.forName("com.mysql.jdbc.Driver"); 
	     } catch(ClassNotFoundException e) { 
	          System.out.println("找不到驱动程序"); 
	     }	
        String url = "jdbc:mysql://114.215.194.223:3306,114.215.194.223:3306/traffic_police?useUnicode=true&characterEncoding=utf8&autoReconnect=true";
        Connection conn = DriverManager.getConnection(url,"root","abc123");
        addResource(conn);
        
//        不操作JSP了，全部JSP通过.DO来转发
//        Map<String,List<String>> jspUril = new HashMap<String,List<String>>();
        
	}
	public static void addResource(Connection conn) throws SQLException {
		 Map<String,Map<String,Object>> dbData = getDBData(conn);
		 List<ClassDesc> resources = SearchResource.getResourceDesc();
		 for(ClassDesc cd : resources){
			 String className = cd.getClassName();
			 int parent_id = 0;
			 if(dbData.get(className)==null){
				 parent_id = insertDb(conn,cd.getFirstCate(),className,0,1);
			 }else{
				 parent_id = (Integer)(dbData.get(className).get("resources_id"));
				 updateDb(conn,cd.getFirstCate(),className,0);
				 dbData.remove(className);
			 }
			 for(MethodDesc md : cd.getChildren()){
				 if(dbData.get(md.getUrlPath())==null){
					 insertDb(conn,md.getName(),md.getUrlPath(),parent_id,1);
				 }else{
					 updateDb(conn,md.getName(),md.getUrlPath(),parent_id);
					 dbData.remove(md.getUrlPath());
				 }
			 }
		 }
		 for(Map<String,Object> data : dbData.values()){
			 removeDb(conn,(String)(data.get("uri")));
		 }
	}
	public static void removeDb(Connection conn,String uri) throws SQLException{
		String format = "delete from  security_resources where uri='%s' and app_id="+app_id;
		System.out.println(String.format(format,uri));
		conn.createStatement().executeUpdate(String.format(format,uri));
	}	
	public static void updateDb(Connection conn,String name,String uri,int parent_id) throws SQLException{
		String format = "update security_resources set name='%s',parent_id=%d ,last_modify=now() where uri='%s' and app_id="+app_id;
		System.out.println(String.format(format, name,parent_id,uri));
		conn.createStatement().executeUpdate(String.format(format, name,parent_id,uri));
	}
	public static int insertDb(Connection conn,String name,String uri,int parent_id,int type) throws SQLException{
		String format = " insert into security_resources" +
						" (parent_id,name,uri,operator,last_modify,sequence,app_id,type) " +
						" values " +
						" (%d,'%s','%s','AutoCode',now(),%f,%d,%d)";
		String sql = String.format(format, parent_id,name,uri,1.1f,app_id,type);
		System.out.println(sql);
		conn.createStatement().executeUpdate(sql);
		ResultSet resu = conn.createStatement().executeQuery("select max(resources_id) as resources_id from security_resources");
		resu.next();
		return resu.getInt("resources_id");
	}
	public static Map<String,Map<String,Object>> getDBData(Connection conn) throws SQLException{
		Map<String,Map<String,Object>> dbData = new LinkedHashMap<String,Map<String,Object>>();
		ResultSet resu = conn.createStatement().executeQuery("select * from security_resources where app_id="+app_id);
		while(resu.next()){
			Map<String,Object> d = new HashMap<String,Object>();
			d.put("resources_id", resu.getInt("resources_id"));
			d.put("parent_id", resu.getInt("parent_id"));
			d.put("name", resu.getString("name"));
			d.put("uri", resu.getString("uri"));
			d.put("operator", resu.getString("operator"));
			d.put("sequence", resu.getString("sequence"));
			d.put("app_id", resu.getString("app_id"));
			d.put("type", resu.getString("type"));
			dbData.put(resu.getString("uri"), d);
		}
		return dbData;
	}
}
