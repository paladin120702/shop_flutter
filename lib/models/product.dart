import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite(String token, uId) {
    isFavorite = !isFavorite;
    notifyListeners();
    put(
      Uri.parse(
          'https://shop-bd047-default-rtdb.firebaseio.com/favorites/$uId/$id.json?auth=$token'),
      body: jsonEncode(isFavorite),
    );
  }
}
