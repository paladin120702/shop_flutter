import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/data_urls.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = [];
  final String _token;
  final String _uId;

  ProductList([this._token = '', this._uId = '', this._items = const []]);

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await get(
      Uri.parse('${DataUrls.DATABASE_PRODUCTS_URL}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favoriteResponse = await get(
      Uri.parse(
          '${DataUrls.DATABASE_USER_FAVORITES_URL}/$_uId.json?auth=$_token'),
    );

    Map<String, dynamic> favData = favoriteResponse.body == 'null'
        ? {}
        : jsonDecode(favoriteResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await post(
      Uri.parse('${DataUrls.DATABASE_PRODUCTS_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await patch(
        Uri.parse(
            '${DataUrls.DATABASE_PRODUCTS_URL}/${product.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await delete(
        Uri.parse(
            '${DataUrls.DATABASE_PRODUCTS_URL}/${product.id}.json?auth=$_token'),
      );
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
