// State management

import 'package:flutter_application_1/app/store/models/user_model.dart';
import 'package:flutter_application_1/app/store/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceProvider = Provider((ref) => UserService());

class UserNotifier extends StateNotifier<UserModel> {
  final UserService service;

  UserNotifier(this.service) : super(service.getUser());

  void signIn(String email, String password) async {
    try {
      print('eeeee $email, $password');
      await service.signIn(email, password);
      state = service.getUser();
    } catch (e) {
      print(e);
    }
  }

  void signUp(String email, String password, String name) async {
    await service.signUp(email, password, name);
    state = service.getUser();
  }

  void signOut() async {
    await service.signOut();
    state = service.getUser();
  }
}

final userStateProvider = StateNotifierProvider<UserNotifier, UserModel>((ref) {
  final service = ref.watch(userServiceProvider);
  return UserNotifier(service);
});
