import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:flutter_application_1/app/store/hive_boxes.dart';
import 'package:flutter_application_1/app/store/models/product_model.dart';
import 'package:flutter_application_1/app/store/models/setting_model.dart';
import 'package:flutter_application_1/app/store/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

// import 'firebase_options.dart';

// bool shouldUseFirestoreEmulator = true;

Future<Uint8List> loadBundleSetup(int number) async {
  // endpoint serves a bundle with 3 documents each containing
  // a 'number' property that increments in value 1-3.
  final url =
      Uri.https('api.rnfirebase.io', '/firestore/e2e-tests/bundle-$number');
  final response = await http.get(url);
  String string = response.body;
  return Uint8List.fromList(string.codeUnits);
}

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
  // FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: true,
  // );
  // if (shouldUseFirestoreEmulator) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // }
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
