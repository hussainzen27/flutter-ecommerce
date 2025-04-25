import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/store/hive_boxes.dart';
import 'package:flutter_application_1/app/store/models/user_model.dart';
import 'package:hive/hive.dart';

class UserService {
  UserModel getUser() {
    final box = HiveBoxes.getUserModel();
    if (box.isEmpty) {
      // Return a default or dummy user, or handle it however you prefer
      return UserModel(id: '', name: '', email: '');
    }
    return HiveBoxes.getUserModel().values.first;
  }

  Future<void> signIn(String email, String password) async {
    try {
      final res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final box = await Hive.openBox<UserModel>(HiveBoxes.userBox);
      await box.add(UserModel(
          id: res.user!.uid,
          name: res.user!.displayName ?? 'Anonymous',
          email: res.user!.email!));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      final res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await res.user!.updateDisplayName(name);
      final box = await Hive.openBox<UserModel>(HiveBoxes.userBox);
      await box.add(UserModel(
          id: res.user!.uid,
          name: name ?? 'Anonymous',
          email: res.user!.email!));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final box = await Hive.openBox<UserModel>(HiveBoxes.userBox);
      await box.clear();
    } catch (e) {
      print(e);
    }
  }
}
