package com.webcky2;

import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@Service
public class ThumbnailService {

    public void createPPTXThumbnail(File pptxFile, File thumbnailFile) throws IOException {
        try (FileInputStream inputStream = new FileInputStream(pptxFile);
             XMLSlideShow ppt = new XMLSlideShow(inputStream)) {

            XSLFSlide slide = ppt.getSlides().get(0); // Lấy slide đầu tiên

            Dimension pgsize = ppt.getPageSize();

            BufferedImage img = new BufferedImage(pgsize.width, pgsize.height, BufferedImage.TYPE_INT_RGB);
            Graphics2D graphics = img.createGraphics();

            // Đặt background trắng
            graphics.setPaint(Color.white);
            graphics.fill(new Rectangle2D.Float(0, 0, pgsize.width, pgsize.height));

            // Vẽ slide lên ảnh
            slide.draw(graphics);

            // Ghi ảnh ra file thumbnail
            ImageIO.write(img, "png", thumbnailFile);
        }
    }
}
