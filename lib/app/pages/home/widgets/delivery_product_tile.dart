import 'package:delivery_app/app/core/extenions/formatter_extension.dart';
import 'package:delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/model/product_model.dart';
import 'package:flutter/material.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;

  const DeliveryProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(
          "/productDetail",
          arguments: {
            "product": product,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.name,
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.description,
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.price.currencyTPBR,
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 12,
                        color: context.colors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: product.image,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            )
          ],
        ),
      ),
    );
  }
}
