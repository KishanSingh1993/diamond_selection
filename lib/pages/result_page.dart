import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../bloc/diamond_bloc.dart';
import '../bloc/diamond_event.dart';
import '../bloc/diamond_state.dart';
import 'cart_page.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    // Load cart state when ResultPage is first displayed
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              final itemCount = (cartState is CartLoaded) ? cartState.cart.length : 0;
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage())),
                  ),
                  if (itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$itemCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text('Sort By'),
            items: [
              DropdownMenuItem(value: 'priceAsc', child: Text('Price Ascending')),
              DropdownMenuItem(value: 'priceDesc', child: Text('Price Descending')),
              DropdownMenuItem(value: 'caratAsc', child: Text('Carat Ascending')),
              DropdownMenuItem(value: 'caratDesc', child: Text('Carat Descending')),
            ],
            onChanged: (value) {
              if (value != null) {
                context.read<DiamondBloc>().add(FilterDiamonds(
                  caratFrom: 0,
                  caratTo: double.infinity,
                  lab: '',
                  shape: '',
                  color: '',
                  clarity: '',
                  sortBy: value,
                ));
              }
            },
          ),
          Expanded(
            child: BlocBuilder<DiamondBloc, DiamondState>(
              builder: (context, diamondState) {
                if (diamondState is DiamondLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (diamondState is DiamondError) {
                  return Center(child: Text('Error: ${diamondState.message}'));
                }
                if (diamondState is DiamondLoaded) {
                  if (diamondState.diamonds.isEmpty) {
                    return Center(child: Text('No diamonds match your criteria.'));
                  }
                  return BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      final cartItems = (cartState is CartLoaded) ? cartState.cart : [];
                      return ListView.builder(
                        itemCount: diamondState.diamonds.length,
                        itemBuilder: (context, index) {
                          final diamond = diamondState.diamonds[index];
                          final isInCart = cartItems.any((item) => item.lotId == diamond.lotId);
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Lot ID: ${diamond.lotId}'),
                                  Text('Size: ${diamond.size}'),
                                  Text('Carat: ${diamond.carat}'),
                                  Text('Lab: ${diamond.lab}'),
                                  Text('Shape: ${diamond.shape}'),
                                  Text('Color: ${diamond.color}'),
                                  Text('Clarity: ${diamond.clarity}'),
                                  Text('Cut: ${diamond.cut}'),
                                  Text('Polish: ${diamond.polish}'),
                                  Text('Symmetry: ${diamond.symmetry}'),
                                  Text('Fluorescence: ${diamond.fluorescence}'),
                                  Text('Discount: ${diamond.discount}%'),
                                  Text('Per Carat Rate: \$${diamond.perCaratRate}'),
                                  Text('Final Amount: \$${diamond.finalAmount}'),
                                  Text('Key To Symbol: ${diamond.keyToSymbol}'),
                                  Text('Lab Comment: ${diamond.labComment}'),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: isInCart
                                          ? null
                                          : () => context.read<CartBloc>().add(AddToCart(diamond)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isInCart ? Colors.grey : null,
                                      ),
                                      child: Text(isInCart ? 'Added to Cart' : 'Add to Cart'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(child: Text('Please apply a filter to see results.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/cart_bloc.dart';
// import '../bloc/cart_event.dart';
// import '../bloc/diamond_bloc.dart';
// import '../bloc/diamond_event.dart';
// import '../bloc/diamond_state.dart';
// import 'cart_page.dart';
//
// class ResultPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Results'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage())),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           DropdownButton<String>(
//             hint: Text('Sort By'),
//             items: [
//               DropdownMenuItem(value: 'priceAsc', child: Text('Price Ascending')),
//               DropdownMenuItem(value: 'priceDesc', child: Text('Price Descending')),
//               DropdownMenuItem(value: 'caratAsc', child: Text('Carat Ascending')),
//               DropdownMenuItem(value: 'caratDesc', child: Text('Carat Descending')),
//             ],
//             onChanged: (value) {
//               if (value != null) {
//                 // Re-apply the last filter with the new sort
//                 context.read<DiamondBloc>().add(FilterDiamonds(
//                   caratFrom: 0, // Use actual last filter values if stored
//                   caratTo: double.infinity,
//                   lab: '',
//                   shape: '',
//                   color: '',
//                   clarity: '',
//                   sortBy: value,
//                 ));
//               }
//             },
//           ),
//           Expanded(
//             child: BlocBuilder<DiamondBloc, DiamondState>(
//               builder: (context, state) {
//                 if (state is DiamondLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (state is DiamondError) {
//                   return Center(child: Text('Error: ${state.message}'));
//                 }
//                 if (state is DiamondLoaded) {
//                   if (state.diamonds.isEmpty) {
//                     return Center(child: Text('No diamonds match your criteria.'));
//                   }
//                   return ListView.builder(
//                     itemCount: state.diamonds.length,
//                     itemBuilder: (context, index) {
//                       final diamond = state.diamonds[index];
//                       return Card(
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Lot ID: ${diamond.lotId}'),
//                               Text('Size: ${diamond.size}'),
//                               Text('Carat: ${diamond.carat}'),
//                               Text('Lab: ${diamond.lab}'),
//                               Text('Shape: ${diamond.shape}'),
//                               Text('Color: ${diamond.color}'),
//                               Text('Clarity: ${diamond.clarity}'),
//                               Text('Cut: ${diamond.cut}'),
//                               Text('Polish: ${diamond.polish}'),
//                               Text('Symmetry: ${diamond.symmetry}'),
//                               Text('Fluorescence: ${diamond.fluorescence}'),
//                               Text('Discount: ${diamond.discount}%'),
//                               Text('Per Carat Rate: \$${diamond.perCaratRate}'),
//                               Text('Final Amount: \$${diamond.finalAmount}'),
//                               Text('Key To Symbol: ${diamond.keyToSymbol}'),
//                               Text('Lab Comment: ${diamond.labComment}'),
//                               Center(
//                                 child: ElevatedButton(
//                                   onPressed: () => context.read<CartBloc>().add(AddToCart(diamond)),
//                                   child: Text('Add to Cart'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return Center(child: Text('Please apply a filter to see results.'));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }