import java.io.DataInputStream;  
import java.io.DataOutputStream;  
import java.io.IOException;  
import java.net.ServerSocket;  
import java.net.Socket;  
  
public class SocketManager {  
    /** 
     * @param args 
     * @throws IOException  
     */  
    public static void main(String[] args) {  
        SocketManager manager = new SocketManager();  
        manager.doListen();  
    }  
  
    public void doListen() {  
        ServerSocket server;  
        try {  
            server = new ServerSocket(54321);  
            while (true) {  
                Socket client = server.accept();  
                new Thread(new SSocket(client)).start();  
            }  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
  
    }  
  
    //服务器进程  
    class SSocket implements Runnable {  
  
        Socket client;  
  
        public SSocket(Socket client) {  
            this.client = client;  
        }  
  
        public void run() {  
            DataInputStream input;  
            DataOutputStream output;  
            try {  
                input = new DataInputStream(client.getInputStream());  
                output = new DataOutputStream(client.getOutputStream());  
                //  
                byte[]b = new byte[1024];
                input.read(b);
                for(int i=0;i<20;i++)
                System.out.println(b[i]);
                String listMsg = new String(b);  
                output.writeUTF("Recive:  " + listMsg + "    \r\n Thx...");  
                System.out.println("Recive:   " + listMsg);  
                listMsg = input.readUTF();  
                output.writeUTF("Recive Second:  " + listMsg + "    \r\n Thx...");  
                System.out.println("Recive Second:   " + listMsg);  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
    }  
  
}  