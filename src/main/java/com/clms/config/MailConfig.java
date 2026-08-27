package com.clms.config;

import java.util.Properties;

public class MailConfig {
    public static Properties getMailProperties() {
        Properties props = new Properties();
        // Fallback for missing application.properties setup for mail (mock configuration)
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.example.com");
        props.put("mail.smtp.port", "587");
        return props;
    }
}
