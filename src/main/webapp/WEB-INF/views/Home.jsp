

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

    /* Header */
    header {
      background-color: white; padding: 15px 20px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      display: flex; justify-content: space-between; align-items: center;
    }
    .logo { font-size: 24px; font-weight: bold; color: #0099cc; }
    .search-bar { flex-grow: 1; margin: 0 20px; }
    .search-bar input {
      width: 100%; max-width: 500px; padding: 8px 15px;
      border: 1px solid #ddd; border-radius: 20px;
    }
    .user-actions a { margin-left: 15px; text-decoration: none; color: #333; }

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
      background-color: white; border-radius: 5px; overflow: hidden;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      display: flex; flex-direction: column;
      height: 100%;
    }

    .slide-thumbnail {
      height: 180px;
      background-color: #eee;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .slide-thumbnail img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
    }

    .slide-info {
      padding: 15px; flex-grow: 1; display: flex; flex-direction: column;
    }

    .slide-title {
      font-weight: bold; margin-bottom: 5px; color: #333;
      word-break: break-word;
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
      font-weight: bold;
    }
    .slide-info a:hover { text-decoration: underline; }

    /* Buttons edit/delete */
    .btn-group {
      margin-top: 10px;
    }
    .btn-group button {
      background-color: #0099cc;
      border: none;
      color: white;
      padding: 6px 12px;
      margin-right: 10px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }
    .btn-group button.delete {
      background-color: #cc0000;
    }
    .btn-group button:hover {
      opacity: 0.85;
    }

    /* Modal */
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
    .close, .close-edit {
      color: #aaa; float: right;
      font-size: 28px; font-weight: bold;
      cursor: pointer;
      position: absolute;
      right: 15px;
      top: 10px;
    }
    .close:hover, .close-edit:hover {
      color: black;
    }

    /* Form styles */
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
      background-color: #0099cc;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
    .submit-btn:hover {
      background-color: #0077aa;
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

  </style>
</head>
<body>
<header>
  <div class="logo">Ruler Document</div>
  <div class="search-bar">
    <input type="text" placeholder="Tìm kiếm slides, tác giả..." id="searchInput" />
  </div>
  <div class="user-actions">
    <a href="#" id="uploadBtn">Tải lên</a>
  </div>
</header>

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
          <div class="slide-title">${doc.title}</div>
          <div class="slide-author">Tác giả: ${doc.author}</div>
          <div class="slide-description">${doc.description}</div>
          <div class="slide-uploader">Uploaded by: ${doc.uploadedBy}</div>
          <div>
            <a href="/download?filePath=${fn:escapeXml(doc.filePath)}" target="_blank">Download</a>
          </div>
          <div class="btn-group">
            <button class="edit-btn"
              data-id="${doc.id}"
              data-title="${fn:escapeXml(doc.title)}"
              data-author="${fn:escapeXml(doc.author)}"
              data-description="${fn:escapeXml(doc.description)}"
            >Sửa</button>
            <button class="delete-btn delete" data-id="${doc.id}">Xoá</button>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
<!-- Pagination -->
<c:if test="${totalPages > 1}">
  <ul class="pagination" style="margin-top: 30px; display: flex; justify-content: center; list-style: none; padding: 0;">
    <!-- Nút Previous -->
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

    <!-- Trang đầu tiên -->
    <c:if test="${startPage > 1}">
      <li><a href="?page=1">1</a></li>
      <c:if test="${startPage > 2}">
        <li class="disabled"><span>...</span></li>
      </c:if>
    </c:if>

    <!-- Các trang chính giữa -->
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

    <!-- Trang cuối cùng -->
    <c:if test="${endPage < totalPages}">
      <c:if test="${endPage < totalPages - 1}">
        <li class="disabled"><span>...</span></li>
      </c:if>
      <li><a href="?page=${totalPages}">${totalPages}</a></li>
    </c:if>

    <!-- Nút Next -->
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

<!-- Upload Modal -->
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
        <input type="file" id="file" name="file" accept=".pdf,.ppt,.pptx,.doc,.docx" required />
      </div>
      <button type="submit" class="submit-btn">Tải lên</button>
    </form>
  </div>
</div>

<!-- Edit Modal -->
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
  // Upload Modal
  var modal = document.getElementById("uploadModal");
  var btn = document.getElementById("uploadBtn");
  var span = document.getElementsByClassName("close")[0];

  btn.onclick = function() { modal.style.display = "block"; }
  span.onclick = function() { modal.style.display = "none"; }
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }

  // Edit Modal
  var editModal = document.getElementById("editModal");
  var editForm = document.getElementById("editForm");
  var closeEdit = document.getElementsByClassName("close-edit")[0];

  document.querySelectorAll(".edit-btn").forEach(btn => {
    btn.onclick = function() {
      var id = this.getAttribute("data-id");
      var title = this.getAttribute("data-title");
      var author = this.getAttribute("data-author");
      var description = this.getAttribute("data-description");

      document.getElementById("edit-id").value = id;
      document.getElementById("edit-title").value = title;
      document.getElementById("edit-author").value = author;
      document.getElementById("edit-description").value = description;

      editModal.style.display = "block";
    }
  });

  closeEdit.onclick = function() {
    editModal.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == editModal) {
      editModal.style.display = "none";
    }
  }

  // Submit edit form
  editForm.onsubmit = function(e) {
    e.preventDefault();
    var id = document.getElementById("edit-id").value;
    var title = document.getElementById("edit-title").value;
    var author = document.getElementById("edit-author").value;
    var description = document.getElementById("edit-description").value;
    var csrfToken = document.querySelector('input[name="${_csrf.parameterName}"]').value;

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

  // Delete buttons
  document.querySelectorAll(".delete-btn").forEach(btn => {
    btn.onclick = function() {
      if (confirm("Bạn có chắc muốn xoá tài liệu này không?")) {
        var id = this.getAttribute("data-id");
        var csrfToken = document.querySelector('input[name="${_csrf.parameterName}"]').value;

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
  });

  // Search filter
  var searchInput = document.getElementById('searchInput');
  var slidesContainer = document.getElementById('slidesContainer');

 searchInput.addEventListener('input', function() {
   var filter = this.value.toLowerCase();
   var cards = slidesContainer.querySelectorAll('.slide-card');
   cards.forEach(card => {
     var title = card.getAttribute('data-title') || '';
     var author = card.getAttribute('data-author') || '';
     console.log('Filter:', filter, 'Title:', title, 'Author:', author);
     if(title.includes(filter) || author.includes(filter)) {
       card.style.display = '';
     } else {
       card.style.display = 'none';
     }
   });
 });

</script>
</body>
</html>
