import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/providers/product.dart';
import '../Widgets/ProductsGrid.dart';

class productsOverScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Shop',
        ),
      ),
      body: ProductsGrid(),
    );
  }
}


