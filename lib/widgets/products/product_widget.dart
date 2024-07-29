// import 'dart:math';
//
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:provider/provider.dart';
// import 'package:shopsmart_user/constants/app_constants.dart';
// import 'package:shopsmart_user/model/product_model.dart';
// import 'package:shopsmart_user/screens/inner_screen/product_details.dart';
// import '../../providers/product_provider.dart';
// import '../subtitle_text.dart';
// import '../title_text.dart';
// import 'heart_btn.dart';
//
// class ProductWidget extends StatefulWidget {
//   ProductWidget({
//     super.key,
//     required this.productId,
//   });
//
//   final String productId;
//
//   @override
//   State<ProductWidget> createState() => _ProductWidgetState();
// }
//
// class _ProductWidgetState extends State<ProductWidget> {
//   @override
//   Widget build(BuildContext context) {
//     //var productModelProvider = Provider.of<ProductModel>(context);
//     final productProvider = Provider.of<ProductProvider>(context);
//     final getCurrentProduct = productProvider.findByProductId(widget.productId);
//     Size size = MediaQuery.of(context).size;
//     return getCurrentProduct == null
//         ? SizedBox.shrink()
//         : Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: GestureDetector(
//               onTap: () async {
//                 await Navigator.pushNamed(context, ProductDetails.routName,
//                     arguments: getCurrentProduct.productId);
//               },
//               child: Column(
//                 children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.circular(30),
//                       child: FancyShimmerImage(
//                         imageUrl: getCurrentProduct.productImage,
//                         width: double.infinity,
//                         height: size.height * 0.22,
//                       )),
//                   Row(
//                     children: [
//                       Flexible(
//                         flex: 4,
//                         child: TitlesTextWidget(
//                             label: getCurrentProduct.productTitle, maxLines: 2),
//                       ),
//                       Flexible(
//                         child: const HeartButtonWidget(),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         flex: 3,
//                         child: SubTitleTextWidget(
//                           label: "${getCurrentProduct.productPrice} \$",
//                         ),
//                       ),
//                       Flexible(
//                         child: Material(
//                           borderRadius: BorderRadius.circular(12.0),
//                           color: Colors.lightBlue,
//                           child: InkWell(
//                             splashColor: Colors.red,
//                             borderRadius: BorderRadius.circular(12.0),
//                             onTap: () {},
//                             child: const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Icon(
//                                 Icons.add_shopping_cart_rounded,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../screens/inner_screen/product_details.dart';
import '../subtitle_text.dart';
import '../title_text.dart';
import 'heart_btn.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });

  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {

    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(
            context,
            ProductDetails.routName,
            arguments: getCurrProduct.productId,
          );
        },
        child: Column(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FancyShimmerImage(
                imageUrl: getCurrProduct.productImage,
                width: double.infinity,
                height: size.height * 0.22,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TitlesTextWidget(
                    label: getCurrProduct.productTitle,
                    maxLines: 2,
                    fontSize: 18,
                  ),
                ),
                 Flexible(
                  flex: 2,
                  child: HeartButtonWidget(
                    productId: getCurrProduct.productId,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: SubtitleTextWidget(
                      label: "${getCurrProduct.productPrice}\$",
                    ),
                  ),
                  Flexible(
                    child: Material(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.lightBlue,
                      child: InkWell(
                        splashColor: Colors.red,
                        borderRadius: BorderRadius.circular(16.0),
                        onTap: () {
                          if (cartProvider.isProductInCart(
                              productId: getCurrProduct.productId)) {
                            return;
                          }
                          cartProvider.addProductToCart(
                              productId: getCurrProduct.productId);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            cartProvider.isProductInCart(productId:
                            getCurrProduct.productId)?Icons.check
                                : Icons.add_shopping_cart_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 1,
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

}
