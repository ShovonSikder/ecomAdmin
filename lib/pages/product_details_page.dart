import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin/customwidgets/image_holder_view.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/pages/product_repurcharse_page.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/product_details';
  ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productModel;

  late ProductProvider provider;
  late Size size;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    size = MediaQuery.of(context).size;
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    provider = Provider.of<ProductProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
      ),
      body: ListView(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(7),
                bottomLeft: Radius.circular(7)),
            child: CachedNetworkImage(
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
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageHolderView(
                  onImagePressed: (url) {
                    _showImageOnDialog(0);
                  },
                  url: productModel.additionalImages[0],
                  child: IconButton(
                    onPressed: () {
                      _addImage(0);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                ImageHolderView(
                    onImagePressed: (url) {
                      _showImageOnDialog(1);
                    },
                    url: productModel.additionalImages[1],
                    child: IconButton(
                      onPressed: () {
                        _addImage(1);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
                ImageHolderView(
                    onImagePressed: (url) {
                      _showImageOnDialog(2);
                    },
                    url: productModel.additionalImages[2],
                    child: IconButton(
                      onPressed: () {
                        _addImage(2);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
              ],
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
          ListTile(
            title: Text(productModel.productName),
            subtitle: Text(productModel.category.categoryName),
          ),
          ListTile(
            title: Text('Sale Price: ${productModel.salePrice}\$'),
            subtitle: Text('Stock: ${productModel.stock}'),
          ),
          SwitchListTile(
              title: const Text('Available'),
              value: productModel.available,
              onChanged: (value) {
                setState(() {
                  productModel.available = !productModel.available;
                });
                provider.updateProductField(productModel.productId!,
                    productFieldAvailable, productModel.available);
              }),
          SwitchListTile(
              title: const Text('Featured'),
              value: productModel.featured,
              onChanged: (value) {
                setState(() {
                  productModel.featured = !productModel.featured;
                });
                provider.updateProductField(productModel.productId!,
                    productFieldFeatured, productModel.featured);
              }),
        ],
      ),
    );
  }

  void _showPurchaseHistory(BuildContext context, ProductModel productModel) {
    showModalBottomSheet(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
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

  void _addImage(int index) async {
    // print(productModel.additionalImages);

    final selectedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (selectedFile != null) {
      EasyLoading.show(status: 'Image uploading');
      try {
        final downloadUrl = await provider.uploadImage(selectedFile.path);
        if (productModel.additionalImages[index].isNotEmpty) {
          await provider.deleteImage(productModel.additionalImages[index]);
        }
        productModel.additionalImages[index] = downloadUrl;
        // print(productModel.additionalImages);

        await provider.updateProductField(productModel.productId!,
            productFieldAdditionalImages, productModel.additionalImages);

        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Uploaded Successfully');
          setState(() {});
        }
      } catch (err) {
        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Uploading failed');
        }
        rethrow;
      }
    }
  }

  void _showImageOnDialog(int index) {
    String url = productModel.additionalImages[index];
    showDialog(
      barrierLabel: 'Full Image',
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          IconButton(
            onPressed: () {
              _addImage(index);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
          IconButton(
            onPressed: () async {
              EasyLoading.show(status: 'Deleting...');
              try {
                await provider.deleteImage(url);
                productModel.additionalImages[index] = '';
                await provider.updateProductField(
                    productModel.productId!,
                    productFieldAdditionalImages,
                    productModel.additionalImages);
                EasyLoading.dismiss();
                if (mounted) {
                  showMsg(context, 'Deleted');
                }
                setState(() {});
              } catch (err) {
                EasyLoading.dismiss();
                showMsg(context, 'Failed to delete');
              }
            },
            icon: const Icon(Icons.browse_gallery),
          ),
        ],
        content: CachedNetworkImage(
          // fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: LinearProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }
}
