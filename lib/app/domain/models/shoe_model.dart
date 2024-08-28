import 'package:flutter/material.dart';

const defaultDescription =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas cursus risus eu diam cursus suscipit eget eu sem. Nunc placerat convallis diam sed tincidunt. Etiam lacinia, augue nec finibus ullamcorper, diam mauris molestie sem, eu elementum nulla diam nec augue.';

enum ShoesColors {
  yellow(Color.fromARGB(255, 248, 194, 43), 'assets/imgs/amarillo.png'),
  blue(Color.fromARGB(255, 43, 111, 248), 'assets/imgs/azul.png'),
  black(Color.fromARGB(255, 41, 41, 43), 'assets/imgs/negro.png'),
  green(Color.fromARGB(255, 132, 186, 70), 'assets/imgs/verde.png');

  const ShoesColors(this.color, this.imagePath);
  final Color color;
  final String imagePath;
}

class ShoeModel {
  final String name;
  final String description;
  final String price;

  final List<String> sizes;
  final List<ShoesColors> colors;

  ShoeModel({
    required this.name,
    String? description,
    required this.price,
    required this.sizes,
    required this.colors,
  }) : description = description ?? defaultDescription;
}
