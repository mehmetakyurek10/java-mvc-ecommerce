<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <meta charset="UTF-8">
                <title>Sepetim | E-Ticaret</title>
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
                                <li class="nav-item"><a class="nav-link"
                                        href="${pageContext.request.contextPath}/products">Alışverişe Devam Et</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="container mt-5 flex-grow-1">
                    <h2 class="mb-4"><i class="bi bi-cart"></i> Alışveriş Sepetim</h2>

                    <c:if test="${param.error == 'system_error'}">
                        <div class="alert alert-danger">Siparişiniz oluşturulurken sistemsel bir hata meydana geldi.
                            Lütfen tekrar deneyin.</div>
                    </c:if>
                    <c:if test="${param.error == 'order_failed'}">
                        <div class="alert alert-warning">Siparişiniz oluşturulamadı. Ürün stoklarını kontrol edip tekrar
                            deneyin.</div>
                    </c:if>

                    <c:choose>
                        <c:when test="${empty sessionScope.cart}">
                            <div class="text-center py-5">
                                <i class="bi bi-cart-x display-1 text-muted"></i>
                                <h4 class="mt-3">Sepetiniz şu an boş.</h4>
                                <p class="text-muted">Görünüşe göre henüz sepetinize bir ürün eklemediniz.</p>
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-2">Hemen
                                    Alışverişe Başla</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Ürün</th>
                                            <th>Birim Fiyat</th>
                                            <th style="width: 15%;">Adet</th>
                                            <th>Ara Toplam</th>
                                            <th>İşlem</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="totalSum" value="0" />
                                        <c:forEach var="item" items="${sessionScope.cart}">
                                            <tr>
                                                <td>
                                                    <h6 class="mb-0">${item.product.name}</h6>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${item.product.price}" type="currency"
                                                        currencySymbol="₺" />
                                                </td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/cart" method="post"
                                                        class="d-flex">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="productId"
                                                            value="${item.product.id}">
                                                        <input type="number" name="quantity" value="${item.quantity}"
                                                            min="1" max="${item.product.stock}"
                                                            class="form-control form-control-sm me-2">
                                                        <button type="submit"
                                                            class="btn btn-sm btn-outline-secondary"><i
                                                                class="bi bi-arrow-repeat"></i></button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <strong>
                                                        <fmt:formatNumber value="${item.subtotal}" type="currency"
                                                            currencySymbol="₺" />
                                                    </strong>
                                                </td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/cart"
                                                        method="post">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="productId"
                                                            value="${item.product.id}">
                                                        <button type="submit" class="btn btn-sm btn-danger"><i
                                                                class="bi bi-trash"></i></button>
                                                    </form>
                                                </td>
                                            </tr>
                                            <c:set var="totalSum" value="${totalSum + item.subtotal}" />
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="row justify-content-end mt-4">
                                <div class="col-md-4">
                                    <div class="card shadow-sm border-primary">
                                        <div class="card-body">
                                            <h5 class="card-title mb-3">Sipariş Özeti</h5>
                                            <div class="d-flex justify-content-between mb-3">
                                                <span>Genel Toplam:</span>
                                                <strong class="fs-4 text-primary">
                                                    <fmt:formatNumber value="${totalSum}" type="currency"
                                                        currencySymbol="₺" />
                                                </strong>
                                            </div>

                                            <form action="${pageContext.request.contextPath}/order" method="post">
                                                <button type="submit" class="btn btn-primary btn-lg w-100">
                                                    <i class="bi bi-credit-card"></i> Siparişi Tamamla
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <footer class="bg-dark text-white text-center py-3 mt-auto">
                    <p class="mb-0">&copy; 2026 E-Ticaret Portalı.</p>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>