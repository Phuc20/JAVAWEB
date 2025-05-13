package com.webcky2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.webcky2.model.Document;

import java.util.List;

public interface DocumentRepository extends JpaRepository<Document, Long> {
    // Các phương thức truy vấn tài liệu
    List<Document> findByTitle(String title);

}