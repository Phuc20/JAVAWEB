package com.webcky2.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration //class cauhinh
public class AppConfig {
    @Bean //phuongthuc này sẽ trả về 1 đối tượng muốn spring qly
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
// đây là class mã hoá bmat
// kiểm tra mật khẩu khi người dùng đăng nhập