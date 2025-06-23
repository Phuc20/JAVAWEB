package com.webcky2.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PaymentController {

    @GetMapping("/ThanhToan") // dùng để hiển thị form nạp tiền
    public String showForm() {
        return "ThanhToan"; // sẽ map tới /WEB-INF/views/ThanhToan.jsp
    }

    @PostMapping("/ThanhToan")
    public String xuLyThanhToan() {
        // TODO: xử lý logic nếu cần
        return "redirect:/Home"; // hoặc "thanhToanThanhCong" nếu bạn muốn hiển thị 1 trang riêng
    }
}
