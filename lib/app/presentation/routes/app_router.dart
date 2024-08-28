import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/app/domain/models/shoe_model.dart';
import 'package:shoes_app/app/presentation/modules/detail/controllers/detail_controller.dart';
import 'package:shoes_app/app/presentation/modules/detail/states/detail_state.dart';
import 'package:shoes_app/app/presentation/modules/detail/views/detail_view.dart';
import 'package:shoes_app/app/presentation/modules/home/views/home_view.dart';
import 'package:shoes_app/app/presentation/routes/routes.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    final route = settings.name;
    final args = settings.arguments as Map<String, dynamic>?;

    switch (route) {
      case Routes.home:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            );
          },
        );

      case Routes.detail:
        final shoe = args?['shoe'] as ShoeModel;
        final selectedSize = args?['selectedSize'] as String;

        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          reverseTransitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (context, animation, secondaryAnimation) => ChangeNotifierProvider(
            create: (_) => DetailController(
              state: DetailState(
                shoe: shoe,
                selectedSize: selectedSize,
              ),
            ),
            child: const DetailView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 2.0);
            const end = Offset.zero;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOutQuart));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
    }
    return null;
  }
}
