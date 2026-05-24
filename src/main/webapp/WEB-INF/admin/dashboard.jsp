<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="tr">

    <head>
        <title>Yönetim Paneli</title>
        <jsp:include page="/WEB-INF/includes/head-common.jsp" />
    </head>

    <body class="bg-light">

        <nav class="navbar navbar-expand-lg navbar-dark bg-danger">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard"><i
                        class="bi bi-shield-lock"></i> Admin Panel</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link"
                                href="${pageContext.request.contextPath}/admin/products">Ürünler</a></li>
                        <li class="nav-item"><a class="nav-link"
                                href="${pageContext.request.contextPath}/admin/categories">Kategoriler</a></li>
                        <li class="nav-item"><a class="nav-link"
                                href="${pageContext.request.contextPath}/admin/orders">Siparişler</a></li>
                        <li class="nav-item"><a class="nav-link"
                                href="${pageContext.request.contextPath}/admin/users">Kullanıcılar</a></li>
                    </ul>
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Siteye
                                Dön</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="mb-4">Genel Durum</h2>
            <div class="row g-4">
                <div class="col-md-4 col-lg">
                    <div class="card text-white bg-primary shadow">
                        <div class="card-body">
                            <h5 class="card-title">Toplam Ürün</h5>
                            <h2 class="display-5 fw-bold">${totalProducts}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-lg">
                    <div class="card text-white bg-success shadow">
                        <div class="card-body">
                            <h5 class="card-title">Toplam Kategori</h5>
                            <h2 class="display-5 fw-bold">${totalCategories}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-lg">
                    <div class="card text-white bg-secondary shadow">
                        <div class="card-body">
                            <h5 class="card-title">Toplam Kullanıcı</h5>
                            <h2 class="display-5 fw-bold">${totalUsers}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-lg">
                    <div class="card text-white bg-warning text-dark shadow">
                        <div class="card-body">
                            <h5 class="card-title">Bekleyen Sipariş</h5>
                            <h2 class="display-5 fw-bold">${pendingOrders}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-lg">
                    <div class="card text-white bg-info text-dark shadow">
                        <div class="card-body">
                            <h5 class="card-title">Tüm Siparişler</h5>
                            <h2 class="display-5 fw-bold">${totalOrders}</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mt-3">
                <div class="col-lg-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white"><h5 class="mb-0">Sipariş Durumu Dağılımı</h5></div>
                        <div class="card-body" style="height: 320px;">
                            <canvas id="statusChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white"><h5 class="mb-0">Kategori Başı Ürün Sayısı</h5></div>
                        <div class="card-body" style="height: 320px;">
                            <canvas id="categoryChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
        <script>
            new Chart(document.getElementById('statusChart'), {
                type: 'doughnut',
                data: {
                    labels: ${statusLabels},
                    datasets: [{
                        data: [<c:forEach var="v" items="${statusData}" varStatus="s">${v}${s.last ? '' : ','}</c:forEach>],
                        backgroundColor: ['#ffc107','#0d6efd','#0dcaf0','#198754','#dc3545']
                    }]
                },
                options: { maintainAspectRatio: false, plugins: { legend: { position: 'right' } } }
            });

            new Chart(document.getElementById('categoryChart'), {
                type: 'bar',
                data: {
                    labels: ${categoryLabels},
                    datasets: [{
                        label: 'Ürün Sayısı',
                        data: [<c:forEach var="v" items="${categoryData}" varStatus="s">${v}${s.last ? '' : ','}</c:forEach>],
                        backgroundColor: '#0d6efd'
                    }]
                },
                options: { maintainAspectRatio: false, scales: { y: { beginAtZero: true, ticks: { precision: 0 } } } }
            });
        </script>
    </body>

    </html>