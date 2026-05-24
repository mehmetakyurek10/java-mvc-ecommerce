<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="tr">

        <head>
            <meta charset="UTF-8">
            <title>Kategori Yönetimi</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body class="bg-light">

            <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
                <div class="container"><a class="navbar-brand"
                        href="${pageContext.request.contextPath}/admin/dashboard">Admin Panel - Kategoriler</a></div>
            </nav>

            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card shadow-sm">
                            <div class="card-header">Yeni Kategori Ekle</div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <div class="mb-3"><label>Kategori Adı</label><input type="text" name="name"
                                            class="form-control" required></div>
                                    <div class="mb-3"><label>Açıklama</label><textarea name="description"
                                            class="form-control"></textarea></div>
                                    <div class="form-check mb-3"><input class="form-check-input" type="checkbox"
                                            name="isActive" checked><label class="form-check-label">Aktif</label></div>
                                    <button type="submit" class="btn btn-primary w-100">Ekle</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Adı</th>
                                            <th>Durum</th>
                                            <th>İşlem</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cat" items="${categories}">
                                            <tr>
                                                <td>${cat.id}</td>
                                                <td>${cat.name}</td>
                                                <td><span
                                                        class="badge ${cat.active ? 'bg-success' : 'bg-secondary'}">${cat.active
                                                        ? 'Aktif' : 'Pasif'}</span></td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/admin/categories"
                                                        method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${cat.id}">
                                                        <button type="submit" class="btn btn-sm btn-danger">Pasife
                                                            Al</button>
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
        </body>

        </html>