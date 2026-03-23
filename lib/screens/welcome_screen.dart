import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:est20coffee/theme/app_theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -48,
            right: -48,
            child: Opacity(
              opacity: 0.06,
              child: Icon(
                Icons.eco,
                size: 260,
                color: AppColors.outlineVariant,
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Opacity(
              opacity: 0.06,
              child: Transform.rotate(
                angle: -0.2,
                child: Icon(
                  Icons.local_cafe,
                  size: 300,
                  color: AppColors.outlineVariant,
                ),
              ),
            ),
          ),

          // Fine line pattern
          Positioned.fill(
            child: CustomPaint(painter: _LinePatternPainter()),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Header
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WELCOME TO THE ATELIER',
                            style: GoogleFonts.manrope(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Selamat\nDatang',
                            style: GoogleFonts.manrope(
                              color: AppColors.primary,
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                              letterSpacing: -2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 48,
                            height: 2,
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Center portion with coffee icon
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Center(
                      child: Column(
                        children: [
                          // Coffee icon glow
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      AppColors.secondary.withOpacity(0.12),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.surfaceContainerLow,
                                  border: Border.all(
                                    color: AppColors.outlineVariant.withOpacity(0.3),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 24,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.coffee,
                                  color: AppColors.secondary,
                                  size: 64,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 48),

                          // Description
                          Text(
                            'Rasakan pengalaman kopi terbaik\nyang diseduh khusus untuk Anda.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 40),

                          // QR Scan Button
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/menu'),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainer,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.outlineVariant.withOpacity(0.15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  // Gradient overlay
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.primary.withOpacity(0.06),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      children: [
                                        // Scanner graphic with corner accents
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.qr_code_scanner,
                                              color: AppColors.primary,
                                              size: 88,
                                            ),
                                            // Corner accents
                                            ..._buildCornerAccents(),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          'Scan QR di Meja Anda',
                                          style: GoogleFonts.manrope(
                                            color: AppColors.primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'UNTUK MULAI PESAN',
                                          style: GoogleFonts.manrope(
                                            color: AppColors.onSurfaceVariant.withOpacity(0.6),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Footer branding
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 32,
                                  height: 1,
                                  color: AppColors.outlineVariant,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'EST 20 COFFEE',
                                  style: GoogleFonts.manrope(
                                    color: AppColors.primary.withOpacity(0.4),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 32,
                                  height: 1,
                                  color: AppColors.outlineVariant,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'PREMIUM ROASTERY & LAB',
                              style: GoogleFonts.manrope(
                                color: AppColors.outlineVariant,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCornerAccents() {
    const size = 100.0;
    const accentSize = 16.0;

    return [
      Positioned(
        top: (size - accentSize) / 2 - 2,
        left: (size - accentSize) / 2 - 2,
        child: _CornerAccent(
          isTop: true,
          isLeft: true,
          size: accentSize,
        ),
      ),
      Positioned(
        top: (size - accentSize) / 2 - 2,
        right: (size - accentSize) / 2 - 2,
        child: _CornerAccent(
          isTop: true,
          isLeft: false,
          size: accentSize,
        ),
      ),
      Positioned(
        bottom: (size - accentSize) / 2 - 2,
        left: (size - accentSize) / 2 - 2,
        child: _CornerAccent(
          isTop: false,
          isLeft: true,
          size: accentSize,
        ),
      ),
      Positioned(
        bottom: (size - accentSize) / 2 - 2,
        right: (size - accentSize) / 2 - 2,
        child: _CornerAccent(
          isTop: false,
          isLeft: false,
          size: accentSize,
        ),
      ),
    ];
  }
}

class _CornerAccent extends StatelessWidget {
  final bool isTop;
  final bool isLeft;
  final double size;

  const _CornerAccent({
    required this.isTop,
    required this.isLeft,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerPainter(
          isTop: isTop,
          isLeft: isLeft,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final bool isTop;
  final bool isLeft;
  final Color color;

  _CornerPainter({
    required this.isTop,
    required this.isLeft,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (isTop && isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (isTop && !isLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!isTop && isLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LinePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.outlineVariant.withOpacity(0.06)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw decorative curved lines
    final path1 = Path();
    path1.moveTo(size.width * 0.5, size.height * 0.1);
    path1.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.9,
    );
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(size.width * 0.3, size.height * 0.1);
    path2.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.5,
      size.width * 0.3,
      size.height * 0.9,
    );
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
