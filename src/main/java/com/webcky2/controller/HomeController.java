/*
package com.webcky2.controller;

import com.webcky2.model.Document;
import com.webcky2.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private DocumentService documentService;

    @GetMapping("/Home")
    public String home(Model model) {
        List<Document> documents = documentService.getAllDocuments();
        model.addAttribute("documents", documents);
        return "Home";  // trả về Home.jsp với danh sách tài liệu
    }
}
*/