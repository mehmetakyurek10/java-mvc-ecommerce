<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <meta charset="UTF-8">
                <title>Siparişlerim | E-Ticaret</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            </head>

            <body class="d-flex flex-column min-vh-100">

                <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/">E-Ticaret</a>
                        <div class="collapse navbar-collapse">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Ana
                                        Sayfa</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="${pageContext.request.contextPath}/products">Tüm Ürünler</a></li>
                            </ul>
                            <ul class="navbar-nav ms-auto">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle active" href="#" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                            <li><a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/admin/dashboard">Yönetim
                                                    Paneli</a></li>
                                        </c:if>
                                        <li><a class="dropdown-item active"
                                                href="${pageContext.request.contextPath}/my-orders">Siparişlerim</a>
                                        </li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li><a class="dropdown-item text-danger"
                                                href="${pageContext.request.contextPath}/logout">Çıkış Yap</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="container mt-5 flex-grow-1">
                    <h2 class="mb-4"><i class="bi bi-box-seam"></i> Geçmiş Siparişlerim</h2>

                    <c:if test="${param.success == 'true'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill"></i> Siparişiniz başarıyla oluşturuldu! Teşekkür ederiz.
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card shadow-sm">
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <div class="text-center py-4">
                                        <i class="bi bi-receipt display-4 text-muted"></i>
                                        <h5 class="mt-3">Henüz bir siparişiniz bulunmuyor.</h5>
                                        <a href="${pageContext.request.contextPath}/products"
                                            class="btn btn-primary mt-2">Alışverişe Başla</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Sipariş No</th>
                                                    <th>Tarih</th>
                                                    <th>Toplam Tutar</th>
                                                    <th>Durum</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td><strong>#${order.id}</strong></td>
                                                        <td>
                                                            <fmt:formatDate value="${order.orderDate}"
                                                                pattern="dd.MM.yyyy HH:mm" />
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${order.totalAmount}"
                                                                type="currency" currencySymbol="₺" />
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${order.status == 'BEKLEMEDE'}">
                                                                    <span class="badge bg-warning text-dark"><i
                                                                            class="bi bi-hourglass-split"></i>
                                                                        Beklemede</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'ONAYLANDI'}">
                                                                    <span class="badge bg-success"><i
                                                                            class="bi bi-check-circle"></i>
                                                                        Onaylandı</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'KARGOYA VERİLDİ'}">
                                                                    <span class="badge bg-info text-dark"><i
                                                                            class="bi bi-truck"></i> Kargoda</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'İPTAL EDİLDİ'}">
                                                                    <span class="badge bg-danger"><i
                                                                            class="bi bi-x-circle"></i> İptal</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-secondary">${order.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <footer class="bg-dark text-white text-center py-3 mt-auto">
                    <p class="mb-0">&copy; 2026 E-Ticaret Portalı.</p>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>