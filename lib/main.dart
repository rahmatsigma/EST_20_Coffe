import 'package:flutter/material.dart';
import 'package:est20coffee/theme/app_theme.dart';
import 'package:est20coffee/screens/welcome_screen.dart';
import 'package:est20coffee/screens/main_menu_screen.dart';
import 'package:est20coffee/screens/order_review_screen.dart';
import 'package:est20coffee/screens/qris_payment_screen.dart';
import 'package:est20coffee/screens/order_registered_screen.dart';
import 'package:est20coffee/screens/order_received_screen.dart';
import 'package:est20coffee/screens/order_status_screen.dart';

void main() {
  runApp(const Est20CoffeeApp());
}

class Est20CoffeeApp extends StatelessWidget {
  const Est20CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EST 20 COFFEE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/menu': (context) => const MainMenuScreen(),
        '/cart': (context) => const OrderReviewScreen(),
        '/qris': (context) => const QrisPaymentScreen(),
        '/registered': (context) => const OrderRegisteredScreen(),
        '/received': (context) => const OrderReceivedScreen(),
        '/status': (context) => const OrderStatusScreen(),
      },
    );
  }
}
