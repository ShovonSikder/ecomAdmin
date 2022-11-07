import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/pages/product_repurcharse_page.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/product_details';
  ProductDetailsPage({Key? key}) : super(key: key);

  late ProductModel productModel;
  late ProductProvider provider;

  @override
  Widget build(BuildContext context) {
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    provider = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: productModel.thumbnailImageUrl,
            height: 400,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(
                    context, ProductRepurchasePage.routeName,
                    arguments: productModel),
                child: const Text(
                  'Re-Purchase',
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  _showPurchaseHistory(context, productModel);
                },
                child: const Text(
                  'Purchase History',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPurchaseHistory(BuildContext context, ProductModel productModel) {
    showModalBottomSheet(
      shape: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) => FutureBuilder(
        future: provider.getAllPurchaseByProductId(productModel.productId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final purchaseList = snapshot.data;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: purchaseList!.length,
                    itemBuilder: (context, index) {
                      final purchaseModel = purchaseList[index];
                      return Card(
                        elevation: 0,
                        child: ListTile(
                          title: Text(
                            getFormattedDate(
                              purchaseModel.dateModel.timestamp.toDate(),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.monetization_on,
                                size: 15,
                              ),
                              Text(' ${purchaseModel.purchasePrice}'),
                            ],
                          ),
                          trailing:
                              Text('Q: ${purchaseModel.purchaseQuantity}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Database Error',
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [CircularProgressIndicator(), Text('Loading...')],
            ),
          );
        },
      ),
    );
  }
}
