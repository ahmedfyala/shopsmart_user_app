import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/viewed_prod_provider.dart';
import '../../screens/inner_screen/product_details.dart';
import '../subtitle_text.dart';
import 'heart_btn.dart';

class LatestArrivalProductWidget extends StatelessWidget {
  LatestArrivalProductWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrProduct = productProvider.findByProdId(productModel.productId);
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    final productsModel = Provider.of<ProductModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addProductToHistory(
              productId: productsModel.productId);
          await Navigator.pushNamed(
            context,
            ProductDetails.routName,
            arguments: productsModel.productId,
          );
          //await Navigator.pushNamed(context, ProductDetails.routName);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                           HeartButtonWidget(
                            productId: productModel.productId ,
                          ),
                          IconButton(
                            onPressed: ()  {
                              if (cartProvider.isProductInCart(
                                  productId: getCurrProduct.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                  productId: getCurrProduct.productId);
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(productId:
                              getCurrProduct!.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const FittedBox(
                      child: SubtitleTextWidget(
                        label: "166.5\$",
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //   Row(
    //   children: [
    //     Flexible(
    //       child: ClipRRect(
    //           borderRadius: BorderRadius.circular(30),
    //           child: FancyShimmerImage(
    //             imageUrl: AppConstants.ProductImageUrl,
    //             width: size.height * 0.28,
    //             height: size.height * 0.28,
    //           )),
    //     ),
    //     Flexible(
    //         child: TitlesTextWidget(
    //       lablel: "Latest arrival",
    //       maxLines: 2,
    //       fontSize: 18,
    //     ),),
    //     Flexible(
    //       child: IconButton(
    //         onPressed: () {},
    //         icon: const Icon(IconlyLight.heart),
    //       ),
    //     ),
    //   ],
    // );
  }
}
