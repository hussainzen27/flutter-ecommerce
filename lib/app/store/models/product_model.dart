import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String price;
  @HiveField(2)
  String quantity;
  @HiveField(3)
  String category;
  @HiveField(4)
  String location;
  @HiveField(5)
  String image;

  ProductModel({
    required this.title,
    required this.price,
    required this.quantity,
    required this.category,
    required this.location,
    this.image = '',
  });
}
