import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/root_stack.dart';
import 'package:flutter_application_1/app/store/providers/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(settingStateProvider);
    return (MaterialApp(
      title: 'Hello World!!!',
      debugShowCheckedModeBanner: false,
      theme: theme == true
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: const RootStack(),
    ));
  }
}
