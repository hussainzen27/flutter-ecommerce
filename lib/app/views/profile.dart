import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/store/hive_boxes.dart';
import 'package:flutter_application_1/app/store/models/user_model.dart';
import 'package:flutter_application_1/app/store/providers/settings_provider.dart';
import 'package:flutter_application_1/app/store/providers/user_provider.dart';
import 'package:flutter_application_1/app/store/services/user_service.dart';
import 'package:flutter_application_1/app/widgets/DataApp/profileCircularImage.dart';
import 'package:flutter_application_1/app/widgets/DataApp/profileHeader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void signOut() {
    try {
      ref.read(userStateProvider.notifier).signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingStateProvider);
    final userDetails = ref.watch(userStateProvider);
    print('${userDetails.name}, ${userDetails.email}, ${userDetails.id}');
    return (Scaffold(
      body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Column(
                children: [
                  const ProfileHeader(),
                  Padding(
                    padding: const EdgeInsets.only(top: 105.0),
                    child: Text(
                      userDetails.name ?? '',
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(110, 104, 59, 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      userDetails.email ?? '',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Toggle Dark Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                        Switch(
                          value: theme,
                          activeTrackColor:
                              const Color.fromRGBO(0, 128, 128, 1),
                          onChanged: (bool value) {
                            ref
                                .read(settingServiceProvider)
                                .toggleDarkMode(value ? 'dark' : 'light');
                            ref.read(settingStateProvider.notifier).state =
                                value;
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                        IconButton(
                            onPressed: signOut,
                            icon: const Icon(
                              Icons.logout,
                            ))
                      ],
                    ),
                  )
                ],
              ),
              const ProfileCircularImage()
            ],
          )),
    ));
  }
}
