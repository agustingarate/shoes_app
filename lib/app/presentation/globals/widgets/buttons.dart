import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/app/presentation/globals/utils/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const MainButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          AppColors.orange4,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunito(),
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const RoundedIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(68, 149, 149, 149),
              blurRadius: 20,
              spreadRadius: 1,
              offset: Offset(
                0,
                10,
              ),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: AppColors.gray1,
        ),
      ),
    );
  }
}
