import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/settings_service.dart';

final settingServiceProvider = Provider((ref) => SettingsService());

final settingStateProvider = StateProvider<bool>((ref) {
  final settingService = ref.watch(settingServiceProvider);
  return settingService.isDarkMode;
});
