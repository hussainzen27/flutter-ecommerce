import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_application_1/app/routes/app_stack.dart';
import 'package:flutter_application_1/app/store/providers/product_provider.dart';
import 'package:flutter_application_1/app/widgets/Calculator/customInput.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final List<String> categoryList = ['Clothes', 'Watches', 'Computer', 'Mobiles'];
final List<String> locationList = [
  'Karachi',
  'Lahore',
  'Islamabad',
  'Peshawar'
];

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _AddProductState extends ConsumerState<AddProduct> {
  File? _mediaFileList;
  dynamic _pickImageError;

  static final List<MenuEntry> categoryMenuEntries =
      UnmodifiableListView<MenuEntry>(
    categoryList
        .map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  static final List<MenuEntry> locationMenuEntries =
      UnmodifiableListView<MenuEntry>(
    locationList
        .map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );

  String title = '';
  String price = '';
  String quantity = '';
  String location = '';
  String category = '';
  String dropdownValue = categoryList.first;

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final locationController = TextEditingController();
  final categoryController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = title.toString();
    priceController.text = price.toString();
    quantityController.text = quantity.toString();
    locationController.text = location.toString();
    categoryController.text = category.toString();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (!mounted) return; // Widget is gone

      if (pickedFile != null) {
        setState(() {
          _mediaFileList = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return; // Widget is gone
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void addProduct() {
    // TODO: Implement addProduct function
    try {
      if (titleController.text == '' ||
          priceController.text == '' ||
          quantityController.text == '' ||
          locationController.text == '' ||
          categoryController.text == '') {
        showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Error'),
                content: const Text('Please fill all the fields'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
        return;
      }
      ref.read(productListProvider.notifier).add(
            titleController.text,
            priceController.text,
            quantityController.text,
            categoryController.text,
            locationController.text,
            _mediaFileList?.path == null ? '' : _mediaFileList!.path,
          );
      print('Successfully added');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const AppStack(
                    initialIndex: 0,
                  )));
    } catch (e) {
      print('eeeeee $e');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: (SingleChildScrollView(
              child: Column(
                spacing: 20.0,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add Product",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            addProduct();
                          },
                          child: const Text("Add")),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 170.0,
                          height: 170.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.grey[200],
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 30.0,
                            color: Colors.black,
                          ),
                        ),
                        _mediaFileList != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.file(
                                  _mediaFileList!,
                                  fit: BoxFit.cover,
                                  height: 170.0,
                                  width: 170.0,
                                ),
                              )
                            : const SizedBox(
                                width: 170.0,
                                height: 170.0,
                              ),
                        Positioned(
                          bottom: 2.0,
                          right: 15.0,
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.grey[200],
                              border:
                                  Border.all(color: Colors.white, width: 6.0),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  _pickImage();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 17.0,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _pickImageError != null
                      ? Text(_pickImageError.toString())
                      : const SizedBox(),
                  Input(
                      controller: titleController,
                      hint: "Enter Title",
                      keyboardType: TextInputType.text),
                  Input(
                      controller: priceController,
                      hint: "Enter Price",
                      keyboardType: TextInputType.number),
                  Input(
                      controller: quantityController,
                      hint: "Enter Quantity",
                      keyboardType: TextInputType.number),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownMenu<String>(
                        controller: categoryController,
                        inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Color(0xFFD8DCDD))),
                        ),
                        initialSelection: categoryList.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          if (mounted) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          }
                        },
                        menuStyle: const MenuStyle(
                          side: WidgetStatePropertyAll(
                              BorderSide(color: Colors.white)),
                          fixedSize: WidgetStatePropertyAll(
                            Size(double.infinity,
                                200), // Set your desired height here
                          ),
                        ),
                        dropdownMenuEntries: categoryMenuEntries,
                      ),
                      DropdownMenu<String>(
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
                              dropdownValue = value!;
                            });
                          }
                        },
                        menuStyle: const MenuStyle(
                          fixedSize: WidgetStatePropertyAll(
                            Size(double.infinity,
                                200), // Set your desired height here
                          ),
                        ),
                        dropdownMenuEntries: locationMenuEntries,
                      ),
                    ],
                  ),
                ],
              ),
            )),
          )),
        )));
  }
}
