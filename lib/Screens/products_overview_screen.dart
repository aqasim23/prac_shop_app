import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/ProductsGrid.dart';
import '../Widgets/badge.dart';
import '../providers/cart.dart';
import '../Screens/cart_screen.dart';

enum FilterOptions {
  Favourites,
  All,
}

class productsOverScreen extends StatefulWidget {
  @override
  State<productsOverScreen> createState() => _productsOverScreenState();
}

class _productsOverScreenState extends State<productsOverScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Shop',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favourites',
                ),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All',
                ),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartObject, child) => Badge(
              child: child,
              value: cartObject.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(cartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
