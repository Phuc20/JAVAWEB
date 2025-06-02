package com.webcky2.controller;

import com.webcky2.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

@Controller
public class DocumentController {

    @Autowired
    private DocumentService documentService;

    @GetMapping("/Home")
    public String showHome(Model model, HttpServletRequest request) {
        CsrfToken token = (CsrfToken) request.getAttribute("_csrf");
        model.addAttribute("_csrf", token);
        model.addAttribute("documents", documentService.getAllDocuments());
        return "Home";
    }

    @PostMapping("/upload")
    public String handleFileUpload(
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("description") String description,
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "uploadDir", required = false) String uploadDir,
            Model model) {

        if (file.isEmpty()) {
            model.addAttribute("message", "Vui lòng chọn file để tải lên");
            return "Home";
        }

        // Nếu không chọn thư mục, mặc định lưu ở đây
        if (uploadDir == null || uploadDir.isEmpty()) {
            uploadDir = "D:/UPFILE/";
        }

        documentService.saveDocument(title, author, description, file, uploadDir);

        model.addAttribute("message", "Tải lên thành công!");
        model.addAttribute("documents", documentService.getAllDocuments());

        return "redirect:/Home";
    }
}
