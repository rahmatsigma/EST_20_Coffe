// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';
import '../models/product.dart';

// Model kecil untuk item di dalam keranjang
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// Class Provider untuk mengelola state keranjang
class CartProvider with ChangeNotifier {
  // Menyimpan data keranjang. Key-nya adalah ID Produk.
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  // Menghitung jumlah unik item di keranjang
  int get itemCount => _items.length;

  // Menghitung total harga semua pesanan
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // Fungsi untuk menambah item ke keranjang
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Jika produk sudah ada di keranjang, tambah jumlahnya (quantity)
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      // Jika produk belum ada, masukkan sebagai barang baru
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }
    // Perintah sakti untuk menyuruh UI (layar) update/refresh otomatis
    notifyListeners();
  }

  // Fungsi untuk mengosongkan keranjang (dipakai setelah bayar)
  void clear() {
    _items.clear();
    notifyListeners();
  }
}