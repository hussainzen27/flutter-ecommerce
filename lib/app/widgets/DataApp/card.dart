import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/store/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdCard extends ConsumerWidget {
  const AdCard(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.index,
      required this.placeHolderImage});

  final String title;
  final String description;
  final String image;
  final String placeHolderImage;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  // child: image != ''
                  //     ?
                  //     Image.file(File(image),
                  //         width: double.maxFinite,
                  //         height: 100,
                  //         fit: BoxFit.cover)
                  //     :
                  child: Image.network(placeHolderImage,
                      width: double.maxFinite, height: 100, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 2,
                  right: 5,
                  child: Container(
                    // padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: IconButton(
                        onPressed: () {
                          ref.read(productListProvider.notifier).delete(index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 24.0,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        color: Color.fromRGBO(81, 89, 90, 1),
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
