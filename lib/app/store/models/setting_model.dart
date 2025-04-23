import 'package:hive_flutter/hive_flutter.dart';

part 'setting_model.g.dart';

@HiveType(typeId: 1)
class SettingModel extends HiveObject {
  @HiveField(0)
  String theme;

  SettingModel({
    required this.theme,
  });
}
