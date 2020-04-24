import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;


public class TestYY {
	private Logger logger = Logger.getLogger(TestYY.class);
	private List<Map<String,Object>> servers = new ArrayList<Map<String,Object>>();
	private int senderUID = 445358826;
	
	public TestYY(){
		Map<String,Object> tmp = new HashMap<String,Object>();
		tmp.put("ip", "121.14.37.158");
		tmp.put("port", 54321);
		servers.add(tmp);
		Map<String,Object> tmp1 = new HashMap<String,Object>();
		tmp1.put("ip", "59.151.47.70");
		tmp1.put("port", 54321);
		servers.add(tmp1);
		Map<String,Object> tmp2 = new HashMap<String,Object>();
		tmp2.put("ip", "113.107.111.18");
		tmp2.put("port", 54321);
		servers.add(tmp2);
	}
	
	private byte[] packetYYMessage(String message, int uid) throws UnsupportedEncodingException{
		    
	    byte[] messageUTF8 = message.getBytes("UTF-8");
	    int uri = (3 << 8) | 252;
	    
	    ByteBuffer body = ByteBuffer.allocate(messageUTF8.length + 1*4 + 10);
	    body.order(ByteOrder.LITTLE_ENDIAN);
	    
	    body.putInt(senderUID).putInt(1);
	    body.putInt(uid);
	    body.putShort((short) messageUTF8.length).put(messageUTF8);
	    body.flip();
	    
	    ByteBuffer packetBuffer = ByteBuffer.allocate(body.limit()+10);
	    packetBuffer.order(ByteOrder.LITTLE_ENDIAN);
	    packetBuffer.putInt(body.limit()+10).putInt(uri).putShort((short) 200).put(body);
	    packetBuffer.flip();
	    byte[] bytes = new byte[packetBuffer.limit()];
	    System.out.println(packetBuffer.limit());
	    packetBuffer.get(bytes);
	    
	    return bytes;
	  }
	
	// 发送YY消息到YY号
	  private boolean sendMessageByUids(String message, int uid) throws Exception{
	    
	    byte[] packet = packetYYMessage(message, uid);
	    for(Map<String,Object> map : servers){
	    	System.out.println(map);
	    	Socket socket = new Socket(map.get("ip").toString(), (Integer)map.get("port"));
	    	socket.getOutputStream().write(packet);
	    	socket.close();
	    	return true;
	    }
	    return true;
	  }  
	
	public void sendMessageByPassports(String message, String name) throws Exception{
	    // 确保只发送给 dw_开头的YY号，以防止错误发送到外部用户
		if(!name.startsWith("dw_")){
			logger.debug(name+" not allows");
			//return;
		}
		int uid = 909011091;
		// passport 2 uid
//		val uids = WebDbUtil.passportToUids(duowanUsers)
//		// val uids = duowanUsers.map(passport2uid).filter(_ != 0).toArray
		sendMessageByUids(message, uid);
	}
	public static void main(String[] args) throws Exception {
		int y = 5;
		int z = 5;
		System.out.println(y++);
		System.out.println(y = (++z));
		System.out.println(y++);
	}
}
