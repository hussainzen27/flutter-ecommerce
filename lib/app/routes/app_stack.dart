import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/views/addproduct.dart';
import 'package:flutter_application_1/app/views/home.dart';
import 'package:flutter_application_1/app/views/profile.dart';

class AppStack extends StatefulWidget {
  final int initialIndex;

  const AppStack({super.key, this.initialIndex = 0});

  @override
  State<AppStack> createState() => _AppStackState();
}

class _AppStackState extends State<AppStack> {
  late int currentPageIndex;

  @override
  void initState() {
    // TODO: implement initState
    currentPageIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (settings) {
      WidgetBuilder builder;
      switch (settings.name) {
        case '/':
          builder = (context) => (Scaffold(
              floatingActionButton: SizedBox(
                height: 70.0,
                width: 70.0,
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 60, 192, 192),
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 1;
                    });
                  },
                  shape: ShapeBorder.lerp(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      0.5),
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                indicatorColor: currentPageIndex == 1
                    ? Colors.transparent
                    : const Color.fromARGB(255, 60, 192, 192),
                selectedIndex: currentPageIndex,
                destinations: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: const NavigationDestination(
                      selectedIcon: Icon(Icons.home),
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                  ),
                  const NavigationDestination(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                    child: const NavigationDestination(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ),
                ],
              ),
              body: <Widget>[
                const Home(),
                const AddProduct(),
                const Profile(),
              ][currentPageIndex]));
          break;
        default:
          builder = (context) => const Home();
          break;
      }
      return MaterialPageRoute(builder: builder, settings: settings);
    });
  }
}
