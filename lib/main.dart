import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/splash_screen.dart';
import '../providers/auth.dart';
import '../Screens/cart_screen.dart';
import '../Screens/orders_screen.dart';
import '../Screens/userProducts_screen.dart';
import '../providers/orders.dart';
import '../Screens/product_detail_screen.dart';
import '../Screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import '../Screens/editproduct_screen.dart';
import 'Screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders('', '', []),
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
          ),
          // ChangeNotifierProvider(
          //   create: (ctx) => Orders(),
          // ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products('', '', []),
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          // ChangeNotifierProvider(
          //   create: (ctx) => Products(),
          // ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Lato',
            ),
            //home: productsOverScreen(),
            home: auth.isAuth
                ? productsOverScreen()
                : FutureBuilder(
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                    future: auth.tryAutoLogin(),
                  ),
            routes: {
              productDetailsScreen.routeName: (ctx) => productDetailsScreen(),
              cartScreen.routeName: (ctx) => cartScreen(),
              OrderScreen.routename: (ctx) => OrderScreen(),
              UserProductsScreen.routename: (ctx) => UserProductsScreen(),
              EditProductScreen.routename: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
