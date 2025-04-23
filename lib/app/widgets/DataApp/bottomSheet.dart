import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/store/providers/product_provider.dart';
import 'package:flutter_application_1/app/widgets/Calculator/customInput.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> locationList = [
  'Karachi',
  'Lahore',
  'Islamabad',
  'Peshawar'
];

class CustomBottomSheet extends ConsumerStatefulWidget {
  const CustomBottomSheet(
      {super.key,
      required this.currentSliderValue,
      required this.filters,
      required this.seekbarHandler});

  final double currentSliderValue;
  final Function seekbarHandler;
  final List<Map<String, dynamic>> filters;

  @override
  ConsumerState<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _CustomBottomSheetState extends ConsumerState<CustomBottomSheet> {
  static final List<MenuEntry> locationMenuEntries =
      UnmodifiableListView<MenuEntry>(
    locationList
        .map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );

  final int distance = 0;
  final String price = "0";
  final String quantity = "0";
  String location = locationList.first;

  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    priceController.text = price.toString();
    quantityController.text = quantity.toString();
    locationController.text = location.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Filter Options',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Quantity', style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Input(
                        controller: quantityController,
                        hint: 'Enter Quantity',
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price', style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Input(
                        controller: priceController,
                        hint: 'Enter Price',
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Location', style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownMenu<String>(
                          controller: locationController,
                          inputDecorationTheme: InputDecorationTheme(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFFD8DCDD))),
                          ),
                          initialSelection: locationList.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            if (mounted) {
                              setState(() {
                                location = value!;
                              });
                            }
                          },
                          width: double.maxFinite,
                          menuStyle: const MenuStyle(
                            side: WidgetStatePropertyAll(
                                BorderSide(color: Colors.white)),
                            fixedSize: WidgetStatePropertyAll(
                              Size(1000, 200), // Set your desired height here
                            ),
                          ),
                          dropdownMenuEntries: locationMenuEntries,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(productListProvider.notifier)
                                    .filter('', '', '');
                              },
                              child: const Text('Reset')),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(productListProvider.notifier)
                                    .filter(location, quantity, price);
                              },
                              child: const Text('Apply')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
