<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Simple SlideShare Clone</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background-color: #f5f5f5;
    }

    /* Header */
    header {
      background-color: white;
      padding: 15px 20px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      font-size: 24px;
      font-weight: bold;
      color: #0099cc;
    }

    .search-bar {
      flex-grow: 1;
      margin: 0 20px;
    }

    .search-bar input {
      width: 100%;
      max-width: 500px;
      padding: 8px 15px;
      border: 1px solid #ddd;
      border-radius: 20px;
    }

    .user-actions a {
      margin-left: 15px;
      text-decoration: none;
      color: #333;
    }

    /* Main content */
    .container {
      max-width: 1200px;
      margin: 20px auto;
      padding: 0 15px;
    }

    .slides-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      margin-top: 20px;
    }

    .slide-card {
      background-color: white;
      border-radius: 5px;
      overflow: hidden;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .slide-thumbnail {
      height: 180px;
      background-color: #eee;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #999;
    }

    .slide-info {
      padding: 15px;
    }

    .slide-title {
      font-weight: bold;
      margin-bottom: 5px;
      color: #333;
    }

    .slide-author {
      font-size: 14px;
      color: #666;
    }

  </style>
</head>
<body>
<header>
  <div class="logo">Ruler Document</div>
  <div class="search-bar">
    <input type="text" placeholder="Tìm kiếm slides, tác giả...">
  </div>
  <div class="user-actions">
    <a href="#">Đăng nhập</a>
    <a href="#">Đăng ký</a>
    <a href="#">Tải lên</a>
  </div>
</header>

<div class="container">
  <h1>Tài liệu - Slide phổ biến</h1>

  <div class="slides-container">
    <!-- Slide 1 -->
    <div class="slide-card">
      <div class="slide-thumbnail">Hình ảnh tài liệu - slide 1</div>
      <div class="slide-info">
        <div class="slide-title">Đại Số Tuyến Tính</div>
        <div class="slide-author">GEN Chovy </div>
      </div>
    </div>

    <!-- Slide 2 -->
    <div class="slide-card">
      <div class="slide-thumbnail">Hình ảnh slide 2</div>
      <div class="slide-info">
        <div class="slide-title">Cấu Trúc Dữ Liệu và Giải Thuật</div>
        <div class="slide-author">GEN Ruler</div>
      </div>
    </div>

    <!-- Slide 3 -->
    <div class="slide-card">
      <div class="slide-thumbnail">Hình ảnh slide 3</div>
      <div class="slide-info">
        <div class="slide-title">HTML +</div>
        <div class="slide-author">GEN Kiin</div>
      </div>
    </div>

    <!-- Slide 4 -->
    <div class="slide-card">
      <div class="slide-thumbnail">Hình ảnh slide 4</div>
      <div class="slide-info">
        <div class="slide-title">Thiết kế UI/UX</div>
        <div class="slide-author">Phạm Thị D</div>
      </div>
    </div>

    <!-- Slide 5 -->
    <div class="slide-card">
      <div class="slide-thumbnail">Hình ảnh slide 5</div>
      <div class="slide-info">
        <div class="slide-title">React.js cơ bản</div>
        <div class="slide-author">Hoàng Văn E</div>
      </div>
    </div>

    <!-- Slide 6 -->
    <div class="slide-card">
      <div class="slide-thumbnail">Hình ảnh slide 6</div>
      <div class="slide-info">
        <div class="slide-title">Node.js và Express</div>
        <div class="slide-author">Vũ Thị F</div>
      </div>
    </div>
  </div>
</div>


</body>
</html>
