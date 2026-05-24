<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="tr">

<head>
    <title>Sipariş Yönetimi</title>
    <jsp:include page="/WEB-INF/includes/head-common.jsp" />
</head>

<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-shield-lock"></i> Admin Panel - Siparişler
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/products">Ürünler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/categories">Kategoriler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/users">Kullanıcılar</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/">Siteye Dön</a></li>
            </ul>
        </div>
    </nav>

    <div class="container-fluid px-4">
        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Sipariş No</th>
                            <th>Müşteri Adı</th>
                            <th>Tarih</th>
                            <th>Tutar</th>
                            <th>Durum</th>
                            <th>Durum Güncelle</th>
                            <th>Detay</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td><strong>#${order.id}</strong></td>
                                <td>${order.customerName}</td>
                                <td>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" />
                                </td>
                                <td>
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                        currencySymbol="₺" />
                                </td>
                                <td>
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
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/orders"
                                        method="post" class="d-flex">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <select name="status" class="form-select form-select-sm me-2">
                                            <option value="BEKLEMEDE"
                                                ${order.status == 'BEKLEMEDE' ? 'selected' : ''}>Beklemede</option>
                                            <option value="HAZIRLANIYOR"
                                                ${order.status == 'HAZIRLANIYOR' ? 'selected' : ''}>Hazırlanıyor</option>
                                            <option value="KARGODA"
                                                ${order.status == 'KARGODA' ? 'selected' : ''}>Kargoda</option>
                                            <option value="TAMAMLANDI"
                                                ${order.status == 'TAMAMLANDI' ? 'selected' : ''}>Tamamlandı</option>
                                            <option value="IPTAL"
                                                ${order.status == 'IPTAL' ? 'selected' : ''}>İptal</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-primary">Kaydet</button>
                                    </form>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/order-detail?id=${order.id}"
                                        class="btn btn-sm btn-outline-info">
                                        <i class="bi bi-eye"></i> Detay
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>
