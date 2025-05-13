package com.webcky2.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/Register", "/Login").permitAll()  // Cho phép truy cập vào trang đăng ký và đăng nhập mà không cần xác thực
                .anyRequest().authenticated()  // Yêu cầu xác thực cho tất cả các yêu cầu còn lại
                .and()
                .formLogin()
                .loginPage("/Login")  // Định nghĩa trang đăng nhập
                .permitAll()
                .and()
                .logout()
                .permitAll();  // Cho phép logout
    }
}
