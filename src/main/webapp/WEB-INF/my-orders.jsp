<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <title>Siparişlerim | E-Ticaret</title>
                <jsp:include page="/WEB-INF/includes/head-common.jsp" />
            </head>

            <body class="d-flex flex-column min-vh-100">

                <jsp:include page="/WEB-INF/includes/nav-customer.jsp" />

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
                                                    <th>Detay</th>
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
                                                                <c:when test="${order.status == 'HAZIRLANIYOR'}">
                                                                    <span class="badge bg-primary"><i
                                                                            class="bi bi-box-seam"></i>
                                                                        Hazırlanıyor</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'KARGODA'}">
                                                                    <span class="badge bg-info text-dark"><i
                                                                            class="bi bi-truck"></i> Kargoda</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'TAMAMLANDI'}">
                                                                    <span class="badge bg-success"><i
                                                                            class="bi bi-check-circle"></i>
                                                                        Tamamlandı</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'IPTAL'}">
                                                                    <span class="badge bg-danger"><i
                                                                            class="bi bi-x-circle"></i> İptal</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-secondary">${order.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/my-order-detail?id=${order.id}"
                                                                class="btn btn-sm btn-outline-primary">
                                                                <i class="bi bi-eye"></i> Detay
                                                            </a>
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