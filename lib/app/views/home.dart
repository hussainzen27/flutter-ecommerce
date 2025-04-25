import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/ads.dart';
import 'package:flutter_application_1/app/data/filters.dart';
import 'package:flutter_application_1/app/store/providers/product_provider.dart';
import 'package:flutter_application_1/app/widgets/DataApp/bottomSheet.dart';
import 'package:flutter_application_1/app/widgets/DataApp/card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        appBar: AppBar(
          shape: const Border(
              bottom: BorderSide(color: Color.fromRGBO(233, 237, 238, 1))),
          title: const Text(
            'Jobs',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10.0),
            child: Container(
              color: const Color.fromRGBO(233, 237, 238, 1),
              height: 1.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
              icon: const Icon(Icons.message_sharp),
            ),
          ],
          centerTitle: false,
        ),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
            child: Column(
              children: [
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
