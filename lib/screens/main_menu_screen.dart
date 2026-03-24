// lib/screens/main_menu_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final String apiUrl = "http://192.168.0.223/est20_api/api/get_products.php";
  
  late Future<Map<String, List<Product>>> futureGroupedProducts;

  @override
  void initState() {
    super.initState();
    futureGroupedProducts = fetchProducts();
  }

  Future<Map<String, List<Product>>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse['status'] == 'success') {
          List<dynamic> data = jsonResponse['data'];
          List<Product> allProducts = data.map((item) => Product.fromJson(item)).toList();

          // Logika Pengelompokan (Grouping)
          Map<String, List<Product>> groupedData = {};
          for (var product in allProducts) {
            // Mengambil nama dasar (misal: "Americano" dari "Americano (Hot)")
            String baseName = product.name.replaceAll(RegExp(r' \(.*\)'), '').trim();
            
            if (!groupedData.containsKey(baseName)) {
              groupedData[baseName] = [];
            }
            groupedData[baseName]!.add(product);
          }
          
          return groupedData;
        } else {
          throw Exception('Gagal memuat data: ${jsonResponse['message']}');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Koneksi gagal. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu EST 20 Coffee'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          )
        ],
      ),
      body: FutureBuilder<Map<String, List<Product>>>( // Tipe datanya diubah
        future: futureGroupedProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            
            final groupedProducts = snapshot.data!;
            final baseNames = groupedProducts.keys.toList(); // Daftar nama unik

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: baseNames.length,
              itemBuilder: (context, index) {
                final baseName = baseNames[index];
                final variants = groupedProducts[baseName]!; // Ambil list Hot & Ice
                
                // Cari harga termurah untuk ditampilkan "Mulai dari..."
                final minPrice = variants.map((v) => v.price).reduce((a, b) => a < b ? a : b);

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.coffee, color: Colors.white),
                    ),
                    title: Text(
                      baseName, // Hanya menampilkan "Americano"
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(variants.first.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: Text(
                      "Mulai Rp ${minPrice.toInt()}",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    onTap: () {
                      // Panggil fungsi Bottom Sheet saat menu di-klik
                      _showVariantPicker(context, baseName, variants);
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text("Belum ada menu yang tersedia."));
        },
      ),
    );
  }

  void _showVariantPicker(BuildContext context, String baseName, List<Product> variants) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Sesuaikan tinggi dengan isi konten
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Varian $baseName',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...variants.map((variant) {
                // Ekstrak tipe varian (Hot atau Ice) dari nama aslinya
                String type = variant.name.contains('Hot') ? 'Hot' : 'Ice';
                IconData iconType = type == 'Hot' ? Icons.local_fire_department : Icons.ac_unit;
                Color iconColor = type == 'Hot' ? Colors.orange : Colors.blue;

                return ListTile(
                  leading: Icon(iconType, color: iconColor),
                  title: Text(type),
                  trailing: Text(
                    'Rp ${variant.price.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Tutup bottom sheet
                    // Nanti logika masuk keranjang di sini
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${variant.name} masuk keranjang!')),
                    );
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}