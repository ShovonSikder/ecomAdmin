import 'package:ecom_admin/models/order_constant_model.dart';
import 'package:ecom_admin/providers/order_provider.dart';
import 'package:ecom_admin/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  final _discountController = TextEditingController();

  final _vatController = TextEditingController();

  final _deliveryChargeController = TextEditingController();
  late OrderProvider orderProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    orderProvider = Provider.of<OrderProvider>(context);
    _discountController.text =
        orderProvider.orderConstantModel.discount.toString();
    _vatController.text = orderProvider.orderConstantModel.vat.toString();
    _deliveryChargeController.text =
        orderProvider.orderConstantModel.deliveryCharge.toString();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _discountController.dispose();
    _vatController.dispose();
    _deliveryChargeController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings page'),
      ),
      body: Center(
        child: Card(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(24),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _discountController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.discount),
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Discount',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field must not be empty';
                      }
                      if (num.parse(value) < 0) {
                        return 'Discount should not be less than 0';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _vatController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter VAT',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field must not be empty';
                      }
                      if (num.parse(value) < 0) {
                        return 'VAT should not be less than 0';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _deliveryChargeController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Delivery Charge',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field must not be empty';
                      }
                      if (num.parse(value) < 0) {
                        return 'Delivery charge should not be less than 0';
                      }
                      return null;
                    },
                  ),
                ),
                OutlinedButton(
                  onPressed: _updateUtilsConstant,
                  child: const Text('Update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateUtilsConstant() {
    if (_formKey.currentState!.validate()) {
      final orderConstantModel = OrderConstantModel(
        discount: num.parse(_discountController.text),
        vat: num.parse(_vatController.text),
        deliveryCharge: num.parse(_deliveryChargeController.text),
      );
      EasyLoading.show(status: 'Updating...');
      orderProvider.updateOrderConstant(orderConstantModel).then((value) {
        EasyLoading.dismiss();
        showMsg(context, 'Updated Successfully');
      }).catchError((err) {
        EasyLoading.dismiss();
        showMsg(context, 'Failed to update');
      });
    }
  }
}
