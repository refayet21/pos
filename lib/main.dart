import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/firebase_options.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  var initialRoute = await Routes.initialRoute;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  // var cart = FlutterCart();
  // await cart.initializeCart(isPersistenceSupportEnabled: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   initialRoute: initialRoute,
    //   getPages: Nav.routes,
    // );

    return ScreenUtilInit(
//  responsiveWidgets: responsiveWidgets,
      ensureScreenSize: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        getPages: Nav.routes,
        // theme: ThemeData.light(
        //   useMaterial3: true,
        //   // color: Colors.green,
        // ),
      ),
    );
  }
}
