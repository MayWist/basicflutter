import 'dart:io';

import 'package:basic_flutter/model/product/model_error.dart';
import 'package:basic_flutter/model/product/product.dart';
import 'package:basic_flutter/repository/api_status.dart';
import 'package:basic_flutter/repository/products_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PartnerViewModel extends ChangeNotifier {
  File? _imageprofile;
  ModelError? _modelError;

  Product? _productsAction;
  String _productTitle = "";

  String get productTitle => _productTitle;
  Product? get productsAction => _productsAction;

  File? get imageprofile => _imageprofile;
  ModelError? get modelError => _modelError;

  setProductTitle(String value) {
    _productTitle = value;
  }

  setModelError(ModelError modelError) {
    _modelError = modelError;
  }

  setProductsAction(Product product) {
    _productsAction = product;
  }

  setImageProfile(File value) {
    _imageprofile = value;
  }

  deleteProductsId(String id) async {
    var response = await ProductsServices.deleteProducts(id);
    productActionApi(response, "Delete Product");
  }

  addProductForm(String title) async {
    var response = await ProductsServices.addProduct(title);
    productActionApi(response, "Add Product");
  }

  updateProductId(String title, String price) async {
    var response =
        await ProductsServices.updateProduct(title, int.parse(price));
    productActionApi(response, "Update Product");
  }

  productActionApi(response, String title) {
    setProductTitle(title);
    print("title is : $title");

    if (response is Success) {
      print("productActionApi Success");
      setProductsAction(response.response as Product);
    }
    if (response is Failure) {
      print("productActionApi Failure");

      ModelError modelError = ModelError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setModelError(modelError);
    }
    notifyListeners();
  }

  Future pickerImage(source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      final imgSave = await saveImage(img.path);
      setImageProfile(imgSave);
      notifyListeners();
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  Future<File> saveImage(String path) async {
    final dir = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final img = File('${dir.path}/$name');
    return File(path).copy(img.path);
  }
}
