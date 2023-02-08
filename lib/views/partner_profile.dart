import 'package:basic_flutter/model/product/product.dart';
import 'package:basic_flutter/viewmodel/partner_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PartnerProfile extends StatefulWidget {
  const PartnerProfile({super.key});

  @override
  State<PartnerProfile> createState() => _PartnerProfileState();
}

class _PartnerProfileState extends State<PartnerProfile> {
  late TextEditingController productId;
  late TextEditingController productnameadd;
  late TextEditingController productnameupdate;
  late TextEditingController productprice;

  @override
  void initState() {
    super.initState();
    productId = TextEditingController();
    productnameadd = TextEditingController();
    productnameupdate = TextEditingController();
    productprice = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    PartnerViewModel partnerViewModel = Provider.of<PartnerViewModel>(context);

    Widget img = partnerViewModel.imageprofile != null
        ? Image.file(
            partnerViewModel.imageprofile!,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          )
        : Image.asset("img/profile.png");

    return Scaffold(
        appBar: AppBar(title: const Text("Profile Partner/Produt")),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: img,
              ),
              ElevatedButton(
                  onPressed: () {
                    partnerViewModel.pickerImage(ImageSource.gallery);
                  },
                  child: const Text("Pick Gallery")),
              ElevatedButton(
                  onPressed: () {
                    partnerViewModel.pickerImage(ImageSource.camera);
                  },
                  child: const Text("Pick Cammera")),
              const SizedBox(height: 30),
              TextField(
                controller: productId,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product id ',
                ),
                keyboardType: TextInputType.number,
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  partnerViewModel.deleteProductsId(productId.text);
                  showDialog(
                      context: context,
                      builder: (context) => dialog(
                          context,
                          partnerViewModel.productTitle,
                          partnerViewModel.productsAction!));
                },
                icon: const Icon(
                  Icons.delete,
                  size: 24.0,
                ),
                label: const Text('Delete Product From id'),
              ),
              const Divider(),
              TextField(
                controller: productnameadd,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add Product [Title]',
                ),
                keyboardType: TextInputType.text,
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  partnerViewModel.addProductForm(productnameadd.text);

                  showDialog(
                      context: context,
                      builder: (context) => dialog(
                          context,
                          partnerViewModel.productTitle,
                          partnerViewModel.productsAction!));
                },
                icon: const Icon(
                  Icons.add,
                  size: 24.0,
                ),
                label: const Text('Add Products'),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: productnameupdate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Update Product Title ',
                ),
              ),
              TextField(
                controller: productprice,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Update Product Price',
                ),
                keyboardType: TextInputType.number,
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  partnerViewModel.updateProductId(
                      productnameupdate.text, productprice.text);

                  showDialog(
                      context: context,
                      builder: (context) => dialog(
                          context,
                          partnerViewModel.productTitle,
                          partnerViewModel.productsAction!));
                },
                icon: const Icon(
                  Icons.update,
                  size: 24.0,
                ),
                label: const Text('Update Products'),
              ),
            ],
          ),
        ));
  }
}

dialog(context, String title, Product product) {
  return AlertDialog(
    title: Text(title),
    content: bindingUi(product),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Back"))
    ],
  );
}

bindingUi(Product product) {
  Text idItem = Text("ID : ${product.id}");
  Text titleItem = Text(product.title);
  Text priceItem = Text("${product.price} \$");
  Text brandItem = Text(product.brand);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [idItem, titleItem, priceItem, brandItem],
  );
}
