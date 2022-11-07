import 'package:ecom_admin/auth/auth_service.dart';
import 'package:ecom_admin/customwidgets/dashboard_item_view.dart';
import 'package:ecom_admin/models/dashboard_model.dart';
import 'package:ecom_admin/pages/launcher_page.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logOut().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName));
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) =>
            DashboardItemView(dashboardModel: dashboardModelList[index]),
      ),
    );
  }
}
