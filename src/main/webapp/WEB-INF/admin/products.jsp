<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="tr">

<head>
    <title>Ürün Yönetimi</title>
    <jsp:include page="/WEB-INF/includes/head-common.jsp" />
</head>

<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-shield-lock"></i> Admin Panel - Ürünler
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/categories">Kategoriler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/orders">Siparişler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/">Siteye Dön</a></li>
            </ul>
        </div>
    </nav>

    <div class="container-fluid px-4">
        <c:if test="${param.msg == 'deleted'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle"></i> Ürün kalıcı olarak silindi.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.error == 'hasOrders'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle"></i> Bu ürün geçmiş siparişlerde kullanıldığı için kalıcı olarak silinemez. Onun yerine "Pasif Yap" seçeneğini kullanabilirsiniz.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.error == 'deleteFailed'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-x-circle"></i> Ürün silinemedi.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.error == 'invalid'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-x-circle"></i> Geçersiz ürün bilgisi.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <div class="row">
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <div class="card-header">Yeni Ürün Ekle</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/products" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-2"><label>Kategori</label>
                                <select name="categoryId" class="form-select" required>
                                    <c:forEach var="cat" items="${categories}">
                                        <c:if test="${cat.active}">
                                            <option value="${cat.id}">${cat.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-2"><label>Ürün Adı</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                            <div class="mb-2"><label>Açıklama</label>
                                <textarea name="description" class="form-control"></textarea>
                            </div>
                            <div class="mb-2"><label>Fiyat (₺)</label>
                                <input type="number" step="0.01" min="0.01" name="price" class="form-control" required>
                            </div>
                            <div class="mb-2"><label>Stok</label>
                                <input type="number" min="0" name="stock" class="form-control" required>
                            </div>
                            <div class="mb-3"><label>Görsel URL</label>
                                <input type="text" name="imageUrl" class="form-control">
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="isActive" id="addActive" checked>
                                <label class="form-check-label" for="addActive">Aktif</label>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Ürünü Kaydet</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-9">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Adı</th>
                                        <th>Kategori</th>
                                        <th>Fiyat</th>
                                        <th>Stok</th>
                                        <th>Durum</th>
                                        <th style="width: 220px;">İşlem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="prod" items="${products}">
                                        <tr>
                                            <td>${prod.id}</td>
                                            <td>${prod.name}</td>
                                            <td>
                                                <c:forEach var="cat" items="${categories}">
                                                    <c:if test="${cat.id == prod.categoryId}">${cat.name}</c:if>
                                                </c:forEach>
                                            </td>
                                            <td>${prod.price} ₺</td>
                                            <td>
                                                <span class="badge ${prod.stock == 0 ? 'bg-danger' : (prod.stock < 5 ? 'bg-warning text-dark' : 'bg-success')}">
                                                    ${prod.stock}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge ${prod.active ? 'bg-success' : 'bg-secondary'}">
                                                    ${prod.active ? 'Aktif' : 'Pasif'}
                                                </span>
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-primary"
                                                    data-bs-toggle="modal" data-bs-target="#editModal${prod.id}">
                                                    <i class="bi bi-pencil"></i> Düzenle
                                                </button>
                                                <c:if test="${prod.active}">
                                                    <form action="${pageContext.request.contextPath}/admin/products"
                                                        method="post" style="display:inline;"
                                                        onsubmit="return confirm('Ürün pasif yapılacak. Emin misin?');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${prod.id}">
                                                        <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                            <i class="bi bi-eye-slash"></i> Pasif Yap
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <form action="${pageContext.request.contextPath}/admin/products"
                                                    method="post" style="display:inline;"
                                                    onsubmit="return confirm('Bu ürün KALICI olarak silinecek. Geri alınamaz! (Siparişlerde kullanıldıysa silinemez.) Devam edilsin mi?');">
                                                    <input type="hidden" name="action" value="hardDelete">
                                                    <input type="hidden" name="id" value="${prod.id}">
                                                    <button type="submit" class="btn btn-sm btn-danger">
                                                        <i class="bi bi-trash"></i> Sil
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>

                                        <div class="modal fade" id="editModal${prod.id}" tabindex="-1">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <form action="${pageContext.request.contextPath}/admin/products"
                                                        method="post">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Ürünü Düzenle — #${prod.id} ${prod.name}</h5>
                                                            <button type="button" class="btn-close"
                                                                data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="id" value="${prod.id}">
                                                            <div class="row g-3">
                                                                <div class="col-md-6">
                                                                    <label class="form-label">Kategori</label>
                                                                    <select name="categoryId" class="form-select" required>
                                                                        <c:forEach var="cat" items="${categories}">
                                                                            <option value="${cat.id}"
                                                                                ${cat.id == prod.categoryId ? 'selected' : ''}>
                                                                                ${cat.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label class="form-label">Ürün Adı</label>
                                                                    <input type="text" name="name" class="form-control"
                                                                        value="${prod.name}" required>
                                                                </div>
                                                                <div class="col-12">
                                                                    <label class="form-label">Açıklama</label>
                                                                    <textarea name="description" class="form-control"
                                                                        rows="2">${prod.description}</textarea>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <label class="form-label">Fiyat (₺)</label>
                                                                    <input type="number" step="0.01" min="0.01"
                                                                        name="price" class="form-control"
                                                                        value="${prod.price}" required>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <label class="form-label">Stok</label>
                                                                    <input type="number" min="0" name="stock"
                                                                        class="form-control" value="${prod.stock}"
                                                                        required>
                                                                </div>
                                                                <div class="col-md-4 d-flex align-items-end">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox"
                                                                            name="isActive" id="edit${prod.id}Active"
                                                                            ${prod.active ? 'checked' : ''}>
                                                                        <label class="form-check-label"
                                                                            for="edit${prod.id}Active">Aktif</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-12">
                                                                    <label class="form-label">Görsel URL</label>
                                                                    <input type="text" name="imageUrl"
                                                                        class="form-control" value="${prod.imageUrl}">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary"
                                                                data-bs-dismiss="modal">İptal</button>
                                                            <button type="submit" class="btn btn-primary">
                                                                <i class="bi bi-save"></i> Kaydet
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
