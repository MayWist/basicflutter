import 'dart:convert';
import 'dart:io';

import 'package:basic_flutter/model/product/product.dart';
import 'package:basic_flutter/model/product/productmodelapi.dart';
import 'package:basic_flutter/repository/api_status.dart';
import 'package:basic_flutter/utility/constants.dart';
import 'package:http/http.dart' as http;

class ProductsServices {
  static Future<Object> getProducts() async {
    var response = await http.get(Uri.parse(PRODUCTS_LIST_URL));
    return callApi(response, true);
  }

  static Future deleteProducts(String id) async {
    final http.Response response = await http.delete(
      Uri.parse("$PRODUCTS_LIST_URL/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return callApi(response);
  }

  static Future addProduct(String title) async {
    List<String> list = ["1", "2"];
    Product product = Product(
        id: 200,
        title: title,
        description: "aaaaa",
        price: 9999999,
        discountPercentage: 22.2,
        rating: 2.4,
        stock: 1,
        brand: "brand",
        category: "category",
        thumbnail: "thumbnail",
        images: list);
    final response = await http.post(
      Uri.parse("$PRODUCTS_LIST_URL/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: productsToJson(product),
    );
    return callApi(response);
  }

  static Future updateProduct(String title, int price) async {
    List<String> list = ["1", "2"];
    final Product product = Product(
        id: 1,
        title: title,
        description: "aaaaa",
        price: price,
        discountPercentage: 2.2,
        rating: 2.3,
        stock: 10,
        brand: "brand",
        category: "category",
        thumbnail: "thumbnail",
        images: list);
    final response = await http.patch(Uri.parse("$PRODUCTS_LIST_URL/1"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'price': price,
          "discountPercentage": 2.41,
          "rating": 2.50,
        }));
    return callApi(response);
  }

  static Future<Object> callApi(http.Response response,
      [bool model = false]) async {
    try {
      print("CallApi StatusCode: ${response.statusCode}");
      print(response.request);
      print(response.body);
      if (SUCCESS == response.statusCode) {
        Object? res;
        if (model) {
          res = productsModelFromJson(response.body);
        } else {
          res = productsFromJson(response.body);
        }
        return Success(code: SUCCESS, response: res);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    }
  }
}
