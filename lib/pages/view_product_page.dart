import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/pages/product_details_page.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName = '/view_product';
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  CategoryModel? categoryModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Consumer<ProductProvider>(
              builder: (context, provider, child) =>
                  DropdownButtonFormField<CategoryModel>(
                hint: const Text('Select Category'),
                value: categoryModel,
                isExpanded: true,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                items: provider
                    .getCategoryListForFiltering()
                    .map((catModel) => DropdownMenuItem(
                        value: catModel, child: Text(catModel.categoryName)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    categoryModel = value;
                  });
                  provider.getAllProductsByCategory(categoryModel!);
                },
              ),
            ),
            Expanded(
              child: provider.productList.isEmpty
                  ? const Center(
                      child: Text('No Product found'),
                    )
                  : ListView.builder(
                      itemCount: provider.productList.length,
                      itemBuilder: (context, index) {
                        final productModel = provider.productList[index];
                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailsPage.routeName,
                                arguments: productModel);
                          },
                          leading: CachedNetworkImage(
                            width: 75,
                            imageUrl: productModel.thumbnailImageUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                          title: Text(productModel.productName),
                          subtitle: Text(productModel.category.categoryName),
                          trailing: Text('Stock: ${productModel.stock}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
