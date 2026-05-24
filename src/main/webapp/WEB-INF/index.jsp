<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="tr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Lezzet Dünyası | E-Ticaret</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            </head>

            <body>

                <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/">E-Ticaret</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/">Ana Sayfa</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/products">Tüm
                                        Ürünler</a>
                                </li>

                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                        data-bs-toggle="dropdown">
                                        Kategoriler
                                    </a>
                                    <ul class="dropdown-menu">
                                        <c:forEach var="category" items="${categories}">
                                            <li><a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/products?category=${category.id}">${category.name}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </ul>

                            <ul class="navbar-nav ms-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                        <i class="bi bi-cart"></i> Sepetim
                                        <c:if test="${not empty sessionScope.cart}">
                                            <span
                                                class="badge bg-danger rounded-pill">${sessionScope.cart.size()}</span>
                                        </c:if>
                                    </a>
                                </li>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                                <i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                                    <li><a class="dropdown-item"
                                                            href="${pageContext.request.contextPath}/admin/dashboard">Yönetim
                                                            Paneli</a></li>
                                                </c:if>
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/my-orders">Siparişlerim</a>
                                                </li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item text-danger"
                                                        href="${pageContext.request.contextPath}/logout">Çıkış Yap</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/login">Giriş
                                                Yap</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="btn btn-outline-light btn-sm mt-1 ms-2"
                                                href="${pageContext.request.contextPath}/register">Kayıt Ol</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="container mt-5 mb-5">

                    <div class="p-5 mb-4 bg-light rounded-3 shadow-sm text-center">
                        <h1 class="display-5 fw-bold">Hoş Geldiniz!</h1>
                        <p class="col-md-8 fs-4 mx-auto">En yeni teknolojiler ve trend ürünler en uygun fiyatlarla
                            burada.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-lg">Ürünleri
                            İncele</a>
                    </div>

                    <h2 class="mb-4">Öne Çıkan Ürünler</h2>

                    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="product" items="${products}">
                            <div class="col">
                                <div class="card h-100 shadow-sm">
                                    <img src="https://via.placeholder.com/300x200?text=${product.name}"
                                        class="card-img-top" alt="${product.name}">

                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text text-muted small">${product.description}</p>

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

                <footer class="bg-dark text-white text-center py-3 mt-auto">
                    <p class="mb-0">&copy; 2026 E-Ticaret Portalı. Tüm Hakları Saklıdır.</p>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>