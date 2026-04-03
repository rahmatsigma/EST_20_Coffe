
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Tambahkan import http
import 'dart:convert';                   // Tambahkan import convert
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  int get itemCount => _items.length;

  // Total keranjang MURNI (sebelum pajak)
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // Tambahan: Total keranjang + PAJAK (10%)
  double get totalWithTax {
    return totalAmount + (totalAmount * 0.1);
  }

  void addItem(Product product) { /* (Kode masih sama seperti sebelumnya) */ 
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }
    notifyListeners();
  }

  void reduceItem(Product product) { /* (Kode masih sama seperti sebelumnya) */ 
    if (!_items.containsKey(product.id)) return;
    
    if (_items[product.id]!.quantity > 1) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(product.id);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  // --- FUNGSI BARU UNTUK MENGIRIM PESANAN KE DATABASE ---
  Future<bool> submitOrder(String paymentMethod) async {
    // Sesuaikan URL ini dengan IP Address backend Anda (10.0.2.2 untuk emulator, atau IPv4 WiFi Anda)
    final url = Uri.parse("http://192.168.1.65/est20_api/api/create_order.php");

    // Siapkan daftar item sesuai format JSON yang diminta API
    List<Map<String, dynamic>> orderItems = [];
    _items.forEach((key, cartItem) {
      orderItems.add({
        "product_id": cartItem.product.id,
        "quantity": cartItem.quantity,
        "price": cartItem.product.price,
      });
    });

    // Siapkan body request
    final bodyData = json.encode({
      "user_id": null, // Kosongkan dulu (Guest) sampai fitur login dibuat
      "total_amount": totalWithTax,
      "payment_method": paymentMethod,
      "items": orderItems,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: bodyData,
      );

      if (response.statusCode == 201) {
        // Jika berhasil, kosongkan keranjang
        clear();
        return true;
      } else {
        print("Gagal submit: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error jaringan: $e");
      return false;
    }
  }
}