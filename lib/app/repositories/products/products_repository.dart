import 'package:delivery_app/app/model/product_model.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> findAllProducts();
}
