import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/app/domain/models/shoe_model.dart';
import 'package:shoes_app/app/presentation/globals/widgets/shoe_card.dart';
import 'package:shoes_app/app/presentation/modules/detail/controllers/detail_controller.dart';

import '../../../globals/widgets/buttons.dart';
import '../../../globals/widgets/shoe_description.dart';
import '../../home/views/home_view.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final detailController = context.watch<DetailController>();
    final state = detailController.state;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: '1',
            child: ShoeCard.detail(
              shoe: shoe,
              imagePath: state.selectedColor.imagePath,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: '2',
                  child: Material(
                    child: ShoeDescription(
                      title: shoe.name,
                      description: shoe.description,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${shoe.price}',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    const _AnimatedBuyButton(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const _ColorsRow(),
                const _OptionsRow(),
                const _CustomGridView(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class _ColorsRow extends StatelessWidget {
  const _ColorsRow();

  @override
  Widget build(BuildContext context) {
    final detailController = context.watch<DetailController>();
    final state = detailController.state;
    double index = 0.0;
    return Row(
      children: shoe.colors.map(
        (color) {
          final circle = Transform.translate(
            offset: Offset(-5 * index, 0),
            child: _ColorOption(
              color,
              state.selectedColor == color,
            ),
          );
          index = index + 1.3;
          return circle;
        },
      ).toList(),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final ShoesColors shoeColor;
  final bool isSelected;
  const _ColorOption(this.shoeColor, this.isSelected);

  @override
  Widget build(BuildContext context) {
    final detailController = context.watch<DetailController>();
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: shoeColor.color,
          border: (isSelected)
              ? Border.all(
                  color: const Color.fromARGB(255, 101, 101, 101),
                  width: 3,
                )
              : null,
        ),
      ),
      onTap: () => detailController.updateSelectedColor(shoeColor),
    );
  }
}

class _OptionsRow extends StatelessWidget {
  const _OptionsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedIconButton(
            icon: Icons.favorite,
            onTap: () {},
          ),
          RoundedIconButton(
            icon: Icons.shopping_cart,
            onTap: () {},
          ),
          RoundedIconButton(
            icon: Icons.settings,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _AnimatedBuyButton extends StatefulWidget {
  const _AnimatedBuyButton();

  @override
  State<_AnimatedBuyButton> createState() => __AnimatedBuyButtonState();
}

class __AnimatedBuyButtonState extends State<_AnimatedBuyButton> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -14),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInCirc,
      ),
    );
    animationController.forward(from: 0);
    animationController.addListener(
      () {
        if (animationController.status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (animationController.status == AnimationStatus.dismissed) {
          Future.delayed(const Duration(seconds: 4), () {
            if (mounted) {
              animationController.forward();
            }
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: animation.value,
            child: MainButton(
              text: 'Buy now',
              onPressed: () {},
            ),
          );
        });
  }
}

class _CustomGridView extends StatelessWidget {
  const _CustomGridView();

  @override
  Widget build(BuildContext context) {
    return Container();
    // return GridView.custom(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   gridDelegate: SliverWovenGridDelegate.count(
    //     crossAxisCount: 2,
    //     mainAxisSpacing: 2,
    //     crossAxisSpacing: 2,
    //     pattern: [
    //       const WovenGridTile(1),
    //       const WovenGridTile(
    //         5 / 7,
    //         crossAxisRatio: 0.9,
    //         alignment: AlignmentDirectional.centerEnd,
    //       ),
    //     ],
    //   ),
    //   childrenDelegate: SliverChildBuilderDelegate(
    //     (context, index) => Container(
    //       color: Colors.red,
    //     ),
    //   ),
    // );
  }
}
