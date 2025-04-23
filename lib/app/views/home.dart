// import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/ads.dart';
import 'package:flutter_application_1/app/data/filters.dart';
import 'package:flutter_application_1/app/store/providers/product_provider.dart';
import 'package:flutter_application_1/app/widgets/DataApp/bottomSheet.dart';
import 'package:flutter_application_1/app/widgets/DataApp/card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  var items = [];
  var images = adsList;
  final filters = filterList;
  double _currentSliderValue = 20.0;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  // Future<void> getData() async {
  //   try {
  //     var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       var decodedJson = json.decode(response.body);
  //       if (mounted) {
  //         setState(() {
  //           items.addAll(decodedJson);
  //         });
  //       }
  //     } else {
  //       print('Failed with statius: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);

    return (Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jobs',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                    Row(
                      spacing: 4.0,
                      children: [
                        const Icon(
                          Icons.content_copy,
                          color: Color.fromRGBO(0, 128, 128, 1),
                          size: 18.0,
                        ),
                        InkWell(
                          onTap: () => FirebaseAuth.instance.signOut(),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: Color.fromRGBO(0, 128, 128, 1)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: const Divider(color: Color.fromRGBO(233, 237, 238, 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return CustomBottomSheet(
                                    currentSliderValue: _currentSliderValue,
                                    seekbarHandler: (value) {
                                      setState(() {
                                        _currentSliderValue = value;
                                      });
                                    },
                                    filters: filters,
                                  );
                                });
                              });
                        },
                        child: const Icon(
                          Icons.tune,
                          color: Color.fromRGBO(0, 128, 128, 1),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // like numColumns = 2
                    ),
                    itemBuilder: (context, index) {
                      return AdCard(
                        index: index,
                        title: products[index].title,
                        description: products[index].location,
                        image: products[index].image,
                        placeHolderImage: images[index]['image'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
