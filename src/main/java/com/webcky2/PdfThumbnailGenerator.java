package com.webcky2;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class PdfThumbnailGenerator {

    public static String generateThumbnail(String pdfFilePath, String outputDir) throws IOException {
        File pdfFile = new File(pdfFilePath);
        PDDocument document = PDDocument.load(pdfFile);
        PDFRenderer pdfRenderer = new PDFRenderer(document);

        // Render trang đầu tiên (index 0)
        BufferedImage bim = pdfRenderer.renderImageWithDPI(0, 100); // 100 DPI là chất lượng ảnh, bạn có thể tăng hoặc giảm

        // Đặt tên file ảnh thumbnail
        String thumbnailFileName = pdfFile.getName().replace(".pdf", "") + "_thumb.png";
        File thumbnailFile = new File(outputDir, thumbnailFileName);

        // Ghi ảnh ra file PNG
        ImageIO.write(bim, "png", thumbnailFile);

        document.close();

        return thumbnailFile.getAbsolutePath();
    }
}
