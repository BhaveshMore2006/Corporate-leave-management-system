package com.clms.service;

import com.clms.dao.UserDAO;
import com.clms.model.User;
import com.clms.util.PasswordHasher;

public class AuthService {
    private UserDAO userDAO = new UserDAO();

    public User authenticate(String email, String password) {
        User user = userDAO.getUserByEmail(email);
        if (user != null && user.isActive()) {
            if (PasswordHasher.checkPassword(password, user.getPasswordHash())) {
                return user;
            }
        }
        return null;
    }
}
