import 'package:flutter/material.dart';
import '../models/product.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Tüm ürünlerin tutulacağı liste (JSON'dan dolacak)
  List<Product> allProducts = [];
  // Arama sonucuna göre filtrelenmiş ürünlerin listesi
  List<Product> displayedProducts = [];

  @override
  void initState() {
    super.initState();();
    // Uygulama açılırken JSON simülasyonundan verileri çözüyoruz (Decode)
    allProducts = getProductsFromJson();
    displayedProducts = allProducts; // Başta tüm ürünleri göster
  }

  // Arama fonksiyonu: Yazılan metne göre filtreleme yapar
  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedProducts = allProducts;
      } else {
        displayedProducts = allProducts
            .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TeknoKatalog"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          // Sepet Butonu - Tıklanınca Sepet Ekranına Gider
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () async {
                  // Sepet ekranına geçiş
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                  // Sepetten geri dönüldüğünde ana sayfadaki sepet sayacını tazele
                  setState(() {});
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          // 🔍 Basit Arama Çubuğu (TextField)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) => _filterProducts(value),
              decoration: InputDecoration(
                labelText: "Ürün Ara...",
                hintText: "Aratmak istediğiniz ürünü yazın",
                prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // Ürünlerin Listelendiği Alan
          Expanded(
            child: displayedProducts.isEmpty
                ? const Center(child: Text("Aradığınız ürün bulunamadı."))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = displayedProducts[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: InkWell(
                            onTap: () async {
                              // Detay ekranına route ile veri taşıyarak geçiş
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(product: product),
                                ),
                              );
                              // Detaydan dönünce ana ekran state'ini yenile
                              setState(() {});
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                      image: DecorationImage(
                                        image: NetworkImage(product.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${product.price.toStringAsFixed(2)} TL",
                                        style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}