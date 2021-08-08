package verifiEmail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;

public class SendEmailActive {

    private static final Logger LOGGER = Logger.getLogger(SendEmailActive.class);

    public void sendEmailVerify(String toEmail, String codeRegister) {

        try {
            String to = toEmail;
            String from = "lqvinhh2000@gmail.com";

            String host = "smtp.gmail.com";

            Properties properties = System.getProperties();

            properties.put("mail.smtp.host", host);
            properties.put("mail.smtp.port", "465");
            properties.put("mail.smtp.ssl.enable", "true");
            properties.put("mail.smtp.auth", "true");

            Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("lqvinhh2000@gmail.com", "17113011");
                }
            });

            session.setDebug(true);

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            message.setSubject("Resource Sharing Web");

            String content = "Dear,<br>"
                    + "Please click the link below to verify your registration:<br>"
                    + "<h3><a href=\"[[URL]]\" target=\"_self\">VERIFY</a></h3>"
                    + "Thank you,<br>"
                    + "Resource Sharing Web.";

            String siteURL = "http://localhost:8080/J3.L.P0016";
            String verifyURL = siteURL + "/RegisterController?action=active&email=" + toEmail + "&codeRegister=" + codeRegister;
            content = content.replace("[[URL]]", verifyURL);

            message.setContent(content, "text/html; charset=utf-8");

            Transport.send(message);
        } catch (Exception e) {
            LOGGER.error(e);
        }
    }
}
