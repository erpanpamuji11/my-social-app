
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mysocial_app/app/core/utils/dependency_injection.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_item.dart';
import 'package:mysocial_app/app/routes/app_pages.dart';

void main() async {
  await Hive.initFlutter();
  DependencyInjection.init();
  Hive.registerAdapter(PostItemAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    );
  }
}
