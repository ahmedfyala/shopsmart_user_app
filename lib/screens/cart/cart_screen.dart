import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/assets_manager.dart';
import '../../services/my_app_methods.dart';
import '../../widgets/empty_bag.dart';
import '../../widgets/title_text.dart';
import '../loading_manager.dart';
import 'bottom_check_out.dart';
import 'cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
      body: EmptyBagWidget(
        imagePath: AssetsManager.shoppingBasket,
        title: "Your cart is empty",
        subTitle:
        'Looks like you didn\'t add anything yet to your cart go ahead and start shopping now',
        bottomText: "Shop Now",
      ),
    )
        : Scaffold(
      bottomSheet: CartBottomCheckout(function: () async {
        await placeOrder(
          cartProvider: cartProvider,
          productProvider: productProvider,
          userProvider: userProvider,
        );
      }),
      appBar: AppBar(
        title: TitlesTextWidget(
            label: "Cart (${cartProvider.getCartItems.length})"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyAppMethods.showErrorORWarningDialog(
                  isError: false,
                  context: context,
                  subtitle: "Remove items",
                  fct: () async {
                    // cartProvider.clearLocalCart();
                    await cartProvider.clearCartFromFirebase();
                  });
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: LoadingManager(
        isLoading: isLoading,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.getCartItems.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: cartProvider.getCartItems.values
                        .toList()
                        .reversed
                        .toList()[index],
                    child: const CartWidget(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: kBottomNavigationBarHeight + 10,
            )
          ],
        ),
      ),
    );
  }

  Future<void> placeOrder({
    required CartProvider cartProvider,
    required ProductProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        isLoading = true;
      });
      cartProvider.getCartItems.forEach((key, value) async {
        final getCurrProduct = productProvider.findByProdId(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("ordersAdvanced")
            .doc(orderId)
            .set({
          'orderId': orderId,
          'userId': uid,
          'productId': value.productId,
          "productTitle": getCurrProduct!.productTitle,
          'price': double.parse(getCurrProduct.productPrice) * value.quantity,
          'totalPrice': cartProvider.getTotal(productProvider: productProvider),
          'quantity': value.quantity,
          'imageUrl': getCurrProduct.productImage,
          'userName': userProvider.getUserModel!.userName,
          'orderDate': Timestamp.now(),
        });
      });
      await cartProvider.clearCartFromFirebase();
      cartProvider.clearLocalCart();
    } catch (e) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: e.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
