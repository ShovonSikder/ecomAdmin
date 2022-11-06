import 'package:ecom_admin/models/product_model.dart';
import 'package:flutter/material.dart';

import '../utils/helper_functions.dart';

class ProductRepurchasePage extends StatefulWidget {
  static const String routeName = '/product_repurchase';
  const ProductRepurchasePage({Key? key}) : super(key: key);

  @override
  State<ProductRepurchasePage> createState() => _ProductRepurchasePageState();
}

class _ProductRepurchasePageState extends State<ProductRepurchasePage> {
  late ProductModel productModel;
  final _formKey = GlobalKey<FormState>();

  final _purchasePriceController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? purchaseDate;

  @override
  void dispose() {
    // TODO: implement dispose
    _purchasePriceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repurchase'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                productModel.productName,
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
          ),
        ),
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
}
