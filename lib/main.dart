import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Screens/cart_screen.dart';
import 'package:flutter_complete_guide/Screens/orders_screen.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:provider/provider.dart';

import '../Screens/product_detail_screen.dart';
import '../Screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
        ),
        home: productsOverScreen(),
        routes: {
          productDetailsScreen.routeName: (ctx) => productDetailsScreen(),
          cartScreen.routeName: (ctx) => cartScreen(),
          OrderScreen.routename: (ctx) => OrderScreen(),
        },
      ),
    );
  }
}
