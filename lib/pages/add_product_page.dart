import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/date_model.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/models/purchase_model.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add_product';
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late ProductProvider _productProvider;
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _longDescriptionController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _discountController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _quantityController = TextEditingController();

  String? thumbnailImageLocalPath;
  CategoryModel? categoryModel;
  DateTime? purchaseDate;

  late StreamSubscription<ConnectivityResult> subscription;

  bool isConnected = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productNameController.dispose();
    _shortDescriptionController.dispose();
    _longDescriptionController.dispose();
    _salePriceController.dispose();
    _discountController.dispose();
    _purchasePriceController.dispose();
    _quantityController.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    isConnectedToInternet().then((value) {
      setState(() {
        isConnected = value;
      });
    });

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {
          isConnected = true;
        });
      } else {
        setState(() {
          isConnected = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Product',
        ),
        actions: [
          IconButton(
            onPressed: isConnected ? _saveProduct : null,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              children: [
                if (!isConnected)
                  const ListTile(
                    tileColor: Colors.black,
                    title: Text(
                      'Please connect to internet',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    'Add New Product',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          child: thumbnailImageLocalPath == null
                              ? const Icon(
                                  Icons.photo_camera_back_sharp,
                                  size: 100,
                                )
                              : Image.file(
                                  File(
                                    thumbnailImageLocalPath!,
                                  ),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                _pickImage(ImageSource.camera);
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text(
                                'Open Camera',
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                _pickImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.photo_album),
                              label: const Text(
                                'Open Gallery',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //drop down
                Consumer<ProductProvider>(
                  builder: (context, provider, child) =>
                      DropdownButtonFormField<CategoryModel>(
                    hint: const Text('Select Category'),
                    value: categoryModel,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    items: provider.categoryList
                        .map(
                          (cateModel) => DropdownMenuItem<CategoryModel>(
                            value: cateModel,
                            child: Text(
                              cateModel.categoryName,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        categoryModel = value;
                      });
                    },
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                    prefixIcon: Icon(Icons.card_giftcard),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _shortDescriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Short Description (optional)',
                    prefixIcon: Icon(Icons.description),
                    filled: true,
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _longDescriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Long Description (optional)',
                    prefixIcon: Icon(Icons.description),
                    filled: true,
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _salePriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sale Price',
                    prefixIcon: Icon(Icons.price_change),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not empty';
                    }
                    if (num.parse(value) <= 0) {
                      return 'Price should be greater than 0';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _discountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Discount',
                    prefixIcon: Icon(Icons.discount),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not empty';
                    }
                    if (num.parse(value) < 0) {
                      return 'Discount should not be a negative value';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _purchasePriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Purchase Price',
                    prefixIcon: Icon(Icons.monetization_on),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not empty';
                    }
                    if (num.parse(value) <= 0) {
                      return 'Price should be greater than 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    prefixIcon: Icon(Icons.production_quantity_limits),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: _selectDate,
                          icon: const Icon(Icons.calendar_month),
                          label: const Text('Select Purchase Date'),
                        ),
                        Text(purchaseDate == null
                            ? 'No Date chosen'
                            : getFormattedDate(purchaseDate!)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _selectDate() async {
    final _date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now());

    if (_date != null) {
      setState(() {
        purchaseDate = _date;
      });
    }
  }

  void _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 70,
    );
    if (pickedImage != null) {
      setState(() {
        thumbnailImageLocalPath = pickedImage.path;
      });
    }
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      if (thumbnailImageLocalPath == null) {
        showMsg(context, 'Please select a product image');
        return;
      }
      if (purchaseDate == null) {
        showMsg(context, 'Please select a purchase date');
        return;
      }

      EasyLoading.show(status: 'Please wait', dismissOnTap: false);

      String? downloadUrl;
      try {
        downloadUrl =
            await _productProvider.uploadImage(thumbnailImageLocalPath!);

        final productModel = ProductModel(
          productName: _productNameController.text,
          shortDescription: _shortDescriptionController.text.isEmpty
              ? null
              : _shortDescriptionController.text,
          longDescription: _longDescriptionController.text.isEmpty
              ? null
              : _longDescriptionController.text,
          category: categoryModel!,
          productDiscount: num.parse(_discountController.text),
          salePrice: num.parse(_salePriceController.text),
          stock: num.parse(_quantityController.text),
          thumbnailImageUrl: downloadUrl,
        );

        final purchaseModel = PurchaseModel(
            purchaseQuantity: num.parse(_quantityController.text),
            purchasePrice: num.parse(_purchasePriceController.text),
            dateModel: DateModel(
              timestamp: Timestamp.fromDate(purchaseDate!),
              day: purchaseDate!.day,
              month: purchaseDate!.month,
              year: purchaseDate!.year,
            ));

        await _productProvider.addNewProduct(productModel, purchaseModel);
        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Saved');
        }
        _resetFields();
      } catch (err) {
        if (downloadUrl != null) {
          await _productProvider.deleteImage(downloadUrl);
        }

        showMsg(context, 'Something went wrong');
        EasyLoading.dismiss();
        print(err.toString());
      }
    }
  }

  void _resetFields() {
    setState(() {
      _productNameController.clear();
      _shortDescriptionController.clear();
      _longDescriptionController.clear();
      _salePriceController.clear();
      _discountController.clear();
      _purchasePriceController.clear();
      _quantityController.clear();
      categoryModel = null;
      purchaseDate = null;
      thumbnailImageLocalPath = null;
    });
  }
}
