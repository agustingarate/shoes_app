import 'package:shoes_app/app/domain/models/shoe_model.dart';

class DetailState {
  final String shoeId;
  final String selectedSize;
  final ShoesColors selectedColor;

  DetailState({
    required this.shoeId,
    String? selectedSize,
    ShoesColors? selectedColor,
  })  : selectedSize = selectedSize ?? '1',
        selectedColor = selectedColor ?? ShoesColors.black;

  DetailState copyWith({
    String? shoeId,
    String? selectedSize,
    ShoesColors? selectedColor,
  }) =>
      DetailState(
        shoeId: shoeId ?? this.shoeId,
        selectedSize: selectedSize ?? this.selectedSize,
        selectedColor: selectedColor ?? this.selectedColor,
      );
}
