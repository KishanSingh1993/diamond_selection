import '../models/diamond.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Diamond diamond;

  AddToCart(this.diamond);
}

class RemoveFromCart extends CartEvent {
  final String lotId;

  RemoveFromCart(this.lotId);
}