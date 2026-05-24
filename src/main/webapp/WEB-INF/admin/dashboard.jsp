<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="tr">

    <head>
        <meta charset="UTF-8">
        <title>Yönetim Paneli</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
                <div class="col-md-3">
                    <div class="card text-white bg-primary shadow">
                        <div class="card-body">
                            <h5 class="card-title">Toplam Ürün</h5>
                            <h2 class="display-5 fw-bold">${totalProducts}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-success shadow">
                        <div class="card-body">
                            <h5 class="card-title">Toplam Kategori</h5>
                            <h2 class="display-5 fw-bold">${totalCategories}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-warning text-dark shadow">
                        <div class="card-body">
                            <h5 class="card-title">Bekleyen Sipariş</h5>
                            <h2 class="display-5 fw-bold">${pendingOrders}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-info text-dark shadow">
                        <div class="card-body">
                            <h5 class="card-title">Tüm Siparişler</h5>
                            <h2 class="display-5 fw-bold">${totalOrders}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>