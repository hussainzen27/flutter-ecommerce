// State management

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../services//product_service.dart';

final productServiceProvider = Provider((ref) => ProductService());

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  final ProductService service;

  ProductNotifier(this.service) : super(service.getProducts());

  void add(String title, String price, String quantity, String category,
      String location, String path) async {
    await service.addProduct(ProductModel(
      title: title,
      price: price,
      quantity: quantity,
      category: category,
      location: location,
      image: path ?? '',
    ));
    state = service.getProducts();
  }

  //Filter
  void filter(String locFilter, String quantityFilter, String priceFilter) {
    state = service.filterProducts(locFilter, quantityFilter, priceFilter);
  }

  //Update

  //Delete
  void delete(int index) async {
    await service.deleteProduct(index);
    state = service.getProducts();
  }
}

final productListProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>((ref) {
  final service = ref.watch(productServiceProvider);
  return ProductNotifier(service);
});
