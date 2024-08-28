import 'package:shoes_app/app/domain/models/shoe_model.dart';

class HomeState {
  final ShoeModel shoe;
  final String selectedSize;

  HomeState({
    required this.shoe,
    String? selectedSize,
  }) : selectedSize = selectedSize ?? shoe.sizes[0];

  HomeState copyWith({
    ShoeModel? shoe,
    String? selectedSize,
  }) =>
      HomeState(
        shoe: shoe ?? this.shoe,
        selectedSize: selectedSize ?? this.selectedSize,
      );
}
