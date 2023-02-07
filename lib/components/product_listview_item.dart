import 'package:basic_flutter/model/product/product.dart';
import 'package:basic_flutter/viewmodel/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductListViewItem extends StatelessWidget {
  const ProductListViewItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    Text title_item = Text(
      product.title,
      style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    );
    Text price_item = Text("${product.price} \$",
        style: const TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red));
    Text category = Text(product.category);

    ProductViewModel productViewModel = Provider.of<ProductViewModel>(context);
    RatingBar reatbar = RatingBar.builder(
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      initialRating: product.rating!.toDouble(),
      onRatingUpdate: (double value) {},
      itemSize: 20,
      allowHalfRating: true,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.cyan,
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(product.thumbnail),
                        fit: BoxFit.cover)),
                width: 200,
                height: 200,
                margin: const EdgeInsets.all(12.0),
              ),
              Expanded(
                child: Column(
                  children: [title_item, price_item, reatbar, category],
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          productViewModel.setSelectedProduct(product);
          Navigator.pushNamed(context, "/ProductDetail");
        },
      ),
    );
  }
}
