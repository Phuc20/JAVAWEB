package com.webcky2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // Trang Home có thể được truy cập bởi cả user và admin
    /* @GetMapping("/Home")
    public String showHomePage() {
        return "Home";  // trả về home.jsp
    } */
}
