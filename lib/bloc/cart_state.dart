import 'package:equatable/equatable.dart';
import '../models/diamond.dart';

abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<Diamond> cart;

  CartLoaded({required this.cart});

  @override
  List<Object> get props => [cart];
}