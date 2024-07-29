import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/widgets/subtitle_text.dart';

import '../../model/cart_model.dart';
import '../../providers/cart_provider.dart';

class QuantityBottomSheet extends StatelessWidget {
   QuantityBottomSheet({super.key,required this.cartModel});
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 6,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Center(
                      child: InkWell(
                        onTap: () {
                          cartProvider.updateQuantity(
                            productId: cartModel.productId,
                            quantity: index + 1,
                          );
                          Navigator.pop(context);
                        },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SubtitleTextWidget(label: "${index + 1}"),
                    ),
                  ));
                },
                itemCount: 30),
          ],
        ),
      ),
    );
  }
}
