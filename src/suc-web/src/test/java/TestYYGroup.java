import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class TestYYGroup {
	
	public List<Map<String,Object>> servers = null;
	
	public TestYYGroup(){
		servers = new ArrayList<Map<String,Object>>();
		
		Map<String,Object> m1 = new HashMap<String,Object>();
		m1.put("ip", "114.111.163.49");
		m1.put("port", 54321);
		servers.add(m1);
		
		Map<String,Object> m2 = new HashMap<String,Object>();
		m2.put("ip", "101.226.185.11");
		m2.put("port", 54321);
		servers.add(m2);
		
		Map<String,Object> m3 = new HashMap<String,Object>();
		m3.put("ip", "121.14.37.158");
		m3.put("port", 54321);
		servers.add(m3);
	}
	
	public void sendYY(long groupId,long folderId,String msg,String nick,
			long seq,int color) throws Exception{
		long ts = System.currentTimeMillis();
		long seqId = ts + seq;
		long imlinkdId = 0;
        long senderUid = 77794965;
        long timestamp = 0;
        for(Map<String,Object> server : servers){
        	byte[] data = this.getMessage(groupId, folderId, seqId, imlinkdId, senderUid, timestamp, msg, nick, color);
        	Socket socket = null;
        	try {
				socket = new Socket((String)server.get("ip"),(Integer)server.get("port"));
				OutputStream netOut = socket.getOutputStream();  
				DataOutputStream doc = new DataOutputStream(netOut);  
	            DataInputStream in = new DataInputStream(socket.getInputStream()); 
	            doc.write(data);
	           
	            doc.close();  
	            in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				if(socket != null){
					socket.close();
				}
			}
        }
	}
	
	private byte[] getMessage(long groupId,long folderId,long seqId,long imlinkdId,
			long senderUid,long timestamp,String msg,String nick,int color) throws Exception{
		int uri = (108 << 8) | 57;
		byte[] messageUTF8 = msg.getBytes("UTF-8");
		ByteBuffer body = ByteBuffer.allocate(messageUTF8.length + 1*4 + 10);
		body.order(ByteOrder.LITTLE_ENDIAN);
		body.putLong(groupId);
		
		ByteBuffer packetBuffer = ByteBuffer.allocate(body.limit()+10);
		packetBuffer.order(ByteOrder.LITTLE_ENDIAN);
	    packetBuffer.putInt(body.limit()+10).putInt(uri).putShort((short) 200).put(body);
	    
	    byte[] bytes = new byte[packetBuffer.limit()];
	    //packetBuffer.get(bytes,0,bytes.length);
		return bytes;
	}
	
	public static void main(String[] args) throws Exception {
		TestYYGroup yy = new TestYYGroup();
		yy.sendYY(14999122, 14999122, "yy", "test", 1, 0);
	}
	
	

}
