import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Screens/editproduct_screen.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../Widgets/userProduct_item.dart';
import '../Widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static var routename = "/UserProductsScreen";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routename);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].title,
                productsData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
