<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="tr">

<head>
    <title>Kategori Yönetimi</title>
    <jsp:include page="/WEB-INF/includes/head-common.jsp" />
</head>

<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-shield-lock"></i> Admin Panel - Kategoriler
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/products">Ürünler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/orders">Siparişler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/users">Kullanıcılar</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/">Siteye Dön</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <c:if test="${param.msg == 'deleted'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle"></i> Kategori kalıcı olarak silindi.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.error == 'hasProducts'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle"></i> Bu kategoriye bağlı ürünler olduğu için kalıcı olarak silinemez. Önce ürünleri silin veya başka kategoriye taşıyın; ya da "Pasif" seçeneğini kullanın.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.error == 'deleteFailed'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-x-circle"></i> Kategori silinemedi.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.error == 'invalid'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-x-circle"></i> Geçersiz kategori bilgisi.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <div class="card-header">Yeni Kategori Ekle</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3">
                                <label class="form-label">Kategori Adı</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Açıklama</label>
                                <textarea name="description" class="form-control"></textarea>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="isActive" id="addCatActive" checked>
                                <label class="form-check-label" for="addCatActive">Aktif</label>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Ekle</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Adı</th>
                                    <th>Açıklama</th>
                                    <th>Durum</th>
                                    <th style="width: 220px;">İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cat" items="${categories}">
                                    <tr>
                                        <td>${cat.id}</td>
                                        <td>${cat.name}</td>
                                        <td class="text-muted small">${cat.description}</td>
                                        <td>
                                            <span class="badge ${cat.active ? 'bg-success' : 'bg-secondary'}">
                                                ${cat.active ? 'Aktif' : 'Pasif'}
                                            </span>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-primary"
                                                data-bs-toggle="modal" data-bs-target="#editCat${cat.id}">
                                                <i class="bi bi-pencil"></i> Düzenle
                                            </button>
                                            <c:if test="${cat.active}">
                                                <form action="${pageContext.request.contextPath}/admin/categories"
                                                    method="post" style="display:inline;"
                                                    onsubmit="return confirm('Kategori pasif yapılacak. Emin misin?');">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${cat.id}">
                                                    <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                        <i class="bi bi-eye-slash"></i> Pasif
                                                    </button>
                                                </form>
                                            </c:if>
                                            <form action="${pageContext.request.contextPath}/admin/categories"
                                                method="post" style="display:inline;"
                                                onsubmit="return confirm('Bu kategori KALICI olarak silinecek. Geri alınamaz! (İçinde ürün varsa silinemez.) Devam edilsin mi?');">
                                                <input type="hidden" name="action" value="hardDelete">
                                                <input type="hidden" name="id" value="${cat.id}">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="bi bi-trash"></i> Sil
                                                </button>
                                            </form>
                                        </td>
                                    </tr>

                                    <div class="modal fade" id="editCat${cat.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <form action="${pageContext.request.contextPath}/admin/categories"
                                                    method="post">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Kategoriyi Düzenle — #${cat.id}</h5>
                                                        <button type="button" class="btn-close"
                                                            data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="id" value="${cat.id}">
                                                        <div class="mb-3">
                                                            <label class="form-label">Kategori Adı</label>
                                                            <input type="text" name="name" class="form-control"
                                                                value="${cat.name}" required>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Açıklama</label>
                                                            <textarea name="description"
                                                                class="form-control" rows="3">${cat.description}</textarea>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox"
                                                                name="isActive" id="editCat${cat.id}Active"
                                                                ${cat.active ? 'checked' : ''}>
                                                            <label class="form-check-label"
                                                                for="editCat${cat.id}Active">Aktif</label>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
