import 'package:flutter/material.dart';

class productDetailsScreen extends StatelessWidget {
  // final String title;
  // final double price; 

  // productDetailsScreen(this.title, this.price);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
