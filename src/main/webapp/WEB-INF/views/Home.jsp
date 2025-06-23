<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ruler Slide</title>
  <style>
    * {
      margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif;
    }
    body { background-color: #f5f5f5; }

    header {
      background-color: white;
      padding: 12px 24px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.08);
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: sticky;
      top: 0;
      z-index: 100;
    }
    .logo {
      font-size: 24px;
      font-weight: 700;
      color: #0099cc;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .search-bar input {
      width: 100%;
      max-width: 500px;
      padding: 10px 170px;
      border: 1px solid #e0e0e0;
      border-radius: 24px;
      font-size: 14px;
      transition: all 0.3s ease;
      background-color: #f8f9fa;
    }

    .search-bar input:focus {
      outline: none;
      border-color: #0099cc;
      box-shadow: 0 0 0 3px rgba(0,153,204,0.1);
      background-color: white;
    }
  .user-actions button.upload-btn {
    border: none;
    color: black;
    font-weight: 600;
    cursor: pointer;
    padding: 8px 14px;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 6px;
    border-radius: 6px;
    transition: all 0.2s ease;
  }

#uploadBtn {
  background-color: transparent !important;
  color: white !important;
  border-radius: 6px;
  padding: 8px 16px;
  transition: all 0.2s ease;
}
#uploadBtn:hover {
  background-color: rgba(0,153,204,0.1) !important;
  transform: translateY(-1px);
}
body:not(.dark-mode) #uploadBtn {
  color: black !important;
  border-color: black !important;
}

body:not(.dark-mode) #uploadBtn:hover {
  background-color: rgba(0,153,204,0.1);
}

  .user-actions button.upload-btn:hover {
    color: #0099cc;
    background-color: rgba(0,153,204,0.1);
    transform: translateY(-1px);
  }

    .user-actions button.upload-btn i {
      font-size: 18px;
    }
    .user-actions {
      display: flex;
      gap: 15px;
      align-items: center;
    }

    .action-btn {
      background-color: transparent;
      border: none;
      color: #555;
      font-weight: 600;
      cursor: pointer;
      padding: 8px 14px;
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 6px;
      border-radius: 6px;
      transition: all 0.2s ease;
    }

    .action-btn:hover {
      color: #0099cc;
      background-color: rgba(0,153,204,0.1);
      transform: translateY(-1px);
    }

    /* Container */
    .container {
      max-width: 1200px; margin: 20px auto; padding: 0 15px;
    }

    .slides-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      margin-top: 20px;
    }

    .slide-card {
      background-color: white;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: column;
      height: 100%;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .slide-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }
    .slide-thumbnail {
      height: 180px;
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
    }

    .slide-thumbnail img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
    }
    .slide-thumbnail::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0,0,0,0.03);
    }
    .slide-info {
      padding: 16px;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
      border-top: 1px solid rgba(0,0,0,0.05);
    }

    .slide-title {
      font-weight: 600;
      margin-bottom: 8px;
      color: #333;
      font-size: 16px;
      line-height: 1.4;
      cursor: pointer;
    }

    .slide-author, .slide-description, .slide-uploader {
      font-size: 14px; color: #666; margin-bottom: 5px;
      flex-shrink: 0;
    }

    .slide-description {
      flex-grow: 1;
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
    }

    .slide-info div:last-child {
      margin-top: auto;
    }

    .slide-info a {
      color: #0099cc;
      text-decoration: none;
      font-weight: 600;
      display: inline-flex;
      align-items: center;
      gap: 5px;
      transition: color 0.2s ease;
    }
    .slide-info a:hover {
      color: #0077aa;
      text-decoration: none;
    }

    .btn-group {
      margin-top: 10px;
    }
    .btn-group button {
      background-color: #0099cc;
      border: none;
      color: white;
      padding: 6px 12px;
      margin-right: 8px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 13px;
      font-weight: 500;
      transition: all 0.2s ease;
    }
    .btn-group button.delete {
      background-color: #cc0000;
    }

    .btn-group button:hover {
      opacity: 0.9;
      transform: translateY(-1px);
    }

    .modal {
      display: none;
      position: fixed; z-index: 1;
      left: 0; top: 0;
      width: 100%; height: 100%;
      background-color: rgba(0,0,0,0.5);
    }
    .modal-content {
      background-color: #fefefe;
      margin: 10% auto;
      padding: 20px;
      border-radius: 5px;
      width: 80%;
      max-width: 500px;
      position: relative;
    }
    .close, .close-edit, .close-preview {
      color: #aaa; float: right;
      font-size: 28px; font-weight: bold;
      cursor: pointer;
      position: absolute;
      right: 15px;
      top: 10px;
    }
    .close:hover, .close-edit:hover, .close-preview:hover {
      color: black;
    }

    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block; margin-bottom: 5px; font-weight: bold;
    }
    .form-group input[type="text"],
    .form-group input[type="file"],
    .form-group textarea,
    .form-group select {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
    }
    .form-group textarea {
      min-height: 100px;
      resize: none;
    }
    .submit-btn {
      background-color: #0088bb;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
    .submit-btn:hover {
      background-color: #0088bb;
    }
    .pagination li {
      margin: 0 4px;
    }

    .pagination a, .pagination span {
      padding: 6px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      color: #333;
      text-decoration: none;
      min-width: 36px;
      text-align: center;
      display: inline-block;
    }

    .pagination li.active span {
      background-color: #0099cc;
      color: white;
      border-color: #0099cc;
    }

    .pagination li.disabled span {
      color: #999;
      background-color: #f5f5f5;
      border-color: #ddd;
    }
    body.dark-mode {
      background-color: #121212;
      color: #e0e0e0;
    }

    .dark-mode header {
      background-color: #1e1e1e;
      color: #ffffff;
    }

    .dark-mode .slide-card {
      background-color: #2d2d2d;
      color: #e0e0e0;
    }

    .dark-mode .slide-title,
    .dark-mode .slide-author,
    .dark-mode .slide-description,
    .dark-mode .slide-uploader {
      color: #b0b0b0;
    }

    .dark-mode .modal-content {
      background-color: #2d2d2d;
      color: #e0e0e0;
    }

    .dark-mode .form-group input[type="text"],
    .dark-mode .form-group input[type="file"],
    .dark-mode .form-group textarea,
    .dark-mode .form-group select {
      background-color: #1e1e1e;
      color: #e0e0e0;
      border-color: #444;
    }

    .dark-mode .pagination a,
    .dark-mode .pagination span {
      background-color: #2d2d2d;
      color: #e0e0e0;
      border-color: #444;
    }

    .dark-mode .action-btn,
    .dark-mode .upload-btn {
      color: #e0e0e0;
    }
   .upload-btn {
     background-color: #0099cc;
     color: #0099cc !important;
     border-radius: 6px;
     padding: 8px 16px;
     transition: all 0.2s ease;
   }

    .upload-btn:hover {
      background-color: #0088bb;
      transform: translateY(-1px);
      box-shadow: 0 2px 8px rgba(0,153,204,0.2);
    }
    .dark-mode .action-btn:hover,
    .dark-mode .upload-btn:hover {
      color: #007bff;
    }

    .action-btn {
      transition: all 0.3s ease;
    }

    .action-btn:hover {
      transform: scale(1.05);
    }
    .skeleton {
      background-color: #f5f5f5;
      overflow: hidden;
      position: relative;
    }

    .skeleton::after {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(90deg,
        rgba(255,255,255,0) 0%,
        rgba(255,255,255,0.3) 50%,
        rgba(255,255,255,0) 100%);
      animation: shimmer 1.5s infinite;
    }

    .skeleton-item {
      background-color: #e0e0e0;
      border-radius: 4px;
    }

    .dark-mode .skeleton {
      background-color: #2d2d2d;
    }

    .dark-mode .skeleton-item {
      background-color: #3d3d3d;
    }

    @keyframes shimmer {
      0% { transform: translateX(-100%); }
      100% { transform: translateX(100%); }
    }

    @media (max-width: 768px) {
      header {
        flex-direction: column;
        padding: 12px;
        gap: 12px;
      }

      .search-bar {
        width: 100%;
        margin: 0;
      }

      .user-actions {
        width: 100%;
        justify-content: space-between;
      }

      .slides-container {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      }

      .modal-content {
        width: 95%;
        margin: 20% auto;
      }
    }

    @media (max-width: 480px) {
      .slides-container {
        grid-template-columns: 1fr;
      }

      .slide-thumbnail {
        height: 150px;
      }

      .user-actions button span {
        display: none;
      }

      .user-actions button i {
        margin-right: 0;
      }
    }
    [data-tooltip] {
      position: relative;
    }

    [data-tooltip]::after {
      content: attr(data-tooltip);
      position: absolute;
      bottom: 100%;
      left: 50%;
      transform: translateX(-50%);
      background-color: #333;
      color: white;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 12px;
      white-space: nowrap;
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.2s ease;
    }

    [data-tooltip]:hover::after {
      opacity: 1;
      visibility: visible;
    }

    .dark-mode [data-tooltip]::after {
      background-color: #555;
    }
    body.dark-mode .user-actions button.upload-btn {
      color: white !important;
    }
    body.dark-mode .user-actions button.action-btn.upload-btn {
      color: white !important;
    }

  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body>
<header>
  <div class="logo">Ruler Document</div>
  <div class="search-bar">
    <input type="text" placeholder="Tìm kiếm slides, tác giả..." id="searchInput" />
  </div>
  <div class="user-actions">
    <button id="themeToggle" class="action-btn" data-tooltip="Chuyển đổi chế độ sáng/tối">
      <i class="fas fa-moon"></i> <span>Dark Mode</span>
    </button>
    <button id="uploadBtn" class="upload-btn" data-tooltip="Tải lên tài liệu mới">
      <i class="fas fa-upload"></i> <span>Tải lên</span>
    </button>
    <button id="logoutBtn" class="action-btn">
      <i class="fas fa-sign-out-alt"></i> <span>Đăng xuất</span>
    </button>
  </div>
      <div class="header-actions">
<a href="/ThanhToan" class="thanhtoan-btn" title="Thanh Toán">
  <i class="fa-regular fa-credit-card fa-xl" style="color: #000000;"></i>
</a>
    </div>
</header>
<div id="loadingSkeleton" class="slides-container" style="display: none;">
  <div class="slide-card skeleton">
    <div class="slide-thumbnail skeleton-item"></div>
    <div class="slide-info">
      <div class="skeleton-item" style="height: 20px; width: 80%; margin-bottom: 10px;"></div>
      <div class="skeleton-item" style="height: 16px; width: 60%; margin-bottom: 8px;"></div>
      <div class="skeleton-item" style="height: 14px; width: 90%; margin-bottom: 8px;"></div>
      <div class="skeleton-item" style="height: 14px; width: 70%; margin-bottom: 15px;"></div>
      <div class="skeleton-item" style="height: 14px; width: 30%;"></div>
    </div>
  </div>
  <!-- Repeat skeleton items -->
  <div class="slide-card skeleton">
    <div class="slide-thumbnail skeleton-item"></div>
    <div class="slide-info">
      <div class="skeleton-item" style="height: 20px; width: 80%; margin-bottom: 10px;"></div>
      <div class="skeleton-item" style="height: 16px; width: 60%; margin-bottom: 8px;"></div>
      <div class="skeleton-item" style="height: 14px; width: 90%; margin-bottom: 8px;"></div>
      <div class="skeleton-item" style="height: 14px; width: 70%; margin-bottom: 15px;"></div>
      <div class="skeleton-item" style="height: 14px; width: 30%;"></div>
    </div>
  </div>
</div>
<div class="container">
  <h1>Tài liệu - Slide phổ biến</h1>
  <div class="slides-container" id="slidesContainer">
    <c:forEach var="doc" items="${documents}">
      <div class="slide-card"
           data-title="${fn:toLowerCase(doc.title)}"
           data-author="${fn:toLowerCase(doc.author)}">
        <div class="slide-thumbnail">
          <img src="/uploads/${fn:replace(doc.thumbnailPath, ' ', '%20')}" alt="Thumbnail" />
        </div>
        <div class="slide-info">
          <div class="slide-title" data-filepath="${fn:escapeXml(doc.relativePath)}">${doc.title}</div>
          <div class="slide-author">Tác giả: ${doc.author}</div>
          <div class="slide-description">${doc.description}</div>
          <div class="slide-uploader">Uploaded by: ${doc.uploadedBy}</div>
          <div>
            <a href="/download?filePath=${fn:escapeXml(doc.relativePath)}" target="_blank">
              <i class="fas fa-download"></i> Download
            </a>
          </div>
          <div class="btn-group">
            <button class="edit-btn"
                    data-id="${doc.id}"
                    data-title="${fn:escapeXml(doc.title)}"
                    data-author="${fn:escapeXml(doc.author)}"
                    data-description="${fn:escapeXml(doc.description)}">
              <i class="fas fa-edit"></i> Sửa
            </button>
            <button class="delete-btn delete" data-id="${doc.id}">
              <i class="fas fa-trash"></i> Xoá
            </button>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<!-- Pagination -->
<c:if test="${totalPages > 1}">
  <ul class="pagination" style="margin-top: 30px; display: flex; justify-content: center; list-style: none; padding: 0;">
    <!-- Previous Button -->
    <c:choose>
      <c:when test="${currentPage > 1}">
        <li><a href="?page=${currentPage - 1}">&laquo;</a></li>
      </c:when>
      <c:otherwise>
        <li class="disabled"><span>&laquo;</span></li>
      </c:otherwise>
    </c:choose>

    <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
    <c:set var="endPage" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" />

    <!-- First Page -->
    <c:if test="${startPage > 1}">
      <li><a href="?page=1">1</a></li>
      <c:if test="${startPage > 2}">
        <li class="disabled"><span>...</span></li>
      </c:if>
    </c:if>

    <!-- Middle Pages -->
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
      <c:choose>
        <c:when test="${i == currentPage}">
          <li class="active"><span>${i}</span></li>
        </c:when>
        <c:otherwise>
          <li><a href="?page=${i}">${i}</a></li>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <c:if test="${endPage < totalPages}">
      <c:if test="${endPage < totalPages - 1}">
        <li class="disabled"><span>...</span></li>
      </c:if>
      <li><a href="?page=${totalPages}">${totalPages}</a></li>
    </c:if>

    <c:choose>
      <c:when test="${currentPage < totalPages}">
        <li><a href="?page=${currentPage + 1}">&raquo;</a></li>
      </c:when>
      <c:otherwise>
        <li class="disabled"><span>&raquo;</span></li>
      </c:otherwise>
    </c:choose>
  </ul>
</c:if>

<div id="uploadModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>Tải lên tài liệu</h2>
    <form id="uploadForm" action="/upload" method="post" enctype="multipart/form-data">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <div class="form-group">
        <label for="title">Tiêu đề:</label>
        <input type="text" id="title" name="title" required />
      </div>
      <div class="form-group">
        <label for="author">Tác giả:</label>
        <input type="text" id="author" name="author" required />
      </div>
      <div class="form-group">
        <label for="description">Mô tả:</label>
        <textarea id="description" name="description"></textarea>
      </div>

      <div class="form-group">
        <label for="file">Chọn tệp:</label>
        <input type="file" id="file" name="file" accept=".pdf,.ppt,.pptx,.doc,.docx" required />
      </div>
      <button type="submit" class="submit-btn">Tải lên</button>
    </form>
  </div>
</div>

<form id="logoutForm" action="/logout" method="post" style="display:none;">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

<div id="previewModal" class="modal">
  <div class="modal-content" style="width: 90%; height: 80vh; position: relative;">
    <span class="close-preview">&times;</span>
    <iframe id="previewFrame" src="" style="width: 100%; height: 100%;" frameborder="0"></iframe>

    <div id="unsupportedFileMessage" style="display: none; text-align: center; padding: 20px;">
      <i class="fas fa-exclamation-triangle" style="font-size: 48px; color: #ff9800; margin-bottom: 15px;"></i>
      <h3>Không thể xem trước loại file này</h3>
      <p>Chức năng xem trước hiện chỉ hỗ trợ file PDF. Vui lòng tải xuống để xem nội dung.</p>
      <button id="downloadFromPreview" class="submit-btn" style="margin-top: 15px;">
        <i class="fas fa-download"></i> Tải xuống
      </button>
    </div>
  </div>
</div>

<div id="editModal" class="modal">
  <div class="modal-content">
    <span class="close-edit">&times;</span>
    <h2>Sửa tài liệu</h2>
    <form id="editForm">
      <input type="hidden" id="edit-id" name="id" />
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <div class="form-group">
        <label for="edit-title">Tiêu đề:</label>
        <input type="text" id="edit-title" name="title" required />
      </div>
      <div class="form-group">
        <label for="edit-author">Tác giả:</label>
        <input type="text" id="edit-author" name="author" required />
      </div>
      <div class="form-group">
        <label for="edit-description">Mô tả:</label>
        <textarea id="edit-description" name="description"></textarea>
      </div>
      <button type="submit" class="submit-btn">Lưu thay đổi</button>
    </form>
  </div>
</div>
<script>
  // DOM Elements
  const uploadModal = document.getElementById("uploadModal");
  const editModal = document.getElementById("editModal");
  const previewModal = document.getElementById("previewModal");
  const previewFrame = document.getElementById("previewFrame");
  const unsupportedFileMessage = document.getElementById("unsupportedFileMessage");
  const downloadFromPreview = document.getElementById("downloadFromPreview");
  const searchInput = document.getElementById('searchInput');
  const slidesContainer = document.getElementById('slidesContainer');
  const loadingSkeleton = document.getElementById('loadingSkeleton');

  // Event Delegation for dynamic elements
  document.addEventListener('click', function(e) {
    // Upload Modal
    if (e.target.id === 'uploadBtn' || e.target.closest('#uploadBtn')) {
      uploadModal.style.display = 'block';
    }

    // Close Modals
    else if (e.target.classList.contains('close') || e.target.classList.contains('close-edit') ||
             e.target.classList.contains('close-preview')) {
      e.target.closest('.modal').style.display = 'none';
      if (e.target.classList.contains('close-preview')) {
        previewFrame.src = '';
        unsupportedFileMessage.style.display = 'none';
      }
    }

    // nút update
    else if (e.target.classList.contains('edit-btn') || e.target.closest('.edit-btn')) {
      const btn = e.target.classList.contains('edit-btn') ? e.target : e.target.closest('.edit-btn');
      document.getElementById("edit-id").value = btn.getAttribute("data-id");
      document.getElementById("edit-title").value = btn.getAttribute("data-title");
      document.getElementById("edit-author").value = btn.getAttribute("data-author");
      document.getElementById("edit-description").value = btn.getAttribute("data-description");
      editModal.style.display = "block";
    }

    // Nút delete
    else if (e.target.classList.contains('delete-btn') || e.target.closest('.delete-btn')) {
      const btn = e.target.classList.contains('delete-btn') ? e.target : e.target.closest('.delete-btn');
      if (confirm("Bạn có chắc muốn xoá tài liệu này không?")) {
        const id = btn.getAttribute("data-id");
        const csrfToken = document.querySelector('input[name="${_csrf.parameterName}"]').value;

        fetch('/documents/' + id, {
          method: 'DELETE',
          headers: { 'X-CSRF-TOKEN': csrfToken }
        })
        .then(response => {
          if(response.ok) {
            alert("Xoá thành công!");
            location.reload();
          } else {
            alert("Xoá thất bại.");
          }
        })
        .catch(() => alert("Lỗi khi xoá."));
      }
    }

    // Preview Documents
    else if (e.target.classList.contains('slide-title') || e.target.closest('.slide-title')) {
      const titleEl = e.target.classList.contains('slide-title') ? e.target : e.target.closest('.slide-title');
      const filePath = titleEl.getAttribute("data-filepath");
      if (!filePath) return;

      // Bỏ dấu / đầu nếu có
      const path = filePath.startsWith("/") ? filePath.substring(1) : filePath;

      // Encode từng phần của đường dẫn
      const encodedPath = filePath.split('/').map(encodeURIComponent).join('/');

      if (filePath.toLowerCase().endsWith(".pdf")) {
        previewFrame.src = "/uploads/" + encodedPath;
        unsupportedFileMessage.style.display = 'none';
        previewModal.style.display = "block";
      } else {
        previewFrame.src = '';
        unsupportedFileMessage.style.display = 'block';
        downloadFromPreview.onclick = () => {
          window.open("/download?filePath=" + encodedPath, '_blank');
        };
        previewModal.style.display = "block";
      }
    }
  });

  // Close modals when clicking outside
  window.addEventListener('click', event => {
    if (event.target == uploadModal) uploadModal.style.display = "none";
    if (event.target == editModal) editModal.style.display = "none";
    if (event.target == previewModal) {
      previewModal.style.display = "none";
      previewFrame.src = '';
      unsupportedFileMessage.style.display = 'none';
    }
  });

  // Logout
  document.getElementById('logoutBtn').addEventListener('click', function() {
    document.getElementById('logoutForm').submit();
  });

  // Submit Edit Form
  document.getElementById("editForm").onsubmit = function(e) {
    e.preventDefault();
    const id = document.getElementById("edit-id").value;
    const title = document.getElementById("edit-title").value;
    const author = document.getElementById("edit-author").value;
    const description = document.getElementById("edit-description").value;
    const csrfToken = document.querySelector('input[name="${_csrf.parameterName}"]').value;

    fetch('/documents/' + id, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': csrfToken
      },
      body: JSON.stringify({ title, author, description })
    })
    .then(response => {
      if(response.ok) {
        alert("Cập nhật thành công!");
        location.reload();
      } else {
        alert("Cập nhật thất bại.");
      }
    })
    .catch(() => alert("Lỗi khi cập nhật."));
  };

  // Search Functionality
  searchInput.addEventListener('input', () => {
    const filter = searchInput.value.toLowerCase();
    const cards = slidesContainer.querySelectorAll('.slide-card');

    showLoadingSkeleton();

    setTimeout(() => {
      cards.forEach(card => {
        const title = card.getAttribute('data-title') || '';
        const author = card.getAttribute('data-author') || '';
        if(title.includes(filter) || author.includes(filter)) {
          card.style.display = '';
        } else {
          card.style.display = 'none';
        }
      });
      hideLoadingSkeleton();
    }, 300);
  });

  // Theme Toggle
  const themeToggle = document.getElementById('themeToggle');
  const prefersDarkScheme = window.matchMedia('(prefers-color-scheme: dark)');
  const currentTheme = localStorage.getItem('theme');

  // Set initial theme
  if (currentTheme === 'dark' || (!currentTheme && prefersDarkScheme.matches)) {
    document.body.classList.add('dark-mode');
    themeToggle.innerHTML = '<i class="fas fa-sun"></i> <span>Light Mode</span>';
  } else {
    document.body.classList.remove('dark-mode');
    themeToggle.innerHTML = '<i class="fas fa-moon"></i> <span>Dark Mode</span>';
  }

  // Toggle theme
  themeToggle.addEventListener('click', () => {
    const isDark = document.body.classList.toggle('dark-mode');
    if (isDark) {
      themeToggle.innerHTML = '<i class="fas fa-sun"></i> <span>Light Mode</span>';
      localStorage.setItem('theme', 'dark');
    } else {
      themeToggle.innerHTML = '<i class="fas fa-moon"></i> <span>Dark Mode</span>';
      localStorage.setItem('theme', 'light');
    }
  });

  // Loading Skeleton Functions
  function showLoadingSkeleton() {
    slidesContainer.style.display = 'none';
    loadingSkeleton.style.display = 'grid';
  }

  function hideLoadingSkeleton() {
    slidesContainer.style.display = 'grid';
    loadingSkeleton.style.display = 'none';
  }


</script>
</body>
</html>
