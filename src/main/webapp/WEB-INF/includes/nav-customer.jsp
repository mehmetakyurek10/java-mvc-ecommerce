<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">E-Ticaret</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMain">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Ana Sayfa</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products">Tüm Ürünler</a>
                </li>
                <c:if test="${not empty categories}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                            Kategoriler
                        </a>
                        <ul class="dropdown-menu">
                            <c:forEach var="cat" items="${categories}">
                                <c:if test="${cat.active}">
                                    <li><a class="dropdown-item"
                                            href="${pageContext.request.contextPath}/products?category=${cat.id}">${cat.name}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </ul>

            <form class="d-flex mx-3" action="${pageContext.request.contextPath}/search" method="get">
                <input class="form-control me-2" type="search" name="q" placeholder="Ürün ara..." required>
                <button class="btn btn-outline-light" type="submit"><i class="bi bi-search"></i></button>
            </form>

            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                        <i class="bi bi-cart"></i> Sepetim
                        <c:if test="${not empty sessionScope.cart}">
                            <span class="badge bg-danger rounded-pill">${sessionScope.cart.size()}</span>
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
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item"
                                        href="${pageContext.request.contextPath}/favorites">
                                        <i class="bi bi-heart"></i> Favorilerim</a></li>
                                <li><a class="dropdown-item"
                                        href="${pageContext.request.contextPath}/my-orders">
                                        <i class="bi bi-receipt"></i> Siparişlerim</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger"
                                        href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right"></i> Çıkış Yap</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">Giriş Yap</a>
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
