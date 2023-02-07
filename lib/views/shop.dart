import 'package:basic_flutter/components/product_gridview_item.dart';
import 'package:basic_flutter/components/product_listview_item.dart';
import 'package:basic_flutter/model/product/model_error.dart';
import 'package:basic_flutter/model/product/product.dart';
import 'package:basic_flutter/model/product/productmodelapi.dart';
import 'package:basic_flutter/viewmodel/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Shop..."),
          actions: [
            Icon(productViewModel.icondisplaymode),
            Switch(
                value: productViewModel.displaymode,
                onChanged: (onChanged) {
                  productViewModel.setDisplayMode(onChanged);
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: FutureBuilder(
              future: productViewModel.getProductsList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return bindingUi(productViewModel);
                }
                return const LinearProgressIndicator();
              }),
        ));
  }

  Widget bindingUi(ProductViewModel productViewModel) {
    if (productViewModel.productsListModel != null) {
      bool displaymode = productViewModel.displaymode;
      int length = productViewModel.productsListModel!.products.length;
      ProductsModel productsModel = productViewModel.productsListModel!;
      if (displaymode) {
        return ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              Product product = productsModel.products[index];
              return ProductListViewItem(
                product: product,
              );
            });
      } else {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              Product product = productsModel.products[index];
              return ProductGridViewItem(product: product);
            });
      }
    } else {
      ModelError error = productViewModel.modelError!;

      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                color: Colors.red,
                size: 60,
              ),
              Text(error.message,
                  style: TextStyle(color: Colors.red, fontSize: 50))
            ]),
      );
    }
  }
}
