package com.webcky2.service;

import com.webcky2.model.User;
import com.webcky2.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    // Phương thức tạo người dùng mới
    public User createUser(String username, String password, String email, String role) {
        // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
        String encryptedPassword = passwordEncoder.encode(password);

        // Tạo đối tượng User mới
        User user = new User(username, encryptedPassword, email, role);  // Gán username, password, email, và role

        // Lưu người dùng vào cơ sở dữ liệu
        return userRepository.save(user);
    }

    // Phương thức kiểm tra đăng nhập
    public boolean checkLogin(String email, String password) {
        User user = userRepository.findByEmail(email);

        // Kiểm tra mật khẩu nhập vào với mật khẩu mã hóa trong cơ sở dữ liệu
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return true;  // Đăng nhập thành công
        }
        return false;  // Đăng nhập thất bại
    }
}
