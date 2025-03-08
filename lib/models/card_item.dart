import 'package:foodapp/models/food.dart';

class CardItem {
  Food food;
  List<Addon> selectedAddons;
  int quantity;

  CardItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  double get totalPrice {
    double addonsPrice = selectedAddons.fold(0,(sum, addon) => sum + addon.price);
    return (food.price + addonsPrice) * quantity;
  }

}