import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.SALES,
      page: () => const SalesScreen(),
      binding: SalesControllerBinding(),
    ),
    GetPage(
      name: Routes.ITEM,
      page: () => const ItemScreen(),
      binding: ItemControllerBinding(),
    ),
    GetPage(
      name: Routes.RECEIPTS,
      page: () => const ReceiptsScreen(),
      binding: ReceiptsControllerBinding(),
    ),
    GetPage(
      name: Routes.CATEGORY,
      page: () => const CategoryScreen(),
      binding: CategoryControllerBinding(),
    ),
    GetPage(
      name: Routes.CUSTOMER,
      page: () => const CustomerScreen(),
      binding: CustomerControllerBinding(),
    ),
  ];
}
