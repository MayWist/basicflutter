import 'package:basic_flutter/viewmodel/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = Provider.of<ProductViewModel>(context);
    final product = productViewModel.selectedProduct;
    return Scaffold(
      appBar: AppBar(title: Text("Product Detail")),
      body: Column(children: [Text(product.title), Text("${product.id}")]),
    );
  }
}
