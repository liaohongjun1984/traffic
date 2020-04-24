package com.devops.suc.util;

import javax.mail.PasswordAuthentication;

public class MyAuthenticator extends javax.mail.Authenticator {

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
