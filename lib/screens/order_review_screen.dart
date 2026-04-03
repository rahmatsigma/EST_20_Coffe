import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:est20coffee/theme/app_theme.dart';
import 'package:est20coffee/widgets/app_bars.dart';
import '../providers/cart_provider.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  bool _isLoading = false;

  String _formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'IDR ${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList(); 
    
    final subtotal = cart.totalAmount.toInt();
    final tax = (subtotal * 0.1).round();
    final total = subtotal + tax;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      appBar: const AppTopBar(showMenu: true, showBag: false),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.04,
              child: CustomPaint(painter: _LeafPatternPainter()),
            ),
          ),

          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER REVIEW',
                        style: GoogleFonts.manrope(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your Cart',
                        style: GoogleFonts.manrope(
                          color: AppColors.onBackground,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.table_restaurant,
                            color: AppColors.secondary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DETECTION STATUS',
                              style: GoogleFonts.manrope(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Meja Terdeteksi: Meja 12',
                              style: GoogleFonts.manrope(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (cartItems.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.shopping_bag_outlined, size: 80, color: AppColors.outlineVariant),
                          const SizedBox(height: 16),
                          Text(
                            "Keranjang masih kosong",
                            style: GoogleFonts.manrope(fontSize: 18, color: AppColors.onSurfaceVariant),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: _CartItemCard(
                        item: cartItems[index], 
                        onIncrement: () {
                          cart.addItem(cartItems[index].product);
                        },
                        onDecrement: () {
                          cart.reduceItem(cartItems[index].product);
                        },
                      ),
                    ),
                    childCount: cartItems.length,
                  ),
                ),

              if (cartItems.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 200),
                    child: Column(
                      children: [
                        _PriceRow(
                          label: 'Subtotal',
                          value: _formatRupiah(subtotal),
                        ),
                        const SizedBox(height: 10),
                        _PriceRow(
                          label: 'Tax (10%)',
                          value: _formatRupiah(tax),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: AppColors.outlineVariant.withValues(alpha: 0.2),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: GoogleFonts.manrope(
                                color: AppColors.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              _formatRupiah(total),
                              style: GoogleFonts.manrope(
                                color: AppColors.secondary,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      bottomSheet: cartItems.isEmpty ? null : Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withValues(alpha: 0.92),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          24,
          20,
          24,
          20 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _isLoading ? null : () async {
                setState(() => _isLoading = true);
                
                // Panggil fungsi submit ke API dengan metode QRIS
                bool success = await cart.submitOrder('QRIS');
                
                setState(() => _isLoading = false);

                if (success && context.mounted) {
                  // Jika berhasil masuk DB, arahkan ke layar QRIS
                  Navigator.pushReplacementNamed(context, '/qris');
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gagal membuat pesanan. Coba lagi.')),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  // Ubah warna jadi abu-abu jika sedang loading
                  color: _isLoading ? Colors.grey : AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.qr_code_2, color: AppColors.onPrimary, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'BAYAR DIGITAL (QRIS)',
                      style: GoogleFonts.manrope(
                        color: AppColors.onPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _isLoading ? null : () async {
                setState(() => _isLoading = true);
                
                // Panggil fungsi submit ke API dengan metode CASH
                bool success = await cart.submitOrder('Cash');
                
                setState(() => _isLoading = false);

                if (success && context.mounted) {
                  // Jika berhasil masuk DB, arahkan ke layar Sukses / Registered
                  Navigator.pushReplacementNamed(context, '/registered');
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gagal membuat pesanan. Coba lagi.')),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.payments_outlined, color: AppColors.primary, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'BAYAR TUNAI DI KASIR',
                      style: GoogleFonts.manrope(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item; 
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _CartItemCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.product.imageUrl ?? '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 88,
            height: 88,
            child: CachedNetworkImage(
              imageUrl: imageUrl, 
              fit: BoxFit.cover,
              color: Colors.white.withValues(alpha: 0.85),
              colorBlendMode: BlendMode.modulate,
              errorWidget: (_, __, ___) => Container(
                color: AppColors.surfaceContainer,
                child: const Icon(Icons.coffee, color: AppColors.primary, size: 36),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.product.name,
                      style: GoogleFonts.manrope(
                        color: AppColors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'IDR ${(item.product.price ~/ 1000)}k',
                    style: GoogleFonts.manrope(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                item.product.category ?? 'Coffee',
                style: GoogleFonts.manrope(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _QtyBtn(icon: Icons.remove, onTap: onDecrement),
                  const SizedBox(width: 16),
                  Text(
                    '${item.quantity}',
                    style: GoogleFonts.manrope(
                      color: AppColors.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 16),
                  _QtyBtn(icon: Icons.add, onTap: onIncrement),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: AppColors.onSurface, size: 16),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;

  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.manrope(
            color: AppColors.onSurfaceVariant,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            color: AppColors.onSurfaceVariant,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _LeafPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.outlineVariant
      ..style = PaintingStyle.fill;

    void drawLeaf(double x, double y, double scale) {
      final path = Path()
        ..moveTo(x, y)
        ..quadraticBezierTo(x + 30 * scale, y - 40 * scale, x + 60 * scale, y)
        ..quadraticBezierTo(x + 30 * scale, y + 40 * scale, x, y)
        ..close();
      canvas.drawPath(path, paint);
    }

    drawLeaf(size.width * 0.7, size.height * 0.1, 1.2);
    drawLeaf(size.width * 0.1, size.height * 0.8, 0.8);
    drawLeaf(size.width * 0.5, size.height * 0.5, 1.0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}