<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="tr">

<head>
    <title>Sipariş #${order.id}</title>
    <jsp:include page="/WEB-INF/includes/head-common.jsp" />
</head>

<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-shield-lock"></i> Admin Panel
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/orders">← Tüm Siparişler</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-white">
                <h4 class="mb-0">Sipariş #${order.id}</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Müşteri:</strong> ${order.customerName}</p>
                        <p><strong>Tarih:</strong>
                            <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" />
                        </p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p><strong>Durum:</strong> <span class="badge bg-info text-dark">${order.status}</span></p>
                        <p class="h4 text-primary"><strong>
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" />
                            </strong></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white">
                <h5 class="mb-0">Sipariş Kalemleri</h5>
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
</body>

</html>
