import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:est20coffee/theme/app_theme.dart';
import 'package:est20coffee/widgets/app_bars.dart';

enum _OrderStep { registered, preparing, ready, received }

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  _OrderStep _currentStep = _OrderStep.preparing;

  static const _steps = [
    _StepInfo(
      step: _OrderStep.registered,
      icon: Icons.receipt_long_rounded,
      title: 'Order Registered',
      subtitle: 'Pesanan Anda telah diterima sistem',
    ),
    _StepInfo(
      step: _OrderStep.preparing,
      icon: Icons.coffee_maker_outlined,
      title: 'Sedang Diproses',
      subtitle: 'Barista sedang menyiapkan kopi Anda',
    ),
    _StepInfo(
      step: _OrderStep.ready,
      icon: Icons.coffee_rounded,
      title: 'Pesanan Siap',
      subtitle: 'Silakan ambil pesanan Anda',
    ),
    _StepInfo(
      step: _OrderStep.received,
      icon: Icons.check_circle_rounded,
      title: 'Selesai',
      subtitle: 'Selamat menikmati kopi EST 20!',
    ),
  ];

  bool _isCompleted(_OrderStep step) =>
      step.index < _currentStep.index;
  bool _isCurrent(_OrderStep step) => step == _currentStep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppTopBar(showMenu: true, showBag: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'LIVE TRACKING',
              style: GoogleFonts.manrope(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Order Status',
              style: GoogleFonts.manrope(
                color: AppColors.onBackground,
                fontSize: 36,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Order info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.confirmation_number_outlined,
                      color: AppColors.secondary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER NUMBER',
                        style: GoogleFonts.manrope(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '#EST-2024-0042 • Meja 12',
                        style: GoogleFonts.manrope(
                          color: AppColors.secondary,
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
            const SizedBox(height: 32),

            // Progress steps
            Text(
              'PROGRESS',
              style: GoogleFonts.manrope(
                color: AppColors.onSurfaceVariant,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            Column(
              children: List.generate(_steps.length, (i) {
                final info = _steps[i];
                final completed = _isCompleted(info.step);
                final current = _isCurrent(info.step);
                final isLast = i == _steps.length - 1;

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline column
                      SizedBox(
                        width: 44,
                        child: Column(
                          children: [
                            // Icon circle
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: completed
                                    ? AppColors.secondary
                                    : current
                                        ? AppColors.secondary.withValues(alpha: 0.15)
                                        : AppColors.surfaceContainerHigh,
                                border: current
                                    ? Border.all(
                                        color: AppColors.secondary,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Icon(
                                completed
                                    ? Icons.check_rounded
                                    : info.icon,
                                color: completed
                                    ? const Color(0xFF261900)
                                    : current
                                        ? AppColors.secondary
                                        : AppColors.onSurface.withValues(alpha: 0.3),
                                size: 20,
                              ),
                            ),
                            // Connector line
                            if (!isLast)
                              Expanded(
                                child: Center(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    width: 2,
                                    color: completed
                                        ? AppColors.secondary
                                        : AppColors.outlineVariant.withValues(alpha: 0.3),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: isLast ? 0 : 28,
                            top: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info.title,
                                style: GoogleFonts.manrope(
                                  color: completed || current
                                      ? AppColors.onSurface
                                      : AppColors.onSurface.withValues(alpha: 0.4),
                                  fontSize: 16,
                                  fontWeight: current
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                info.subtitle,
                                style: GoogleFonts.manrope(
                                  color: current
                                      ? AppColors.secondary
                                      : AppColors.onSurfaceVariant
                                          .withValues(alpha: completed ? 0.7 : 0.4),
                                  fontSize: 12,
                                ),
                              ),
                              if (current) ...[
                                const SizedBox(height: 10),
                                _PulsingDots(),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 36),

            // Advance step button (for demo)
            if (_currentStep != _OrderStep.received)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentStep =
                        _OrderStep.values[_currentStep.index + 1];
                  });
                  if (_currentStep == _OrderStep.received) {
                    Future.delayed(const Duration(milliseconds: 600), () {
                      if (mounted) {
                        Navigator.pushNamed(context, '/received');
                      }
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'ADVANCE STATUS (DEMO)',
                    style: GoogleFonts.manrope(
                      color: AppColors.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/menu'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'KEMBALI KE MENU',
                  style: GoogleFonts.manrope(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepInfo {
  final _OrderStep step;
  final IconData icon;
  final String title;
  final String subtitle;

  const _StepInfo({
    required this.step,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _PulsingDots extends StatefulWidget {
  @override
  State<_PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<_PulsingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Row(
        children: List.generate(3, (i) {
          return Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
