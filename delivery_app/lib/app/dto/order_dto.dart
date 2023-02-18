import 'package:delivery_app/app/dto/order_product_dto.dart';

class OrderDto {
  List<OrderProductDto> products;
  String document;
  String address;
  int paymentMethodeID;

  OrderDto({
    required this.products,
    required this.document,
    required this.address,
    required this.paymentMethodeID,
  });
}
