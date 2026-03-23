import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:est20coffee/theme/app_theme.dart';
import 'package:est20coffee/widgets/app_bars.dart';

class MenuItem {
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final String? badge;

  const MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.badge,
  });
}

const _menuItems = [
  MenuItem(
    name: 'Signature Iced Palm',
    description: 'House-blend espresso with organic palm sugar.',
    price: 'Rp 32k',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAF3d0d89pMX5h2oVwAdMvpo-2AEcllaFB9mfTE4HLTvoEd-7c_ZGmDDbx1LIPoe12wQoD1jbFHounAFaF2aNVf3X-W05GHXOOBxOK1Bj8P2LU9EDhc_d_qQJusRDgyIlC8bCp4tIEmeOYFacK8V8VcdOsqNMPNXQcse3sIdjfxbI-ZDTGx94v3ksXvEBNwFKdeaI-7jsaFzj3B09LLShDYvlijGJEL3PjhSaTQUgCcggEgqdPJfYyyu2A3gZs7reB2HnOavIj9oY5M',
    badge: 'Best Seller',
  ),
  MenuItem(
    name: 'Cold Brew Classic',
    description: 'Slow-steeped for 12 hours. Smooth and bold.',
    price: 'Rp 28k',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCWWDACaFL9fio_1YceBGGKJ4C9_9_Z1ayOPI4RgdojC2bH0jhTwOndChJAGtjdEpUdPhJf6vHcN72mY5qJn28fIfsaSxRlSpcJ1eazswumWC1V1o2sfRo2J0a1u6_JsFTb2hUmyGGfsLsOO8MRO9D5wBjgYR3SzkdGM88D1lDjyxSo1C2PJ-rjnEGRQOVso5q9UnelrTKOEs4-xxFb9ZVWQZCP9eFp_VB04KGbeTNrmwVNOn6ubRy6K1VT9Oao9p1VNp055sjGOVkN',
  ),
  MenuItem(
    name: 'Vanilla Bean Cream',
    description: 'Madagascar vanilla with double shot espresso.',
    price: 'Rp 35k',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuC2uwVFIKqOKlEwxSmRegFrvPWwmL8CVb2Af0rC_KF6f1hZ7iX6yuacKgzqhwv5s_7csMithRKBSdh1hglc6qbs2AMaVYufngguQInEWGT2Vw_oAfmds78rVJ8JbP0Egf6he5yylEQ514526hpnOis5REzcp3yHDgbnlnJNosmwypIP8KO2q9U-VSKmpMhEZzU-Jp18xITrPvUjxVFTlQpCs5LOOvfo9RiTEqnaEgC86_MS_U4ht5275OUmAPjLc_9tnL8cYBtKB4HS',
  ),
  MenuItem(
    name: 'Uji Matcha Iced',
    description: 'Ceremonial grade Uji Matcha with oat milk.',
    price: 'Rp 38k',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuByarOprof0XXrvx5bYLFuR_08lfj4i9lVZnIAZtM6a9qGeqN6qYtSnwW3aYg4i15oepYw7mCraN5Tqg9P58hJYLLUbRPWq5NlTgvOy4Oz_eaRBNRwyM_qKCfrbMtKb_wzGR8LDbuMv1QNGD0a4f-E_nxuNgY7wf-N-RtZMIO5o3O4vD0xDEM2HXBHn_wHsDC_On2aeZZ2IXVwz8HqODjdjDrgpomSeow75pqA9YNRJuDntPbmF1EZ4cAEvicW_7QWapdz-MSrJf6vz',
    badge: 'New',
  ),
  MenuItem(
    name: 'Dark Mocha Chill',
    description: 'Fusion of Dutch cocoa and roasted espresso.',
    price: 'Rp 34k',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDdWnGQ9idGcZgkxO0Td3ieNzNKbgR7s2EHFZ0Wc8v9lWcGIXY9xkf9tHey_bYgUB3CZFS4957jys2oF9B_xvEJbAfg10kjQrIyzGttU8QOBZLc_qLPZ_vbVadH-LlpXm38LqCFc4vbmiRhrnkkW1rWXzm3pzeAdxRgzZ0I4u1OzEa8e8K6Hoa6r6i21jJP9JHj0Ec5yXrg9_EOoz4zOF4NR_0QBdniZrpCoEdvOIPmD5hJN9TPY8u89kFRXDNubyoj25hFWwaAKv_C',
  ),
  MenuItem(
    name: 'Midnight Pour-Over',
    description: 'Origin: Ethiopia Yirgacheffe. Hand-crafted by barista.',
    price: 'Rp 45k',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDFQgYoPkE2x3gUC6K867B4N1oe-jbw5aMJupzSF6g_qUQbOqh7Qtm5t6iAnQgQcRMiy6SYFSrZ_k9qgdlDuh5Fx_X8Clq-1YcCfMFq1fAf3xXrtLAHgzcwbPMjpNeenhXRVZmOULHw9l5XuEC2WpUf2yQycYMaqYUcTKyi63ZJHxWrVMV4ei7RLOPu9-KRa7ZgYhnnRp_YgmXg3byXSwgRqbI3Zlv3mr133xREU7_UVRj1pWRprKZKzCepGzPfh04ZpzD46pleKnTY',
  ),
];

const _categories = ['Kopi Dingin', 'Kopi Panas', 'Makanan'];

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedCategory = 0;
  int _navIndex = 0;
  int _cartCount = 0;
  final Set<int> _cartItems = {};

  void _addToCart(int index) {
    setState(() {
      if (!_cartItems.contains(index)) {
        _cartItems.add(index);
        _cartCount++;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          '${_menuItems[index].name} ditambahkan ke keranjang',
          style: GoogleFonts.manrope(color: AppColors.onSurface, fontSize: 13),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() => _navIndex = index);
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/status');
        break;
      case 2:
        Navigator.pushNamed(context, '/cart');
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      appBar: AppTopBar(
        showMenu: true,
        showBag: true,
        cartCount: _cartCount,
        onCartTap: () => Navigator.pushNamed(context, '/cart'),
      ),
      body: CustomScrollView(
        slivers: [
          // Dot pattern background
          SliverToBoxAdapter(
            child: SizedBox(
              height: 0,
              child: CustomPaint(
                painter: _DotPatternPainter(),
              ),
            ),
          ),

          // Category Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_categories.length, (i) {
                    final isSelected = i == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.secondary
                                : AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            _categories[i],
                            style: GoogleFonts.manrope(
                              color: isSelected
                                  ? AppColors.onSecondary
                                  : AppColors.onSurfaceVariant,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          // Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OUR SIGNATURE SELECTION',
                    style: GoogleFonts.manrope(
                      color: AppColors.primary.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Daily Brews',
                    style: GoogleFonts.manrope(
                      color: AppColors.onSurface,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _MenuCard(
                  item: _menuItems[index],
                  inCart: _cartItems.contains(index),
                  onAdd: () => _addToCart(index),
                ),
                childCount: _menuItems.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
            ),
          ),

          // Editorial Quote
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 1,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '"Coffee is the art of extracting the soul of a bean into a single moment of clarity."',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      color: AppColors.onSurface.withOpacity(0.5),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'MASTER ROASTER • EST 2020',
                    style: GoogleFonts.manrope(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _MenuCard extends StatefulWidget {
  final MenuItem item;
  final bool inCart;
  final VoidCallback onAdd;

  const _MenuCard({
    required this.item,
    required this.inCart,
    required this.onAdd,
  });

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scale;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _scale = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.94,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _scale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _scale.reverse();
        setState(() => _hovered = true);
      },
      onTapUp: (_) {
        _scale.forward();
        setState(() => _hovered = false);
      },
      onTapCancel: () {
        _scale.forward();
        setState(() => _hovered = false);
      },
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      scale: _hovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: CachedNetworkImage(
                        imageUrl: widget.item.imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.surfaceContainer,
                          child: const Icon(
                            Icons.coffee,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.surface.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Badge
                    if (widget.item.badge != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: widget.item.badge == 'Best Seller'
                                ? AppColors.secondary.withOpacity(0.9)
                                : AppColors.outlineVariant.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.item.badge!,
                            style: GoogleFonts.manrope(
                              color: widget.item.badge == 'Best Seller'
                                  ? AppColors.onSecondary
                                  : AppColors.onSurface,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Info
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: GoogleFonts.manrope(
                        color: AppColors.onSurface,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.item.price,
                      style: GoogleFonts.manrope(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.item.description,
                      style: GoogleFonts.manrope(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),

                    // Add Button
                    GestureDetector(
                      onTap: widget.onAdd,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: widget.inCart
                              ? AppColors.secondaryContainer
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              widget.inCart
                                  ? Icons.check
                                  : Icons.add_shopping_cart,
                              color: widget.inCart
                                  ? AppColors.secondary
                                  : AppColors.onPrimary,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.inCart ? 'Added' : 'ADD',
                              style: GoogleFonts.manrope(
                                color: widget.inCart
                                    ? AppColors.secondary
                                    : AppColors.onPrimary,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.outlineVariant.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    const spacing = 40.0;
    const radius = 1.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
