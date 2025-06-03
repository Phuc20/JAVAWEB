package com.webcky2.service;

import com.webcky2.PdfThumbnailGenerator;
import com.webcky2.model.Document;
import com.webcky2.repository.DocumentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;

@Service
public class DocumentService {

    @Autowired
    private DocumentRepository documentRepository;

    public void saveDocument(String title, String author, String description, MultipartFile file, String uploadDir) throws IOException {
        Document doc = new Document();
        doc.setTitle(title);
        doc.setAuthor(author);
        doc.setDescription(description);

        // Lấy username hiện tại
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        doc.setUploadedBy(username);

        // Xử lý lưu file
        String filePath = saveFileToDisk(file, uploadDir);
        doc.setFilePath(filePath);

        if (file.getOriginalFilename().toLowerCase().endsWith(".pdf")) {
            String thumbnailAbsolutePath = PdfThumbnailGenerator.generateThumbnail(filePath, uploadDir);
            // Lấy tên file thumbnail
            String thumbnailFileName = Paths.get(thumbnailAbsolutePath).getFileName().toString();
            doc.setThumbnailPath(thumbnailFileName);
        }


        documentRepository.save(doc);
    }

    private String saveFileToDisk(MultipartFile file, String uploadDir) {
        try {
            // Tạo folder nếu chưa tồn tại
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Tạo tên file duy nhất (timestamp + tên file gốc)
            String originalFileName = file.getOriginalFilename().replaceAll("\\s+", "_");
            String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName;


            Path fileLocation = uploadPath.resolve(uniqueFileName);

            // Lưu file lên ổ đĩa
            file.transferTo(fileLocation.toFile());

            // Trả về đường dẫn tương đối hoặc tuyệt đối (tuỳ bạn muốn lưu gì)
            return fileLocation.toString();

        } catch (IOException e) {
            throw new RuntimeException("Failed to save file", e);
        }
    }

    public java.util.List<Document> getAllDocuments() {
        return documentRepository.findAll();
    }

    public Optional<Document> getDocumentById(Long id) {
        return documentRepository.findById(id);
    }
    public void deleteDocument(Long id) {
        documentRepository.deleteById(id);
    }

    public Document save(Document doc) {
        return documentRepository.save(doc);
    }

}
