package com.webcky2.config;

import com.webcky2.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http

                .authorizeRequests()
                .antMatchers("/Register", "/Login").permitAll()
                .antMatchers("/uploads/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/Login")
                .loginProcessingUrl("/Login")  // Spring tự xử lý POST
                .defaultSuccessUrl("/Home", true)
                .permitAll()
                .and()
                .logout()
                .logoutSuccessUrl("/Login")
                .permitAll();
        http.headers().frameOptions().sameOrigin(); // Cho phép iframe cùng domain

    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder);
    }


    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
