package com.webcky2.controller;

import com.webcky2.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // Trang đăng ký
    @GetMapping("/Register")
    public String showRegistrationForm() {
        return "Register";  // Trả về trang Register.jsp
    }

    // Xử lý đăng ký
    @PostMapping("/Register")
    public String registerUser(@RequestParam String username,
                               @RequestParam String password,
                               @RequestParam String email,
                               @RequestParam(defaultValue = "USER") String role) {
        try {
            userService.createUser(username, password, email, role);
            return "redirect:/Login";
        } catch (Exception e) {
            e.printStackTrace();
            return "Register";  // Nếu lỗi quay lại trang đăng ký
        }
    }


    // Trang đăng nhập (chỉ để hiển thị form)
    @GetMapping("/Login")
    public String showLoginPage() {
        return "Login";  // Trả về Login.jsp
    }

    // Trang Home sau khi login thành công
   
}
