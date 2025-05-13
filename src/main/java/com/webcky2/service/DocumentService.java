package com.webcky2.service;

import com.webcky2.model.Document;
import com.webcky2.repository.DocumentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DocumentService {
    @Autowired
    private DocumentRepository documentRepository;
    public List<Document> getAllDocuments() {
        return documentRepository.findAll();
    }
    public Document getDocumentById(Long id) {
        return documentRepository.findById(id).orElse(null);
    }
    public Document saveDocument(Document document) {
        return documentRepository.save(document);
    }
}
