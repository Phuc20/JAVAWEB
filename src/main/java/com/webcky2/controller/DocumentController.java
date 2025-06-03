package com.webcky2.controller;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.webcky2.model.Document;
import com.webcky2.service.DocumentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import com.webcky2.repository.DocumentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.file.Path;
import java.io.IOException;
import java.util.Optional;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

@Controller
public class DocumentController {

    @Autowired
    private DocumentService documentService;
    @Autowired
    private DocumentRepository documentRepository;

    // Hiển thị trang chính
    @GetMapping("/Home")
    public String showHome() {
        return "redirect:/documents?page=1";
    }

    // Upload file
    @PostMapping("/upload")
    public String handleFileUpload(
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("description") String description,
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "uploadDir", required = false) String uploadDir,
            Model model) throws IOException {

        if (file.isEmpty()) {
            model.addAttribute("message", "Vui lòng chọn file để tải lên");
            return "Home";
        }

        if (uploadDir == null || uploadDir.isEmpty()) {
            uploadDir = "D:/UPFILE/";
        }

        documentService.saveDocument(title, author, description, file, uploadDir);

        int totalDocuments = documentService.countDocuments();
        int pageSize = 8;
        int lastPage = (int) Math.ceil((double) totalDocuments / pageSize);

        // Redirect đến trang cuối để thấy file mới upload
        return "redirect:/documents?page=" + lastPage;
    }


    // Xoá tài liệu theo id
    @DeleteMapping("/documents/{id}")
    public ResponseEntity<?> deleteDocument(@PathVariable Long id) {
        Optional<Document> docOpt = documentRepository.findById(id);
        if (!docOpt.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        Document doc = docOpt.get();

        try {
            if (doc.getFilePath() != null) {
                Files.deleteIfExists(Paths.get(doc.getFilePath()));
            }
            if (doc.getThumbnailPath() != null) {
                String thumbnailFullPath = buildThumbnailFullPath(doc.getThumbnailPath());
                Files.deleteIfExists(Paths.get(thumbnailFullPath));
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Xóa file thất bại");
        }

        documentRepository.delete(doc);
        return ResponseEntity.ok().build();
    }
    private String buildThumbnailFullPath(String thumbnailPath) {
        Path path = Paths.get(thumbnailPath);
        if (path.isAbsolute()) {
            return thumbnailPath; // dùng luôn
        } else {
            return Paths.get(basePath, thumbnailPath).toString();
        }
    }
    private final String basePath = "D:/UPFILE";



    @GetMapping("/documents")
    public String listDocuments(
            Model model,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "page", defaultValue = "1") int page) {

        System.out.println("Search keyword: " + search); // thêm dòng này để kiểm tra

        int pageSize = 8;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<Document> documentPage;

        if (search == null || search.trim().isEmpty()) {
            documentPage = documentRepository.findAll(pageable);
        } else {
            documentPage = documentRepository.findByTitleContainingIgnoreCaseOrAuthorContainingIgnoreCase(search, search, pageable);
        }

        model.addAttribute("documents", documentPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", documentPage.getTotalPages());
        model.addAttribute("search", search);

        return "Home";
    }





    // Cập nhật thông tin tài liệu
    @PutMapping("/documents/{id}")
    public ResponseEntity<?> updateDocument(
            @PathVariable Long id,
            @RequestBody Document updateDoc) {

        Optional<Document> docOpt = documentService.getDocumentById(id);
        if (!docOpt.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        Document doc = docOpt.get();

        // Chỉ cập nhật các trường có thể sửa (title, author, description)
        doc.setTitle(updateDoc.getTitle());
        doc.setAuthor(updateDoc.getAuthor());
        doc.setDescription(updateDoc.getDescription());

        documentService.save(doc);

        return ResponseEntity.ok().build();
    }
    public void save(Document doc) {
        documentRepository.save(doc);
    }

}