import 'package:basic_flutter/model/product/product.dart';
import 'package:basic_flutter/viewmodel/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridViewItem extends StatelessWidget {
  const ProductGridViewItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    Image img_item = Image.network(product.thumbnail, fit: BoxFit.cover);
    Text title_item = Text(product.title);
    Text price_item = Text("${product.price} \$");
    Text discountPercentage_item = Text("${product.discountPercentage} %");
    ProductViewModel productViewModel = Provider.of<ProductViewModel>(context);
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(child: img_item),
            title_item,
            price_item,
            discountPercentage_item
          ],
        ),
      ),
      onTap: () async {
        productViewModel.setSelectedProduct(product);
        Navigator.pushNamed(context, "/ProductDetail");
      },
    );
  }
}
