import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_complete_guide/Screens/product_detail_screen.dart';
import 'package:flutter_complete_guide/Screens/products_overview_screen.dart';
import 'Screens/products_overview_screen.dart';
import './providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
        ),
        home: productsOverScreen(),
        routes: {
          productDetailsScreen.routeName: (ctx) => productDetailsScreen(),
        },
      ),
    );
  }
}
