package com.webcky2.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.webcky2.model.Document;


public interface DocumentRepository extends JpaRepository<Document, Long> {
    Page<Document> findByTitleContainingIgnoreCaseOrAuthorContainingIgnoreCase(String title, String author, Pageable pageable);


}