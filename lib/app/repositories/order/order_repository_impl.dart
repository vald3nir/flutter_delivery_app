import 'dart:developer';

import 'package:delivery_app/app/core/config/rest_client/custom_dio.dart';
import 'package:delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:delivery_app/app/model/payment_type_model.dart';
import 'package:dio/dio.dart';

import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await dio.auth().get("/payment-types");
      return result.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log("erro ao buscar formas de pagamento", error: e, stackTrace: s);
      throw RepositoryException(message: "erro ao buscar formas de pagamento");
    }
  }
}
