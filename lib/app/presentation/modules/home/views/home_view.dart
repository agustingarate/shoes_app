import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/app/domain/models/shoe_model.dart';
import 'package:shoes_app/app/presentation/globals/widgets/shoe_card.dart';
import 'package:shoes_app/app/presentation/globals/widgets/shoe_description.dart';
import 'package:shoes_app/app/presentation/modules/home/widgets/bottom_bar.dart';
import 'package:shoes_app/app/presentation/modules/home/widgets/custom_appbar.dart';

import '../../../routes/routes.dart';
import '../controllers/home_controller.dart';
import '../states/home_state.dart';

final shoe = ShoeModel(
  name: 'Nike Air Max 720',
  price: '180',
  sizes: ['4', '3.5', '6', '8.3', '8', '9.5'],
  colors: [
    ShoesColors.black,
    ShoesColors.blue,
    ShoesColors.green,
    ShoesColors.yellow,
  ],
);

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget _bottomBar({
    String? price,
    Function()? onPressed,
  }) =>
      BottomBar(
        price: price ?? '',
        onPressed: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeController(
            state: HomeState(shoe: shoe),
          ),
        ),
      ],
      child: Scaffold(
        body: Builder(builder: (context) {
          final homeController = context.watch<HomeController>();
          final state = homeController.homeState;
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                right: 25,
                left: 25,
                bottom: 20,
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        const CustomAppBar(
                          title: 'For you',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          animationDuration: const Duration(milliseconds: 1000),
                          child: Hero(
                            tag: '1',
                            child: ShoeCard.main(
                              shoe: state.shoe,
                              sizes: state.shoe.sizes,
                              selectedSize: state.selectedSize,
                              onSizePressed: (number) => homeController.updateSelectedSize(number),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ShoeDescription(
                          title: state.shoe.name,
                          description: state.shoe.description,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Visibility.maintain(
                            visible: false,
                            child: _bottomBar(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: _bottomBar(
                      price: state.shoe.price,
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.detail,
                        arguments: {
                          'shoe': state.shoe,
                          'selectedSize': state.selectedSize,
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
