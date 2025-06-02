
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

    /* Upload Modal */
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0,0,0,0.5);
    }

    .modal-content {
      background-color: #fefefe;
      margin: 10% auto;
      padding: 20px;
      border-radius: 5px;
      width: 80%;
      max-width: 500px;
    }

    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }

    .close:hover {
      color: black;
    }

    /* Form styles */
    .form-group {
      margin-bottom: 15px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    .form-group input[type="text"],
    .form-group input[type="file"] {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }

    .form-group textarea {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      min-height: 100px;
      resize: none;
    }

    .submit-btn {
      background-color: #0099cc;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 4px;
      cursor: pointer;
    }

    .submit-btn:hover {
      background-color: #0077aa;
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
    <a href="#" id="uploadBtn">Tải lên</a>
  </div>
</header>

<div class="container">
  <h1>Tài liệu - Slide phổ biến</h1>
<div class="slides-container">
  <c:forEach var="doc" items="${documents}">
    <div class="slide-card">
      <div class="slide-thumbnail">
        <!-- Hiển thị icon file hoặc thumbnail nếu có -->
        <span>📄</span>
      </div>
      <div class="slide-info">
        <div class="slide-title">${doc.title}</div>
        <div class="slide-author">Tác giả: ${doc.author}</div>
        <div class="slide-description">${doc.description}</div>
        <div class="slide-uploader">Uploaded by: ${doc.uploadedBy}</div>
        <div>
          <a href="/download?filePath=${fn:escapeXml(doc.filePath)}" target="_blank">Download</a>
        </div>
      </div>
    </div>
  </c:forEach>
</div>

  <!-- Slides grid would go here -->
</div>

<!-- Upload Modal -->
<div id="uploadModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>Tải lên tài liệu</h2>
    <form id="uploadForm" action="/upload" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="title">Tiêu đề:</label>
        <input type="text" id="title" name="title" required>
      </div>

      <div class="form-group">
        <label for="author">Tác giả:</label>
        <input type="text" id="author" name="author" required>
      </div>

       <div class="form-group">
          <label for="description">Mô tả:</label>
          <textarea id="description" name="description"></textarea>
        </div>

<div class="form-group">
    <label for="uploadDir">Chọn thư mục lưu file:</label>
    <select name="uploadDir" id="uploadDir">
      <option value="D:/UPFILE/">D:\UPFILE</option>
      <option value="C:/webcky2_uploads/">C:\webcky2_uploads</option>
      <option value="D:/Download/">D:\Download</option>
      <option value="D:/Desktop/">D:\Desktop</option>
    </select>
  </div>

      <div class="form-group">
        <label for="file">Chọn tệp:</label>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="file" id="file" name="file" accept=".pdf,.ppt,.pptx,.doc,.docx" required>
      </div>

      <button type="submit" class="submit-btn">Tải lên</button>
    </form>
  </div>
</div>

<script>
  // Get the modal
  var modal = document.getElementById("uploadModal");

  // Get the button that opens the modal
  var btn = document.getElementById("uploadBtn");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];

  // When the user clicks the button, open the modal
  btn.onclick = function() {
    modal.style.display = "block";
  }

  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
    modal.style.display = "none";
  }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
</script>
</body>
</html>
