import 'package:flutter_application_1/app/store/hive_boxes.dart';
import 'package:flutter_application_1/app/store/models/setting_model.dart';

class SettingsService {
  Future<void> toggleDarkMode(String value) async {
    final setting = SettingModel(theme: value);
    HiveBoxes.getSettingModel().put('theme', setting);
  }

  SettingModel? get theme => HiveBoxes.getSettingModel().get('theme');

  bool get isDarkMode => theme?.theme == 'dark';
}
