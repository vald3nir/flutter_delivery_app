// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/app/model/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;

  OrderProductDto({
    required this.product,
    required this.amount,
  });

  double get totalPrice => amount * product.price;
}
