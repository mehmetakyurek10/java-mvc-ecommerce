<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <meta charset="UTF-8">
                <title>Sipariş Yönetimi</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body class="bg-light">

                <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
                    <div class="container"><a class="navbar-brand"
                            href="${pageContext.request.contextPath}/admin/dashboard">Admin Panel - Siparişler</a></div>
                </nav>

                <div class="container">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <table class="table table-hover align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Sipariş No</th>
                                        <th>Müşteri ID</th>
                                        <th>Tarih</th>
                                        <th>Tutar</th>
                                        <th>Güncel Durum</th>
                                        <th>Durum Güncelle</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td><strong>#${order.id}</strong></td>
                                            <td>${order.userId}</td>
                                            <td>
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" />
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                                    currencySymbol="₺" />
                                            </td>
                                            <td><span class="badge bg-secondary">${order.status}</span></td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/admin/orders"
                                                    method="post" class="d-flex">
                                                    <input type="hidden" name="action" value="updateStatus">
                                                    <input type="hidden" name="orderId" value="${order.id}">
                                                    <select name="status" class="form-select form-select-sm me-2">
                                                        <option value="BEKLEMEDE" ${order.status=='BEKLEMEDE'
                                                            ? 'selected' : '' }>Beklemede</option>
                                                        <option value="ONAYLANDI" ${order.status=='ONAYLANDI'
                                                            ? 'selected' : '' }>Onaylandı</option>
                                                        <option value="KARGOYA VERİLDİ"
                                                            ${order.status=='KARGOYA VERİLDİ' ? 'selected' : '' }>
                                                            Kargoya Verildi</option>
                                                        <option value="İPTAL EDİLDİ" ${order.status=='İPTAL EDİLDİ'
                                                            ? 'selected' : '' }>İptal Edildi</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-sm btn-primary">Kaydet</button>
                                                </form>
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