import 'package:flutter/material.dart';
import 'package:shoes_app/app/presentation/globals/utils/colors.dart';
import 'package:shoes_app/app/presentation/routes/app_router.dart';
import 'package:shoes_app/app/presentation/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mainOrange,
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
