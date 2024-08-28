import 'package:shoes_app/app/domain/models/shoe_model.dart';

class DetailState {
  final ShoeModel shoe;
  final String selectedSize;
  final ShoesColors selectedColor;

  DetailState({
    required this.shoe,
    String? selectedSize,
    ShoesColors? selectedColor,
  })  : selectedSize = selectedSize ?? shoe.sizes[0],
        selectedColor = selectedColor ?? ShoesColors.black;

  DetailState copyWith({
    ShoeModel? shoe,
    String? selectedSize,
    ShoesColors? selectedColor,
  }) =>
      DetailState(
        shoe: shoe ?? this.shoe,
        selectedSize: selectedSize ?? this.selectedSize,
        selectedColor: selectedColor ?? this.selectedColor,
      );
}
