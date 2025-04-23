import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:flutter_application_1/app/store/hive_boxes.dart';
import 'package:flutter_application_1/app/store/models/product_model.dart';
import 'package:flutter_application_1/app/store/models/setting_model.dart';
import 'package:flutter_application_1/app/store/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(SettingModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  if (!Hive.isBoxOpen(HiveBoxes.productBox)) {
    await Hive.openBox<ProductModel>(HiveBoxes.productBox);
  }
  if (!Hive.isBoxOpen(HiveBoxes.settingBox)) {
    await Hive.openBox<SettingModel>(HiveBoxes.settingBox);
  }
  if (!Hive.isBoxOpen(HiveBoxes.userBox)) {
    await Hive.openBox<UserModel>(HiveBoxes.userBox);
  }

  await Firebase.initializeApp();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
