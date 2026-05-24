<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <title>Ürünler | E-Ticaret</title>
                <jsp:include page="/WEB-INF/includes/head-common.jsp" />
            </head>

            <body class="d-flex flex-column min-vh-100">

                <jsp:include page="/WEB-INF/includes/nav-customer.jsp" />

                <div class="container mt-5 flex-grow-1">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            <h3 class="mb-4">"${searchKeyword}" için arama sonuçları</h3>
                        </c:when>
                        <c:when test="${not empty selectedCategory}">
                            <h2 class="mb-4">${selectedCategory.name} Ürünleri</h2>
                        </c:when>
                        <c:otherwise>
                            <h2 class="mb-4">Tüm Ürünler</h2>
                        </c:otherwise>
                    </c:choose>

                    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:choose>
                            <c:when test="${empty products}">
                                <div class="col-12 text-center py-5">
                                    <i class="bi bi-box-seam display-1 text-muted"></i>
                                    <h4 class="mt-3">Ürün Bulunamadı</h4>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="product" items="${products}">
                                    <c:set var="canBuy" value="${product.active and product.stock > 0}" />
                                    <c:set var="isFav" value="${favoriteIds.contains(product.id)}" />
                                    <div class="col">
                                        <div class="card h-100 shadow-sm position-relative">
                                            <c:if test="${not empty sessionScope.user}">
                                                <form action="${pageContext.request.contextPath}/favorite-toggle"
                                                    method="post"
                                                    class="position-absolute top-0 start-0 m-2" style="z-index:2;">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <input type="hidden" name="redirect"
                                                        value="/products?page=${currentPage}${not empty selectedCategory ? '&category='.concat(selectedCategory.id) : ''}">
                                                    <button type="submit"
                                                        class="btn btn-sm ${isFav ? 'btn-danger' : 'btn-light'}"
                                                        title="${isFav ? 'Favoriden çıkar' : 'Favorilere ekle'}">
                                                        <i class="bi ${isFav ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${not product.active}">
                                                <span class="badge bg-secondary position-absolute top-0 end-0 m-2">Pasif</span>
                                            </c:if>
                                            <c:if test="${product.active and product.stock == 0}">
                                                <span class="badge bg-danger position-absolute top-0 end-0 m-2">Stokta Yok</span>
                                            </c:if>
                                            <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}"
                                                style="height: 200px; object-fit: cover; background:#e9ecef; ${not canBuy ? 'opacity:.55;' : ''}"
                                                onerror="this.onerror=null;this.src='data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 300 200%22><rect width=%22300%22 height=%22200%22 fill=%22%23e9ecef%22/><text x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dominant-baseline=%22middle%22 fill=%22%236c757d%22 font-family=%22sans-serif%22 font-size=%2218%22>Görsel Yok</text></svg>'">
                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-title">${product.name}</h5>
                                                <h6 class="text-primary fw-bold mb-3">
                                                    <fmt:formatNumber value="${product.price}" type="currency"
                                                        currencySymbol="₺" />
                                                </h6>
                                                <div class="mt-auto d-flex gap-2">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                                                        class="btn btn-outline-primary w-100">İncele</a>
                                                    <c:choose>
                                                        <c:when test="${canBuy}">
                                                            <form action="${pageContext.request.contextPath}/cart" method="post"
                                                                class="w-100">
                                                                <input type="hidden" name="action" value="add">
                                                                <input type="hidden" name="productId" value="${product.id}">
                                                                <input type="hidden" name="quantity" value="1">
                                                                <button type="submit" class="btn btn-primary w-100">
                                                                    <i class="bi bi-cart-plus"></i> Ekle
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn btn-secondary w-100" disabled>
                                                                <c:choose>
                                                                    <c:when test="${not product.active}">Yayında Değil</c:when>
                                                                    <c:otherwise>Stokta Yok</c:otherwise>
                                                                </c:choose>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${totalPages > 1}">
                        <nav class="mt-5">
                            <c:set var="qBase" value="${not empty selectedCategory ? '&category='.concat(selectedCategory.id) : ''}" />
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link"
                                        href="${pageContext.request.contextPath}/products?page=${currentPage - 1}${qBase}">
                                        ← Önceki
                                    </a>
                                </li>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link"
                                            href="${pageContext.request.contextPath}/products?page=${i}${qBase}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link"
                                        href="${pageContext.request.contextPath}/products?page=${currentPage + 1}${qBase}">
                                        Sonraki →
                                    </a>
                                </li>
                            </ul>
                            <p class="text-center text-muted small">
                                Toplam ${totalProducts} ürün — Sayfa ${currentPage} / ${totalPages}
                            </p>
                        </nav>
                    </c:if>
                </div>

                <footer class="bg-dark text-white text-center py-3 mt-auto">
                    <p class="mb-0">&copy; 2026 E-Ticaret Portalı.</p>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>