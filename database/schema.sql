DROP DATABASE IF EXISTS ecommerce_db;

CREATE DATABASE ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role ENUM('CUSTOMER', 'ADMIN') NOT NULL DEFAULT 'CUSTOMER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM(
        'BEKLEMEDE',
        'HAZIRLANIYOR',
        'KARGODA',
        'TAMAMLANDI',
        'IPTAL'
    ) NOT NULL DEFAULT 'BEKLEMEDE',
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE TABLE favorites (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

INSERT INTO
    categories (name, description)
VALUES (
        'Telefon',
        'Akıllı telefonlar ve aksesuarları'
    ),
    (
        'Bilgisayar',
        'Dizüstü ve masaüstü bilgisayarlar'
    ),
    (
        'Aksesuar',
        'Çeşitli teknolojik aksesuarlar'
    ),
    (
        'Kitap',
        'Roman, ders kitabı, dergi'
    ),
    (
        'Giyim',
        'Erkek ve kadın giyim'
    );

INSERT INTO
    products (
        category_id,
        name,
        description,
        price,
        stock,
        image_url
    )
VALUES (
        1,
        'iPhone 15',
        'Apple iPhone 15, 128 GB, Siyah',
        45000.00,
        10,
        'https://images.unsplash.com/photo-1592286927505-1def25115558?w=600&q=80'
    ),
    (
        1,
        'Samsung Galaxy S24',
        'Samsung Galaxy S24, 256 GB',
        38000.00,
        15,
        'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&q=80'
    ),
    (
        2,
        'MacBook Air M3',
        '13 inç, 8GB RAM, 256GB SSD',
        55000.00,
        5,
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&q=80'
    ),
    (
        2,
        'Lenovo ThinkPad',
        'i5, 16GB RAM, 512GB SSD',
        28000.00,
        8,
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600&q=80'
    ),
    (
        3,
        'Kablosuz Kulaklık',
        'Bluetooth 5.0, gürültü engelleme',
        1200.00,
        30,
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80'
    ),
    (
        3,
        'Mouse Pad XL',
        'Geniş oyuncu mouse pad',
        250.00,
        50,
        'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=600&q=80'
    ),
    (
        4,
        'Suç ve Ceza',
        'Fyodor Dostoyevski klasik romanı',
        80.00,
        100,
        'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=600&q=80'
    ),
    (
        4,
        'Java Programlama',
        'Java SE temel ders kitabı',
        150.00,
        25,
        'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&q=80'
    ),
    (
        5,
        'Erkek Tişört',
        '%100 pamuk, beyaz',
        200.00,
        40,
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&q=80'
    ),
    (
        5,
        'Kadın Kazak',
        'Yün karışımı, kahverengi',
        350.00,
        20,
        'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=600&q=80'
    );
