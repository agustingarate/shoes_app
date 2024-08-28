import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/app/presentation/globals/utils/colors.dart';
import 'package:shoes_app/app/presentation/globals/widgets/buttons.dart';

class BottomBar extends StatelessWidget {
  final String price;
  final Function()? onPressed;
  const BottomBar({super.key, required this.price, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$$price',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          MainButton(
            text: 'Add to cart',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
