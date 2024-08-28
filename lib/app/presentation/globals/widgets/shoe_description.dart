import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoeDescription extends StatelessWidget {
  final String title;
  final String description;
  const ShoeDescription({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
