package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {

  @Override
  protected PasswordAuthentication getPasswordAuthentication() {

    String myGmailId = System.getProperty("smtp.username");
    String myGamilPw = System.getProperty("smtp.password");

    return new PasswordAuthentication(myGmailId, myGamilPw);
  }

}
