<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nạp tiền qua QR Code | Dịch vụ thanh toán</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    :root {
      --primary-color: #4361ee;
      --secondary-color: #3f37c9;
      --success-color: #4ad66d;
      --warning-color: #f8961e;
      --danger-color: #f94144;
      --light-color: #f8f9fa;
      --dark-color: #212529;
      --gray-color: #6c757d;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f5f7ff;
      color: var(--dark-color);
      line-height: 1.6;
    }

    .container {
      max-width: 600px;
      margin: 30px auto;
      padding: 0 15px;
    }

    .card {
      background: white;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      margin-bottom: 30px;
      transition: transform 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px);
    }

    .card-header {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      padding: 20px;
      text-align: center;
      position: relative;
    }

    .card-header h1 {
      font-size: 24px;
      font-weight: 700;
      margin: 0;
    }

    .card-body {
      padding: 25px;
    }

    .qr-section {
      text-align: center;
      margin-bottom: 25px;
      padding: 20px;
      background-color: var(--light-color);
      border-radius: 12px;
      border: 1px dashed var(--gray-color);
    }

    .qr-title {
      font-size: 18px;
      font-weight: 500;
      margin-bottom: 15px;
      color: var(--primary-color);
    }

    .qr-code {
      width: 220px;
      height: 220px;
      margin: 0 auto;
      background-color: white;
      padding: 15px;
      border-radius: 12px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .qr-code img {
      max-width: 100%;
      height: auto;
    }

    .info-section {
      margin-bottom: 25px;
    }

    .section-title {
      font-size: 18px;
      font-weight: 500;
      margin-bottom: 15px;
      color: var(--primary-color);
      display: flex;
      align-items: center;
    }

    .section-title i {
      margin-right: 10px;
      font-size: 20px;
    }

    .info-grid {
      display: grid;
      grid-template-columns: 1fr 2fr;
      gap: 10px 15px;
      margin-bottom: 10px;
    }

    .info-label {
      font-weight: 500;
      color: var(--gray-color);
    }

    .info-value {
      font-weight: 500;
      word-break: break-all;
    }

    .note-box {
      background-color: #fff8e1;
      border-left: 4px solid var(--warning-color);
      padding: 12px 15px;
      margin: 15px 0;
      border-radius: 0 8px 8px 0;
    }

    .note-box p {
      margin: 0;
      font-size: 14px;
    }

    .steps {
      counter-reset: step-counter;
      margin: 20px 0;
    }

    .step {
      position: relative;
      padding-left: 50px;
      margin-bottom: 20px;
    }

    .step:before {
      counter-increment: step-counter;
      content: counter(step-counter);
      position: absolute;
      left: 0;
      top: 0;
      width: 32px;
      height: 32px;
      background-color: var(--primary-color);
      color: white;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
    }

    .step-title {
      font-weight: 500;
      margin-bottom: 5px;
    }

    .step-desc {
      font-size: 14px;
      color: var(--gray-color);
    }

    .btn {
      display: inline-block;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 50px;
      cursor: pointer;
      font-size: 16px;
      font-weight: 500;
      text-align: center;
      text-decoration: none;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
      width: 100%;
      margin-top: 10px;
    }

    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
    }

    .btn i {
      margin-right: 8px;
    }

    .support {
      text-align: center;
      margin-top: 30px;
      font-size: 14px;
      color: var(--gray-color);
    }

    .support a {
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 500;
    }

    .support a:hover {
      text-decoration: underline;
    }

    .badge {
      display: inline-block;
      padding: 4px 8px;
      color: white;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 500;
      margin-left: 10px;
    }

    @media (max-width: 480px) {
      .card-header h1 {
        font-size: 20px;
      }

      .qr-code {
        width: 180px;
        height: 180px;
      }

      .info-grid {
        grid-template-columns: 1fr;
        gap: 5px;
      }

    }
  </style>
</head>
<body>
<div class="container">
  <div class="card">
    <div class="card-header">
      <h1><i class="fas fa-qrcode"></i> Nạp tiền qua QR Code</h1>
    </div>

    <div class="card-body">
      <div class="qr-section">
        <div class="qr-title">Quét mã để nạp tiền nhanh chóng</div>
        <div class="qr-code">
          <img src="${pageContext.request.contextPath}/IMG/qr2.jpg" style="width:500px; height:600px; object-fit:contain; alt="QR Code Nạp Tiền">

        </div>
      </div>

      <div class="info-section">
        <div class="section-title">
          <i class="fas fa-university"></i> Thông tin chuyển khoản
        </div>

        <div class="info-grid">
          <div class="info-label">Ngân hàng:</div>
          <div class="info-value">MB Bank</div>

          <div class="info-label">Số tài khoản:</div>
          <div class="info-value">CPHUCS007</div>

          <div class="info-label">Chủ tài khoản:</div>
          <div class="info-value">HOANG CONG PHUC</div>

          <div class="info-label">Chi nhánh:</div>
          <div class="info-value">Đà Nẵng</div>
        </div>

        <div class="note-box">
          <p><strong>Lưu ý:</strong> Vui lòng ghi nội dung <strong>THANHTOAN-MADONHANG</strong> để hệ thống tự động xử lý giao dịch của bạn.</p>
        </div>
      </div>

      <div class="info-section">
        <div class="section-title">
          <i class="fas fa-info-circle"></i> Hướng dẫn nạp tiền
          <span class="badge">6 bước</span>
        </div>

        <div class="steps">
          <div class="step">
            <div class="step-title">Mở ứng dụng ngân hàng</div>
            <div class="step-desc">Mở ứng dụng ngân hàng đã liên kết trên điện thoại của bạn</div>
          </div>

          <div class="step">
            <div class="step-title">Chọn tính năng quét mã QR</div>
            <div class="step-desc">Tìm và chọn chức năng "Quét mã QR" trong ứng dụng</div>
          </div>

          <div class="step">
            <div class="step-title">Quét mã QR hoặc nhập thủ công</div>
            <div class="step-desc">Quét mã QR ở trên hoặc nhập thông tin chuyển khoản theo hướng dẫn</div>
          </div>

          <div class="step">
            <div class="step-title">Nhập số tiền cần nạp</div>
            <div class="step-desc">Nhập số tiền bạn muốn nạp vào tài khoản</div>
          </div>

          <div class="step">
            <div class="step-title">Kiểm tra và xác nhận</div>
            <div class="step-desc">Kiểm tra kỹ thông tin trước khi xác nhận giao dịch</div>
          </div>

          <div class="step">
            <div class="step-title">Hoàn tất giao dịch</div>
            <div class="step-desc">Tiền sẽ được cập nhật tự động trong vòng 1-5 phút</div>
          </div>
        </div>
      </div>

      <!-- Nút trợ giúp -->
      <button class="btn" onclick="alert('Vui lòng mở ứng dụng ngân hàng và quét mã QR ở trên để nạp tiền.\n\nNếu có thắc mắc, vui lòng liên hệ tổng đài hỗ trợ 1900 1234')">
        <i class="fas fa-question-circle"></i> Cần trợ giúp?
      </button>

      <!-- Form xác nhận thanh toán -->
      <form action="/ThanhToan" method="post" style="margin-top: 20px;">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button class="btn" type="submit">
          <i class="fas fa-money-bill-wave"></i> Xác nhận thanh toán
        </button>
      </form>
    </div>
  </div>

  <div class="support">
    <p>Mọi thắc mắc vui lòng liên hệ <a href="tel:19001234"><i class="fas fa-phone-alt"></i> 1900 1234</a> (24/7) hoặc <a href="mailto:cskhrulerdocument@gmail.com"><i class="fas fa-envelope"></i> cskhrulerdocument@gmail.com</a></p>
    <p><i class="fas fa-lock"></i> Giao dịch an toàn & bảo mật</p>
  </div>
</div>
</body>
</html>
