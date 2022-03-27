import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavourite;
     _setFavValue(!isFavourite);
    final url = Uri.parse(
        'https://flutter-prac-db-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: jsonEncode(
          isFavourite,
        ),
      );
      
      if (response.statusCode >= 400) {
         _setFavValue(oldStatus);
      }
    } catch (e) {
      // TODO
      _setFavValue(oldStatus);
    }
  }
}
