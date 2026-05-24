<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <title>${not empty product ? product.name : 'Ürün Detayı'} | E-Ticaret</title>
                <jsp:include page="/WEB-INF/includes/head-common.jsp" />
            </head>

            <body class="d-flex flex-column min-vh-100">

                <jsp:include page="/WEB-INF/includes/nav-customer.jsp" />

                <div class="container mt-5 flex-grow-1">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary mb-4">
                        <i class="bi bi-arrow-left"></i> Geri Dön
                    </a>

                    <c:if test="${empty product}">
                        <div class="alert alert-danger">Aradığınız ürün bulunamadı veya yayından kaldırılmış olabilir.
                        </div>
                    </c:if>

                    <c:if test="${not empty product}">
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <img src="${product.imageUrl}" class="img-fluid rounded shadow w-100"
                                    style="max-height: 500px; object-fit: cover; background:#e9ecef;" alt="${product.name}"
                                    onerror="this.onerror=null;this.src='data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 600 400%22><rect width=%22600%22 height=%22400%22 fill=%22%23e9ecef%22/><text x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dominant-baseline=%22middle%22 fill=%22%236c757d%22 font-family=%22sans-serif%22 font-size=%2228%22>Görsel Yok</text></svg>'">
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex justify-content-between align-items-start">
                                    <h2 class="fw-bold display-5">${product.name}</h2>
                                    <c:if test="${not empty sessionScope.user}">
                                        <form action="${pageContext.request.contextPath}/favorite-toggle"
                                            method="post">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            <input type="hidden" name="redirect"
                                                value="/product-detail?id=${product.id}">
                                            <button type="submit"
                                                class="btn ${isFavorite ? 'btn-danger' : 'btn-outline-danger'}"
                                                title="${isFavorite ? 'Favoriden çıkar' : 'Favorilere ekle'}">
                                                <i class="bi ${isFavorite ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                                ${isFavorite ? 'Favorimde' : 'Favorile'}
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                                <c:if test="${not empty category}">
                                    <p class="text-muted mb-2"><i class="bi bi-tag"></i>
                                        Kategori: <strong>${category.name}</strong></p>
                                </c:if>
                                <h3 class="text-primary my-4 fw-bold">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺" />
                                </h3>

                                <p class="lead text-secondary">${product.description}</p>

                                <hr class="my-4">

                                <c:set var="canBuy" value="${product.active and product.stock > 0}" />
                                <div class="mb-4">
                                    <c:choose>
                                        <c:when test="${not product.active}">
                                            <span class="badge bg-secondary fs-6 px-3 py-2"><i
                                                    class="bi bi-eye-slash"></i> Yayında Değil</span>
                                        </c:when>
                                        <c:when test="${product.stock > 0}">
                                            <span class="badge bg-success fs-6 px-3 py-2"><i
                                                    class="bi bi-check-circle"></i> Stokta Var (${product.stock}
                                                adet)</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger fs-6 px-3 py-2"><i class="bi bi-x-circle"></i>
                                                Stokta Yok</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <c:choose>
                                    <c:when test="${canBuy}">
                                        <form action="${pageContext.request.contextPath}/cart" method="post"
                                            class="d-flex align-items-center gap-3 mt-4">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="productId" value="${product.id}">

                                            <div style="width: 120px;">
                                                <input type="number" name="quantity"
                                                    class="form-control form-control-lg text-center" value="1" min="1"
                                                    max="${product.stock}">
                                            </div>

                                            <button type="submit" class="btn btn-primary btn-lg flex-grow-1">
                                                <i class="bi bi-cart-plus"></i> Sepete Ekle
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary btn-lg w-100 mt-4" disabled>
                                            <c:choose>
                                                <c:when test="${not product.active}">Bu ürün şu an satışta değil</c:when>
                                                <c:otherwise>Stokta Yok</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:if>
                </div>

                <footer class="bg-dark text-white text-center py-3 mt-auto">
                    <p class="mb-0">&copy; 2026 E-Ticaret Portalı.</p>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>