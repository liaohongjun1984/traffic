import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;

import com.devops.suc.queue.impl.EmailExecute;

class MyAuthenticator extends javax.mail.Authenticator {

    private String user;
    private String password;

    public MyAuthenticator() {

    }

    public MyAuthenticator(String user, String password) {
        this.user = user;
        this.password = password;
    }

    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {

        return new PasswordAuthentication(user, password);
    }
}  

public class TestEmail {
	private static Logger logger = Logger.getLogger(EmailExecute.class);
	
	public static void main(String[] args) throws MessagingException, IOException{
		
	}
	
	

}
