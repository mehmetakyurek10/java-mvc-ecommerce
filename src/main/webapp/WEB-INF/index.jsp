<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <title>Ana Sayfa | E-Ticaret</title>
                <jsp:include page="/WEB-INF/includes/head-common.jsp" />
            </head>

            <body>

                <jsp:include page="/WEB-INF/includes/nav-customer.jsp" />

                <div class="container mt-5 mb-5">

                    <div class="hero-gradient text-center mb-5">
                        <h1 class="display-4 mb-3">Hoş Geldiniz <i class="bi bi-stars"></i></h1>
                        <p class="col-md-8 fs-5 mx-auto mb-4" style="opacity:.9;">En yeni teknolojiler ve trend
                            ürünler en uygun fiyatlarla burada.</p>
                        <a href="${pageContext.request.contextPath}/products"
                            class="btn btn-light btn-lg fw-semibold px-4">
                            <i class="bi bi-bag-heart"></i> Ürünleri İncele
                        </a>
                    </div>

                    <h2 class="mb-4">Öne Çıkan Ürünler</h2>

                    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="product" items="${products}">
                            <c:set var="isFav" value="${favoriteIds.contains(product.id)}" />
                            <div class="col">
                                <div class="card h-100 shadow-sm position-relative">
                                    <c:if test="${not empty sessionScope.user}">
                                        <form action="${pageContext.request.contextPath}/favorite-toggle"
                                            method="post"
                                            class="position-absolute top-0 start-0 m-2" style="z-index:2;">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            <input type="hidden" name="redirect" value="/">
                                            <button type="submit"
                                                class="btn btn-sm ${isFav ? 'btn-danger' : 'btn-light'}"
                                                title="${isFav ? 'Favoriden çıkar' : 'Favorilere ekle'}">
                                                <i class="bi ${isFav ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                    <img src="${product.imageUrl}"
                                        class="card-img-top" alt="${product.name}"
                                        style="height: 200px; object-fit: cover; background:#e9ecef;"
                                        onerror="this.onerror=null;this.src='data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 300 200%22><rect width=%22300%22 height=%22200%22 fill=%22%23e9ecef%22/><text x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dominant-baseline=%22middle%22 fill=%22%236c757d%22 font-family=%22sans-serif%22 font-size=%2218%22>Görsel Yok</text></svg>'">

                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text text-muted small">${product.description}</p>

                                        <p class="small mb-2">
                                            <c:choose>
                                                <c:when test="${product.stock > 0}">
                                                    <span class="text-success"><i class="bi bi-check-circle"></i>
                                                        Stokta (${product.stock} adet)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger"><i class="bi bi-x-circle"></i>
                                                        Stokta Yok</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>

                                        <h5 class="text-success mt-auto mb-3">
                                            <fmt:formatNumber value="${product.price}" type="currency"
                                                currencySymbol="₺" />
                                        </h5>

                                        <div class="d-grid gap-2 mt-auto">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                                                class="btn btn-outline-secondary">Detay</a>

                                            <c:choose>
                                                <c:when test="${product.stock > 0}">
                                                    <form action="${pageContext.request.contextPath}/cart"
                                                        method="post">
                                                        <input type="hidden" name="action" value="add">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <input type="hidden" name="quantity" value="1">
                                                        <button type="submit" class="btn btn-primary w-100"><i
                                                                class="bi bi-cart-plus"></i> Sepete Ekle</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-secondary w-100" disabled>Stokta Yok</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <footer class="bg-dark text-white mt-5">
                    <div class="container py-4">
                        <div class="row align-items-center">
                            <div class="col-md-4 text-center text-md-start">
                                <span class="navbar-brand fs-4">E-Ticaret</span>
                            </div>
                            <div class="col-md-4 text-center small">
                                <a href="${pageContext.request.contextPath}/" class="text-white-50 me-3">Ana
                                    Sayfa</a>
                                <a href="${pageContext.request.contextPath}/products"
                                    class="text-white-50 me-3">Ürünler</a>
                                <a href="${pageContext.request.contextPath}/cart"
                                    class="text-white-50">Sepetim</a>
                            </div>
                            <div class="col-md-4 text-center text-md-end small text-white-50">
                                &copy; 2026 E-Ticaret Portalı
                            </div>
                        </div>
                    </div>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>