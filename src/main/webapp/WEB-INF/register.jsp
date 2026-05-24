<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="tr">

        <head>
            <meta charset="UTF-8">
            <title>Kayıt Ol | E-Ticaret</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body class="bg-light">

            <div class="container mt-5 mb-5">
                <div class="row justify-content-center">
                    <div class="col-md-6">

                        <div class="text-center mb-4">
                            <a href="${pageContext.request.contextPath}/"
                                class="text-decoration-none text-dark display-6 fw-bold">E-Ticaret</a>
                        </div>

                        <div class="card shadow">
                            <div class="card-header bg-white text-center py-3">
                                <h4 class="mb-0">Yeni Hesap Oluştur</h4>
                            </div>
                            <div class="card-body p-4">

                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">${errorMessage}</div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/register" method="post">
                                    <div class="mb-3">
                                        <label class="form-label">Ad Soyad</label>
                                        <input type="text" name="fullName" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">E-posta Adresi</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Telefon Numarası</label>
                                        <input type="tel" name="phone" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Açık Adres</label>
                                        <textarea name="address" class="form-control" rows="3"></textarea>
                                    </div>
                                    <div class="mb-4">
                                        <label class="form-label">Şifre</label>
                                        <input type="password" name="password" class="form-control" required
                                            minlength="6">
                                    </div>
                                    <button type="submit" class="btn btn-success w-100 py-2">Kayıt Ol</button>
                                </form>

                            </div>
                            <div class="card-footer bg-white text-center py-3">
                                Zaten bir hesabınız var mı? <a href="${pageContext.request.contextPath}/login"
                                    class="text-decoration-none">Giriş Yapın</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </body>

        </html>