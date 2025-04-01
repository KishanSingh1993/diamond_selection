import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cart_bloc.dart';
import 'bloc/diamond_bloc.dart';
import 'pages/filter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DiamondBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diamond Selection',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FilterPage(),
      ),
    );
  }
}