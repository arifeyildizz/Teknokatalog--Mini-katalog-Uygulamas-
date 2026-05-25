import 'dart:convert';

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // JSON'dan gelen veriyi Product nesnesine dönüştüren kurucu fonksiyon (Factory)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}

// 1. JSON Simülasyonu: Gerçek bir API'den gelebilecek ham metin (String) formatında veri
const String jsonProductData = '''
[
  {
    "id": 1,
    "name": "Kablosuz Kulaklık",
    "price": 1299.99,
    "description": "Yüksek ses kaliteli, aktif gürültü engelleyici kablosuz kulaklık.",
    "imageUrl": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500"
  },
  {
    "id": 2,
    "name": "Akıllı Saat",
    "price": 3499.00,
    "description": "Adım sayar, nabız ölçer ve su geçirmez spor akıllı saat.",
    "imageUrl": "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500"
  },
  {
    "id": 3,
    "name": "Sırt Çantası",
    "price": 850.50,
    "description": "Su geçirmez kumaştan üretilmiş, 15.6 inç laptop bölmeli sırt çantası.",
    "imageUrl": "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500"
  },
  {
    "id": 4,
    "name": "Kahve Makinesi",
    "price": 4200.00,
    "description": "Filtre kahve ve espresso yapabilen tam otomatik kahve makinesi.",
    "imageUrl": "https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=500"
  }
]
''';

// 2. JSON String'ini okuyup Product listesine çeviren fonksiyon
List<Product> getProductsFromJson() {
  final List<dynamic> decodedData = jsonDecode(jsonProductData);
  return decodedData.map((item) => Product.fromJson(item)).toList();
}

// Sepetimizdeki ürünleri global olarak tutacak geçici liste
List<Product> cartItems = [];