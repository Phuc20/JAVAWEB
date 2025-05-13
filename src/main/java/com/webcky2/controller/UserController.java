package com.webcky2.controller;

import com.webcky2.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/Register")
    public String showRegistrationForm() {
        return "Register";  // Trả về trang Register.jsp
    }

    @PostMapping("/Register")
    public String registerUser(@RequestParam String username,
                               @RequestParam String password,
                               @RequestParam String email,
                               @RequestParam(defaultValue = "USER") String role) {
        userService.createUser(username, password, email, role);  // Lưu vào cơ sở dữ liệu
        return "redirect:/Login";  // Chuyển hướng đến trang login
    }

   @GetMapping("/Login")
    public String showLoginPage() {
        return "Login";  // Trả về trang Login.jsp
    }

}
