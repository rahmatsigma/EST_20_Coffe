import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:est20coffee/theme/app_theme.dart';
import 'package:est20coffee/widgets/app_bars.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  final List<_CartItem> _cartItems = [
    _CartItem(
      name: 'Iced Oat Latte',
      variant: 'Large, Less Sugar, Oat Milk',
      price: 42000,
      quantity: 1,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB8XyG9183bF3dzPoTR12XrY1eMwZnELMY0SvYAi9wNI7Aew_K6VrEcxrRs87Pkhs64fmHHQiH4eIbN1AI4N8GSnfCElfUAYiUiXiUAa7yscitPx3JGul4SRnbeIkk8yHCaLVGdXUAC5_LlcfGdAMLOEv-5YvB27Bt_ZIEgc8kFcs0NrlyXcj35_YFIooM5kwodo9iKRqlxVnQEvpnN23K8nTlyG0ZkCmUHayy3gZWSV5fzjFGp5z3U37Bb3rJAeCfgvKrRLgpWetZk',
    ),
    _CartItem(
      name: 'V60 Single Origin',
      variant: 'Ethiopia Guji, Hot',
      price: 38000,
      quantity: 2,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCaJJsUzs-ugB25JCsFtqEgAa7L2GmFlWnzcb9spFJ2w7c-_kP8R-5Cf-P3YjuOIQzMg9AaIL17rnwWAhQ_9EFIP1EKemKDxdA6QIB17SlDbVET7OtOG3WkZP1BDJYlproHksCU6x7J6j4Su8WNcXM_3Yew1O2Uz48EMkc4MQIeaGX0HNqz1bOIDR_q6BMK2_cRnTY0UTtfxcOC1zxYsGMfoEKBk1aDzvvSVCr_ahmXcs7GyHGqJTvo6G_QYQF-bR7bhiTc7pnFEbjb',
    ),
  ];

  int get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  int get _tax => (_subtotal * 0.1).round();
  int get _total => _subtotal + _tax;

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
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      appBar: AppTopBar(showMenu: true, showBag: false),
      body: Stack(
        children: [
          // Background leaf texture
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

              // Table detection badge
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
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryContainer.withOpacity(0.3),
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

              // Cart Items
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: _CartItemCard(
                      item: _cartItems[index],
                      onIncrement: () {
                        setState(() => _cartItems[index].quantity++);
                      },
                      onDecrement: () {
                        setState(() {
                          if (_cartItems[index].quantity > 1) {
                            _cartItems[index].quantity--;
                          } else {
                            _cartItems.removeAt(index);
                          }
                        });
                      },
                    ),
                  ),
                  childCount: _cartItems.length,
                ),
              ),

              // Price Summary
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 200),
                  child: Column(
                    children: [
                      _PriceRow(
                        label: 'Subtotal',
                        value: _formatRupiah(_subtotal),
                      ),
                      const SizedBox(height: 10),
                      _PriceRow(
                        label: 'Tax (10%)',
                        value: _formatRupiah(_tax),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        color: AppColors.outlineVariant.withOpacity(0.2),
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
                            _formatRupiah(_total),
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

      // Bottom Action Buttons
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withOpacity(0.92),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
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
            // QRIS Button
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/qris'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
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

            // Cash Button
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/registered'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.outlineVariant.withOpacity(0.3),
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

            // Bottom Nav
            const SizedBox(height: 12),
            AppBottomNav(
              currentIndex: 2,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushReplacementNamed(context, '/menu');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/status');
                    break;
                  case 2:
                    break;
                  case 3:
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItem {
  final String name;
  final String variant;
  final int price;
  int quantity;
  final String imageUrl;

  _CartItem({
    required this.name,
    required this.variant,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class _CartItemCard extends StatelessWidget {
  final _CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _CartItemCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 88,
            height: 88,
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.85),
              colorBlendMode: BlendMode.modulate,
              errorWidget: (_, __, ___) => Container(
                color: AppColors.surfaceContainer,
                child: const Icon(Icons.coffee, color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: GoogleFonts.manrope(
                        color: AppColors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  Text(
                    'IDR ${(item.price ~/ 1000)}k',
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
                item.variant,
                style: GoogleFonts.manrope(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),

              // Quantity controls
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
