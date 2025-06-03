package com.webcky2.service;

import com.webcky2.PdfThumbnailGenerator;
import com.webcky2.ThumbnailService;
import com.webcky2.model.Document;
import com.webcky2.repository.DocumentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.data.domain.Pageable;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

@Service
public class DocumentService {

    private final DocumentRepository documentRepository;
    private final ThumbnailService thumbnailService;

    @Autowired
    public DocumentService(DocumentRepository documentRepository, ThumbnailService thumbnailService) {
        this.documentRepository = documentRepository;
        this.thumbnailService = thumbnailService;
    }

    public void saveDocument(String title, String author, String description, MultipartFile file, String uploadDir) throws IOException {
        Document doc = new Document();
        doc.setTitle(title);
        doc.setAuthor(author);
        doc.setDescription(description);

        // Lấy username hiện tại
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        doc.setUploadedBy(username);

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

        // Gán đường dẫn file
        doc.setFilePath(fileLocation.toString());

        String lowerName = originalFileName.toLowerCase();

        // Nếu file là PDF tạo thumbnail
        if (lowerName.endsWith(".pdf")) {
            String thumbnailAbsolutePath = PdfThumbnailGenerator.generateThumbnail(fileLocation.toString(), uploadDir);
            String thumbnailFileName = Paths.get(thumbnailAbsolutePath).getFileName().toString();
            doc.setThumbnailPath(thumbnailFileName);
        }

        // Nếu file là PPTX tạo thumbnail bằng thumbnailService
        else if (lowerName.endsWith(".pptx")) {
            File thumbnailFile = new File(uploadDir + "thumb_" + uniqueFileName + ".png");
            thumbnailService.createPPTXThumbnail(fileLocation.toFile(), thumbnailFile);
            doc.setThumbnailPath(thumbnailFile.getName());
        }

        // Lưu document vào DB
        documentRepository.save(doc);
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
    public List<Document> findDocumentsByPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<Document> pageResult = documentRepository.findAll(pageable);
        return pageResult.getContent();
    }

    public int countDocuments() {
        return (int) documentRepository.count();
    }

}