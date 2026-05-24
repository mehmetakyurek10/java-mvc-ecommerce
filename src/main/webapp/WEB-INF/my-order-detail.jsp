<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="tr">

<head>
    <title>Sipariş #${order.id} | E-Ticaret</title>
    <jsp:include page="/WEB-INF/includes/head-common.jsp" />
</head>

<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/WEB-INF/includes/nav-customer.jsp" />

    <div class="container mt-5 flex-grow-1">
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-white">
                <h4 class="mb-0"><i class="bi bi-receipt"></i> Sipariş #${order.id}</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Tarih:</strong>
                            <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" />
                        </p>
                        <p><strong>Durum:</strong>
                            <c:choose>
                                <c:when test="${order.status == 'BEKLEMEDE'}">
                                    <span class="badge bg-warning text-dark">Beklemede</span>
                                </c:when>
                                <c:when test="${order.status == 'HAZIRLANIYOR'}">
                                    <span class="badge bg-primary">Hazırlanıyor</span>
                                </c:when>
                                <c:when test="${order.status == 'KARGODA'}">
                                    <span class="badge bg-info text-dark">Kargoda</span>
                                </c:when>
                                <c:when test="${order.status == 'TAMAMLANDI'}">
                                    <span class="badge bg-success">Tamamlandı</span>
                                </c:when>
                                <c:when test="${order.status == 'IPTAL'}">
                                    <span class="badge bg-danger">İptal</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${order.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="h4 text-primary"><strong>
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" />
                            </strong></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white">
                <h5 class="mb-0">Sipariş İçeriği</h5>
            </div>
            <div class="card-body">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Ürün</th>
                            <th class="text-end">Birim Fiyat</th>
                            <th class="text-center">Adet</th>
                            <th class="text-end">Ara Toplam</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>${item.productName}</td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₺" />
                                </td>
                                <td class="text-center">${item.quantity}</td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr class="table-light">
                            <th colspan="3" class="text-end">Genel Toplam</th>
                            <th class="text-end">
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" />
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-0">&copy; 2026 E-Ticaret Portalı.</p>
    </footer>
</body>

</html>
