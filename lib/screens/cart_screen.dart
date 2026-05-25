import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sepetteki ürünlerin toplam fiyatını hesaplayalım
    double totalPrice = cartItems.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Sepetiniz henüz boş.", style: TextStyle(fontSize: 18)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("${item.price.toStringAsFixed(2)} TL"),
                          trailing: const Icon(Icons.shopping_bag, color: Colors.deepPurple),
                        ),
                      );
                    },
                  ),
                ),
                // Toplam Fiyat Bölümü
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Toplam Tutar:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        "${totalPrice.toStringAsFixed(2)} TL",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}