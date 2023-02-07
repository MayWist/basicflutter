import 'package:basic_flutter/model/product/model_error.dart';
import 'package:basic_flutter/model/product/product.dart';
import 'package:basic_flutter/model/product/productmodelapi.dart';
import 'package:basic_flutter/repository/api_status.dart';
import 'package:basic_flutter/repository/products_services.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  ProductsModel? _productsListModel;
  late Product _selectedProduct;
  ModelError? _modelError;
  bool _displaymode = true;
  bool get displaymode => _displaymode;
  IconData _icondisplaymode = Icons.grid_view_outlined;
  IconData get icondisplaymode => _icondisplaymode;

  ModelError? get modelError => _modelError;
  Product get selectedProduct => _selectedProduct;
  ProductsModel? get productsListModel => _productsListModel;

  ProductViewModel() {
    getProductsList();
  }
  setModelError(ModelError modelError) {
    _modelError = modelError;
  }

  setDisplayMode(bool displaymode) {
    _displaymode = displaymode;
    if (displaymode) {
      _icondisplaymode = Icons.grid_view_outlined;
    } else {
      _icondisplaymode = Icons.list;
    }
    notifyListeners();
  }

  setSelectedProduct(Product selectedProduct) {
    _selectedProduct = selectedProduct;
  }

  setProductsListModel(ProductsModel productsListModel) {
    _productsListModel = productsListModel;
  }

  getProductsList() async {
    if (_productsListModel != null) {
      return _productsListModel;
    }
    var response = await ProductsServices.getProducts();
    if (response is Success) {
      setProductsListModel(response.response as ProductsModel);
    }

    if (response is Failure) {
      ModelError modelError = ModelError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setModelError(modelError);
    }
  }
}
