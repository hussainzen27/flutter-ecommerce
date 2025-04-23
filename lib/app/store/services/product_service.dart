// Functions

import 'package:flutter_application_1/app/store/hive_boxes.dart';
import 'package:flutter_application_1/app/store/models/product_model.dart';
import 'package:hive/hive.dart';

class ProductService {
  List<ProductModel> getProducts() {
    return HiveBoxes.getProductModel().values.toList();
  }

  //Filter products
  List<ProductModel> filterProducts(
      String locFilter, String quantityFilter, String priceFilter) {
    if (locFilter == "" && quantityFilter == "" && priceFilter == "") {
      return getProducts();
    }
    return getProducts()
        .where((product) =>
            product.location == locFilter ||
            product.quantity == quantityFilter ||
            product.price == priceFilter)
        .toList();
  }

  Future<void> addProduct(ProductModel product) async {
    final box = await Hive.openBox<ProductModel>(HiveBoxes.productBox);
    await box.add(product);
  }

  // update

  // delete
  Future<void> deleteProduct(int index) async {
    final box = await Hive.openBox<ProductModel>(HiveBoxes.productBox);
    await box.deleteAt(index);
  }
}
