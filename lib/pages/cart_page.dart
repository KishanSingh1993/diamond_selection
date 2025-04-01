import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(LoadCart());
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial) return Center(child: CircularProgressIndicator());
          if (state is CartLoaded) {
            final cart = state.cart;
            final totalCarat = cart.fold(0.0, (sum, item) => sum + item.carat);
            final totalPrice = cart.fold(0.0, (sum, item) => sum + item.finalAmount);
            final avgPrice = cart.isEmpty ? 0 : totalPrice / cart.length;
            final avgDiscount = cart.isEmpty ? 0 : cart.fold(0.0, (sum, item) => sum + item.discount) / cart.length;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final diamond = cart[index];
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Lot ID: ${diamond.lotId}'),
                              Text('Carat: ${diamond.carat}'),
                              Text('Final Amount: \$${diamond.finalAmount}'),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () => context.read<CartBloc>().add(RemoveFromCart(diamond.lotId)),
                                  child: Text('Remove'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Total Carat: $totalCarat'),
                      Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
                      Text('Average Price: \$${avgPrice.toStringAsFixed(2)}'),
                      Text('Average Discount: ${avgDiscount.toStringAsFixed(2)}%'),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}