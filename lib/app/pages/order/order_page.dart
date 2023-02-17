import 'package:delivery_app/app/core/extenions/formatter_extension.dart';
import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app/app/dto/order_product_dto.dart';
import 'package:delivery_app/app/model/payment_type_model.dart';
import 'package:delivery_app/app/pages/order/order_controller.dart';
import 'package:delivery_app/app/pages/order/order_state.dart';
import 'package:delivery_app/app/pages/order/widget/order_field.dart';
import 'package:delivery_app/app/pages/order/widget/order_product_tile.dart';
import 'package:delivery_app/app/pages/order/widget/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/widgets/delivery_appbar.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final addressEC = TextEditingController();
  final documentEC = TextEditingController();
  final paymentTypeVelid = ValueNotifier<bool>(true);
  int? paymentId;

  @override
  void dispose() {
    addressEC.dispose();
    documentEC.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    // outra forma de pegar os dados entre telas
    controller.load(
      ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage ?? "erro não informado");
          },
        );
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProducts);
          return false; // force disable back button
        },
        child: Scaffold(
          appBar: DeliveryAppbar(),
          body: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text("Carrinho", style: context.textStyles.textTitle),
                        IconButton(
                            onPressed: () {},
                            icon:
                                Image.asset('assets/images/trashRegular.png')),
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                        List<OrderProductDto>>(
                    selector: (state) => state.orderProducts,
                    builder: (context, orderProducts) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                        childCount: orderProducts.length,
                        (context, index) {
                          final orderProduct = orderProducts[index];
                          return Column(
                            children: [
                              OrderProductTile(
                                index: index,
                                orderProduct: OrderProductDto(
                                  amount: orderProduct.amount,
                                  product: orderProduct.product,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                      ));
                    }),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total do pedido",
                              style: context.textStyles.textBold
                                  .copyWith(fontSize: 16),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (context, totalOrder) {
                                return Text(
                                  totalOrder.currencyTPBR,
                                  style: context.textStyles.textBold
                                      .copyWith(fontSize: 20),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OrderField(
                        title: "Endereço de entrega",
                        controller: addressEC,
                        validator:
                            Validatorless.required("endereço obrigatório"),
                        hintText: "Digite um endereço",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OrderField(
                        title: "CPF",
                        controller: documentEC,
                        validator: Validatorless.required("CPF obrigatório"),
                        hintText: "Digite o CPF",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypeModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (context, paymentTypes) {
                          return ValueListenableBuilder(
                            valueListenable: paymentTypeVelid,
                            builder: (context, paymentTypeValidValue, child) {
                              return PaymentTypesField(
                                paymentTypes: paymentTypes,
                                valid: paymentTypeValidValue,
                                valueSelected: paymentId.toString(),
                                valueChanged: (value) {
                                  paymentId = value;
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: DeliveryButton(
                          width: double.infinity,
                          height: 48,
                          label: "Finalizar",
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;
                            final paymentTYpeSelected = paymentId != null;
                            paymentTypeVelid.value = paymentTYpeSelected;

                            if (valid) {}
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
