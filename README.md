# E-Ticaret Portalı 🛒

Java MVC mimarisi, Servlet, JSP ve JSTL kullanılarak geliştirilmiş tam
özellikli bir e-ticaret web uygulaması. Web Programlama dersi final
projesi olarak hazırlanmıştır.

![Java](https://img.shields.io/badge/Java-21-orange?logo=openjdk)
![Tomcat](https://img.shields.io/badge/Tomcat-10.1-yellow?logo=apache-tomcat)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?logo=bootstrap)
![Maven](https://img.shields.io/badge/Maven-3.9-red?logo=apache-maven)

---

## 🎯 Özellikler

### Müşteri Tarafı

- 🏠 **Ana sayfa** — öne çıkan ürünler, modern hero alanı
- 🔍 **Arama çubuğu** — tüm sayfalarda erişilebilir
- 📂 **Kategori filtresi** — Telefon, Bilgisayar, Aksesuar, Kitap, Giyim
- 📄 **Sayfalama** — 8 ürün/sayfa
- 📦 **Ürün detay sayfası** — kategori bilgisi, stok durumu, görsel galerisi
- 🛒 **Sepet işlemleri** — ekleme/çıkarma/güncelleme, stok limiti kontrolü
- 💳 **Sipariş oluşturma** — transaction ile DB'ye kayıt, stok azaltma
- 📋 **Sipariş geçmişi** — tarih, tutar, durum, detay görüntüleme
- ❤️ **Favoriler** — kalp animasyonlu beğenme sistemi
- 👤 **Kayıt & giriş** — BCrypt şifre hashleme

### Yönetim Paneli

- 📊 **Dashboard** — 5 istatistik kartı + Chart.js grafikleri
  (sipariş durumu doughnut, kategori başı ürün sayısı bar chart)
- 🛍️ **Ürün yönetimi** — ekle / düzenle (modal) / pasif yap / stok yönetimi
- 🏷️ **Kategori yönetimi** — CRUD + pasif yapma
- 📦 **Sipariş yönetimi** — müşteri adı (JOIN), durum güncelleme, detay
- 👥 **Kullanıcı yönetimi** — kayıtlı kullanıcı listesi
- 🔒 **Filter ile koruma** — sadece ADMIN rolündeki kullanıcılar erişebilir

---

## 🛠 Teknolojiler

| Katman    | Teknoloji                                    |
| --------- | -------------------------------------------- |
| Backend   | Java 21, Jakarta Servlet 6.0                 |
| View      | JSP, JSTL 3.0                                |
| DB        | MySQL 8.0, JDBC                              |
| Güvenlik  | jBCrypt 0.4                                  |
| Frontend  | Bootstrap 5.3, Bootstrap Icons, Chart.js 4.4 |
| Font      | Google Fonts — Inter                         |
| Build     | Maven 3.9                                    |
| Container | Apache Tomcat 10.1                           |

> Spring Boot, Hibernate, JPA, React, Angular, Vue kullanılmamıştır.

---

## 📂 Klasör Yapısı

```
java-mvc-ecommerce/
├── database/
│   ├── schema.sql              # Tablolar + örnek veriler
│   ├── add_favorites.sql       # Favoriler migration
│   └── update_images.sql       # Ürün görseli migration
├── src/main/
│   ├── java/com/eticaret/
│   │   ├── controller/         # 14 Servlet
│   │   ├── dao/                # 6 DAO sınıfı
│   │   ├── model/              # 6 POJO
│   │   ├── filter/             # AdminFilter
│   │   ├── listener/           # DataInitializer
│   │   └── util/               # DBConnection
│   ├── resources/
│   │   └── db.properties       # DB bağlantı konfigürasyonu
│   └── webapp/
│       ├── css/
│       │   └── style.css       # Özel tema
│       └── WEB-INF/
│           ├── *.jsp           # Müşteri sayfaları
│           ├── admin/*.jsp     # Admin sayfaları
│           ├── includes/       # Ortak JSP fragment'ları
│           └── web.xml
├── pom.xml
├── REPORT.md                   # Proje raporu
└── README.md
```

---

## 🚀 Kurulum

### Gereksinimler

- Java 21 (Adoptium / Oracle / OpenJDK)
- Apache Tomcat 10.1+
- MySQL 8.0+
- Maven 3.9+

### 1. Veritabanını oluştur

```bash
mysql -u root -p < database/schema.sql
```

### 2. DB bağlantısını yapılandır

`src/main/resources/db.properties`:

```properties
db.url=jdbc:mysql://localhost:3306/ecommerce_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8
db.user=root
db.password=YOUR_PASSWORD
db.driver=com.mysql.cj.jdbc.Driver
```

> Bu dosya `.gitignore`'da olduğu için repo'ya commit edilmez.

### 3. WAR derle

```bash
mvn clean package -DskipTests
```

`target/ecommerce.war` dosyası oluşur.

### 4. Tomcat'e deploy et

```bash
# Tomcat çalışıyorsa durdur
$TOMCAT_HOME/bin/shutdown.bat

# Eski deploy'u temizle
rm -rf $TOMCAT_HOME/webapps/ecommerce
rm -f  $TOMCAT_HOME/webapps/ecommerce.war

# Yeni WAR'ı kopyala
cp target/ecommerce.war $TOMCAT_HOME/webapps/

# Tomcat'i başlat
$TOMCAT_HOME/bin/startup.bat
```

### 5. Tarayıcıda aç

```
http://localhost:8080/ecommerce/
```

> Port 8080 başka bir uygulama tarafından kullanılıyorsa Tomcat 8081'e
> düşebilir. `<TOMCAT>/conf/server.xml` içindeki `Connector port="..."`
> değerini kontrol et.

---

## 🔑 Demo Hesapları

Uygulama ilk çalıştırıldığında `DataInitializer` aşağıdaki kullanıcıları
otomatik olarak oluşturur (BCrypt hashlenmiş şifrelerle):

| Rol            | E-posta              | Şifre      |
| -------------- | -------------------- | ---------- |
| 🛡️ **Admin**   | `admin@eticaret.com` | `admin123` |
| 👤 **Müşteri** | `ahmet@example.com`  | `user123`  |

---

## 🗄️ Veritabanı Şeması

```
users          (id, full_name, email, password, phone, address, role, created_at)
categories     (id, name, description, is_active)
products       (id, category_id↗categories, name, description, price, stock,
                image_url, is_active, created_at)
orders         (id, user_id↗users, order_date, total_amount, status)
order_items    (id, order_id↗orders CASCADE, product_id↗products,
                quantity, unit_price, subtotal)
favorites      (user_id↗users CASCADE, product_id↗products CASCADE, created_at)
```

**Sipariş statüsü (ENUM):**
`BEKLEMEDE`, `HAZIRLANIYOR`, `KARGODA`, `TAMAMLANDI`, `IPTAL`

---

## 🧩 MVC Mimarisi

```
Browser
   │
   ▼
┌─────────────────┐     ┌──────────────┐     ┌──────────────┐
│   Servlet       │────▶│     DAO      │────▶│   MySQL DB   │
│  (Controller)   │     │  (PreparedStmt)    │              │
└─────────────────┘     └──────────────┘     └──────────────┘
   │ setAttribute
   ▼
┌─────────────────┐
│   JSP + JSTL    │  ◀── Model (POJO)
│     (View)      │
└─────────────────┘
```

- **Filter:** `/admin/*` için role kontrolü
- **Listener:** Uygulama açılışında admin/test kullanıcısı seed eder
- **Transaction:** Sipariş oluşturma akışında commit/rollback

---

## 🎨 Tasarım

Bootstrap 5.3 üzerine inşa edilmiş özel bir tema:

- **Renk paleti:** Indigo (`#4f46e5`) + Purple/Pink gradient'leri
- **Tipografi:** Inter (Google Fonts), `letter-spacing -0.02em` başlıklarda
- **Hero alanı:** 3 renk gradient, derin shadow
- **Ürün kartları:** Hover'da yukarı kalkma + görsel zoom efekti
- **Favori kalp butonu:** Tıklayınca heartbeat animasyonu
- **Auth sayfaları:** Pastel gradient arkaplan
- **Admin stat kartları:** Renk gradient dolgular

Tüm stiller `src/main/webapp/css/style.css` içinde, CSS custom property
(değişken) sistemi ile yönetilir.

---

## ✅ PDF Gereksinim Karşılama

| PDF Maddesi                                           | Durum |
| ----------------------------------------------------- | ----- |
| MVC mimarisi                                          | ✅    |
| Servlet, JSP, JSTL kullanımı                          | ✅    |
| 5 zorunlu DB tablosu                                  | ✅    |
| Müşteri: liste/filtre/detay/sepet/sipariş/kayıt/giriş | ✅    |
| Admin: ürün/kategori/sipariş/kullanıcı yönetimi       | ✅    |
| Form doğrulama (istemci + sunucu)                     | ✅    |
| Session kullanımı                                     | ✅    |
| **Bonus:** ürün arama                                 | ✅    |
| **Bonus:** BCrypt hashleme                            | ✅    |
| **Bonus:** sipariş durumu renkli gösterim             | ✅    |
| **Bonus:** admin grafiksel özet                       | ✅    |
| **Bonus:** sayfalama                                  | ✅    |
| **Bonus:** ürün favorileme                            | ✅    |

---

## 📄 Lisans

Bu proje akademik amaçla geliştirilmiştir. Eğitim amaçlı serbestçe
incelenebilir.

---

## 👤 Geliştirici

**Mehmet Akyürek**
GitHub: [@mehmetakyurek10](https://github.com/mehmetakyurek10)
