import 'package:flutter_application_1/app/store/models/product_model.dart';
import 'package:flutter_application_1/app/store/models/setting_model.dart';
import 'package:flutter_application_1/app/store/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static const String productBox = 'productBox';
  static const String settingBox = 'settingBox';
  static const String userBox = 'userBox';

  static Box<ProductModel> getProductModel() => Hive.box(productBox);
  static Box<SettingModel> getSettingModel() => Hive.box(settingBox);
  static Box<UserModel> getUserModel() => Hive.box(userBox);
}
