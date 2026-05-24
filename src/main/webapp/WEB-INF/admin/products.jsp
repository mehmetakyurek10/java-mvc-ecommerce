<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="tr">

        <head>
            <meta charset="UTF-8">
            <title>Ürün Yönetimi</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body class="bg-light">

            <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
                <div class="container"><a class="navbar-brand"
                        href="${pageContext.request.contextPath}/admin/dashboard">Admin Panel - Ürünler</a></div>
            </nav>

            <div class="container-fluid px-4">
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
                                    <div class="mb-2"><label>Ürün Adı</label><input type="text" name="name"
                                            class="form-control" required></div>
                                    <div class="mb-2"><label>Açıklama</label><textarea name="description"
                                            class="form-control"></textarea></div>
                                    <div class="mb-2"><label>Fiyat (₺)</label><input type="number" step="0.01"
                                            name="price" class="form-control" required></div>
                                    <div class="mb-2"><label>Stok</label><input type="number" name="stock"
                                            class="form-control" required></div>
                                    <div class="mb-3"><label>Görsel URL</label><input type="text" name="imageUrl"
                                            class="form-control"></div>
                                    <div class="form-check mb-3"><input class="form-check-input" type="checkbox"
                                            name="isActive" checked><label>Aktif</label></div>
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
                                                <th>Fiyat</th>
                                                <th>Stok</th>
                                                <th>Durum</th>
                                                <th>İşlem</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="prod" items="${products}">
                                                <tr>
                                                    <td>${prod.id}</td>
                                                    <td>${prod.name}</td>
                                                    <td>${prod.price} ₺</td>
                                                    <td>${prod.stock}</td>
                                                    <td><span
                                                            class="badge ${prod.active ? 'bg-success' : 'bg-secondary'}">${prod.active
                                                            ? 'Aktif' : 'Pasif'}</span></td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/admin/products"
                                                            method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="${prod.id}">
                                                            <button type="submit" class="btn btn-sm btn-danger">Pasif
                                                                Yap</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>