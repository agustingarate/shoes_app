import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/app/presentation/globals/utils/colors.dart';

import '../../../domain/models/shoe_model.dart';

enum ShoeCardType {
  main,
  detail,
}

extension ShoeCardTypeExtension on ShoeCardType {
  getBorderRadius(BuildContext context) {
    final topRadius = MediaQuery.viewPaddingOf(context).top;

    return this == ShoeCardType.main
        ? BorderRadius.circular(45)
        : BorderRadius.vertical(
            top: Radius.circular(topRadius),
            bottom: const Radius.circular(
              50,
            ),
          );
  }

  // getImagePath() => this == ShoeCardType.detail ? imagePath! : shoe.colors[0].imagePath;
}

class ShoeCard extends StatelessWidget {
  final ShoeModel shoe;
  final String? selectedSize;
  final List<String>? sizes;
  final Function(String number)? onSizePressed;
  final ShoeCardType shoeCardType;
  final String? imagePath;

  const ShoeCard.main({
    super.key,
    required this.shoe,
    required this.selectedSize,
    required this.sizes,
    required this.onSizePressed,
  })  : shoeCardType = ShoeCardType.main,
        imagePath = null;

  const ShoeCard.detail({
    super.key,
    required this.shoe,
    required this.imagePath,
  })  : selectedSize = null,
        sizes = null,
        onSizePressed = null,
        shoeCardType = ShoeCardType.detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainYellow,
        borderRadius: shoeCardType.getBorderRadius(context),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (shoeCardType == ShoeCardType.detail)
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        if (!kIsWeb)
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.mainWhite,
                              size: 30,
                            ),
                            onTap: () => context.pop(),
                          ),
                      ],
                    ),
                  _Shoe(
                    shoeCardType == ShoeCardType.detail ? imagePath! : shoe.colors[0].imagePath,
                  ),
                ],
              ),
            ),
            if (shoeCardType == ShoeCardType.main)
              Transform.translate(
                offset: const Offset(0, -50),
                child: _Sizes(
                  sizes: sizes!,
                  selectedSize: selectedSize!,
                  onPressed: onSizePressed!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Shoe extends StatelessWidget {
  final String imagePath;
  const _Shoe(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          FadeInImage(
            placeholder: Image.asset('assets/imgs/negro.png').image,
            image: Image.asset(
              imagePath,
            ).image,
          ),
          Transform.translate(
            offset: const Offset(5, -40),
            child: Transform.rotate(
              angle: 2.7,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orange3,
                      blurRadius: 45,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Sizes extends StatelessWidget {
  final String selectedSize;
  final List<String> sizes;
  final Function(String number) onPressed;
  const _Sizes({required this.selectedSize, required this.sizes, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 20,
      children: sizes
          .map(
            (number) => GestureDetector(
              onTap: () => onPressed(number),
              child: _SizeNumber(
                isActive: number == selectedSize ? true : false,
                number: number.toString(),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SizeNumber extends StatelessWidget {
  final bool isActive;
  final String number;
  const _SizeNumber({required this.isActive, required this.number});

  @override
  Widget build(BuildContext context) {
    final white = AppColors.mainWhite;
    final orange = AppColors.secondaryOrange;
    final activeColor = isActive ? orange : white;
    final activeTextColor = isActive ? white : orange;

    return AnimatedSize(
      duration: const Duration(milliseconds: 900),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        constraints: const BoxConstraints(
          minWidth: 34,
          minHeight: 34,
        ),
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (isActive)
              BoxShadow(
                offset: const Offset(4, 6),
                color: AppColors.orange4,
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            color: activeTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
