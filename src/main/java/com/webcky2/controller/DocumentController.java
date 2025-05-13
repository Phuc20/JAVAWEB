package com.webcky2.controller;

import com.webcky2.model.Document;
import com.webcky2.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
@Controller

public class DocumentController {
    @Autowired
    private DocumentService documentService;
    private static String UPLOAD_DIR = "uploads/";  // Thư mục lưu trữ tệp tải lên

    // Trang tải lên tệp
    @GetMapping("/upload")
    public String showUploadForm() {
        return "upload";  // Trang upload.jsp
    }

    // Xử lý việc tải lên tệp
    @PostMapping("/upload")
    public String uploadFile(@RequestParam("title") String title,
                             @RequestParam("description") String description,
                             @RequestParam("file") MultipartFile file) throws IOException {

        // Kiểm tra loại tệp
        String fileType = file.getContentType();
        if (!fileType.equals("application/pdf") && !fileType.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document") && !fileType.equals("application/vnd.openxmlformats-officedocument.presentationml.presentation")) {
            // Nếu tệp không phải là PDF, DOCX hoặc PPT
            return "error";  // Quay lại trang lỗi nếu tệp không hợp lệ
        }

        // Tạo thư mục nếu chưa tồn tại
        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Đặt tên tệp và lưu trữ
        String fileName = file.getOriginalFilename();
        Path path = Paths.get(UPLOAD_DIR + fileName);
        Files.write(path, file.getBytes());  // Lưu tệp vào thư mục

        // Lưu thông tin tài liệu vào cơ sở dữ liệu
        Document document = new Document();
        document.setTitle(title);
        document.setDescription(description);
        document.setFilePath(path.toString());  // Lưu đường dẫn tệp vào cơ sở dữ liệu
        document.setUploadedBy(1L);  // Đảm bảo rằng người tải lên là người dùng với ID thích hợp
        documentService.saveDocument(document);

        return "redirect:/Home";  // Chuyển đến trang chủ
    }
}
