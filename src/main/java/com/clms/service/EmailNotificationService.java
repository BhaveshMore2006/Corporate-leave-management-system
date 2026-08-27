package com.clms.service;

public class EmailNotificationService {
    // Mock implementation for Email Notification
    public void sendEmail(String to, String subject, String messageText) {
        System.out.println("--- Sending Email ---");
        System.out.println("To: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + messageText);
        System.out.println("---------------------");
    }
}
