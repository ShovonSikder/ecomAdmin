import 'package:ecom_admin/pages/add_product_page.dart';
import 'package:ecom_admin/pages/category_page.dart';
import 'package:ecom_admin/pages/order_list_page.dart';
import 'package:ecom_admin/pages/settings_page.dart';
import 'package:ecom_admin/pages/user_list_page.dart';
import 'package:ecom_admin/pages/view_product_page.dart';
import 'package:flutter/material.dart';

import '../pages/report_page.dart';

class DashboardModel {
  final String title;
  final IconData iconData;
  final String routeName;

  const DashboardModel({
    required this.title,
    required this.iconData,
    required this.routeName,
  });
}

const List<DashboardModel> dashboardModelList = [
  DashboardModel(
      title: 'Add Product',
      iconData: Icons.add,
      routeName: AddProductPage.routeName),
  DashboardModel(
      title: 'View Product',
      iconData: Icons.card_giftcard,
      routeName: ViewProductPage.routeName),
  DashboardModel(
      title: 'Categories',
      iconData: Icons.category,
      routeName: CategoryPage.routeName),
  DashboardModel(
      title: 'Orders',
      iconData: Icons.monetization_on,
      routeName: OrderListPage.routeName),
  DashboardModel(
      title: 'Users',
      iconData: Icons.person,
      routeName: UserListPage.routeName),
  DashboardModel(
      title: 'Settings',
      iconData: Icons.settings,
      routeName: SettingsPage.routeName),
  DashboardModel(
      title: 'Reports',
      iconData: Icons.pie_chart,
      routeName: ReportPage.routeName),
];
