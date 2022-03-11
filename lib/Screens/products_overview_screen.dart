import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/app_drawer.dart';
import '../Widgets/ProductsGrid.dart';
import '../Widgets/badge.dart';
import '../providers/cart.dart';
import '../Screens/cart_screen.dart';
import '../providers/products_provider.dart';

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
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); would work only with listen:False

    //this will also work but its a hack
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });

    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
