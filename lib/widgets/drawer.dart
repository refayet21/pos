import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';

import 'package:loyverspos/model/drawer_menu.dart';
import 'package:loyverspos/widgets/reuseable_drawer.dart';

class AdminDrawer extends StatelessWidget {
  final List<DrawerMenuItem> drawerItems = [
    DrawerMenuItem(
        title: 'HOME', routeName: Routes.HOME, icon: Icons.dashboard),
    // DrawerMenuItem(title: 'SALES', routeName: Routes.SALES, icon: Icons.sell),
    // DrawerMenuItem(
    //     title: 'CATEGORY', routeName: Routes.CATEGORY, icon: Icons.category),
    DrawerMenuItem(title: 'ITEM', routeName: Routes.ITEM, icon: Icons.list_alt),
    DrawerMenuItem(
        title: 'RECEIPTS', routeName: Routes.RECEIPTS, icon: Icons.receipt),

    DrawerMenuItem(
        title: 'CUSTOMER',
        routeName: Routes.CUSTOMER,
        icon: Icons.person_add_alt),
  ];
  AdminDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReuseAbleDrawer(
        header: DrawerHeader(
          child: Row(
            children: [
              // Your app logo or image
              // Image.asset(
              //   'assets/images/app_logo.png',
              //   width: 50,
              //   height: 50,
              // ),
              SizedBox(width: 16.w),
              // Your app name or title
              Text(
                'POS',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue, // Change this to your desired color
          ),
        ),
        menuItems: drawerItems);
  }
}
