import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/diamond.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString('cart') ?? '[]';
      final List<dynamic> cartList = jsonDecode(cartJson);
      final cart = cartList.map((json) => Diamond.fromJson(json)).toList();
      emit(CartLoaded(cart: cart));
    });

    on<AddToCart>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedCart = List<Diamond>.from(currentState.cart)..add(event.diamond);
        await _saveCart(updatedCart);
        emit(CartLoaded(cart: updatedCart));
      }
    });

    on<RemoveFromCart>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedCart = List<Diamond>.from(currentState.cart)..removeWhere((d) => d.lotId == event.lotId);
        await _saveCart(updatedCart);
        emit(CartLoaded(cart: updatedCart));
      }
    });
  }

  Future<void> _saveCart(List<Diamond> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(cart.map((d) => d.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }
}