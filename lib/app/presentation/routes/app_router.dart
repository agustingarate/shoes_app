import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/app/presentation/modules/detail/controllers/detail_controller.dart';
import 'package:shoes_app/app/presentation/modules/detail/states/detail_state.dart';
import 'package:shoes_app/app/presentation/modules/detail/views/detail_view.dart';
import 'package:shoes_app/app/presentation/modules/home/views/home_view.dart';

import 'routes.dart';

class AppRouter {
  static final route = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/",
        name: Routes.home,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HomeView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
          path: '/details/:id',
          name: Routes.details,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'];

            return CustomTransitionPage(
              child: ChangeNotifierProvider(
                create: (_) {
                  return DetailController(
                    state: DetailState(
                      shoeId: id!,
                      selectedSize: state.uri.queryParameters['size'],
                    ),
                  );
                },
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
          }),
    ],
  );
}
