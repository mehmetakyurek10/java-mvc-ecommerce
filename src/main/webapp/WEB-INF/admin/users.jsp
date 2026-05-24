<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="tr">

<head>
    <title>Kullanıcı Yönetimi</title>
    <jsp:include page="/WEB-INF/includes/head-common.jsp" />
</head>

<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-shield-lock"></i> Admin Panel - Kullanıcılar
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/products">Ürünler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/categories">Kategoriler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/admin/orders">Siparişler</a></li>
                <li class="nav-item"><a class="nav-link"
                        href="${pageContext.request.contextPath}/">Siteye Dön</a></li>
            </ul>
        </div>
    </nav>

    <div class="container-fluid px-4">
        <div class="card shadow-sm">
            <div class="card-body">
                <h4 class="mb-3"><i class="bi bi-people"></i> Kayıtlı Kullanıcılar</h4>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Ad Soyad</th>
                                <th>E-posta</th>
                                <th>Telefon</th>
                                <th>Rol</th>
                                <th>Kayıt Tarihi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr>
                                    <td>${u.id}</td>
                                    <td>${u.fullName}</td>
                                    <td>${u.email}</td>
                                    <td>${not empty u.phone ? u.phone : '-'}</td>
                                    <td>
                                        <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">
                                            ${u.role}
                                        </span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${u.createdAt}" pattern="dd.MM.yyyy HH:mm" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
