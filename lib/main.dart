import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/constants/theme_data.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/order_provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/providers/user_provider.dart';
import 'package:shopsmart_user/providers/viewed_prod_provider.dart';
import 'package:shopsmart_user/providers/wishlist_provider.dart';
import 'package:shopsmart_user/screens/auth/forgot_password.dart';
import 'package:shopsmart_user/screens/auth/login.dart';
import 'package:shopsmart_user/providers/theme_provider.dart';
import 'package:shopsmart_user/root_screen.dart';
import 'package:shopsmart_user/screens/inner_screen/others/orders_screen.dart';
import 'package:shopsmart_user/screens/inner_screen/product_details.dart';
import 'package:shopsmart_user/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_user/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_user/screens/auth/rigester.dart';
import 'package:shopsmart_user/screens/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
   );
  ProductProvider productProvider = ProductProvider();
  await productProvider.addProductsToFirestore();
  // FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: SelectableText(
                  "An error has been occurred ${snapshot.error}"),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) {
                return ThemeProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (context) {
                return ProductProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (context) {
                return CartProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (context) {
                return WishlistProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (context) {
                return ViewedProdProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (context) {
                return UserProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (context) {
                return OrdersProvider();
              },
            ),
          ],
          child:
              Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: Style.themeData(
                  isDarkTheme: themeProvider.getIsDarkTheme, context: context),
              home: RootScreen(),
              // initialRoute: RootScreen.routName,
              routes: {
                ProductDetails.routName: (context) => ProductDetails(),
                RootScreen.routName: (context) => RootScreen(),
                WishlistScreen.routName: (context) => WishlistScreen(),
                ViewedRecentlyScreen.routName: (context) =>
                    ViewedRecentlyScreen(),
                RegisterScreen.routName: (context) => RegisterScreen(),
                OrdersScreenFree.routeName: (context) => OrdersScreenFree(),
                LoginScreen.routName: (context) => LoginScreen(),
                ForgotPasswordScreen.routeName: (context) =>
                    ForgotPasswordScreen(),
                SearchScreen.routeName: (context) => SearchScreen(),
              },
            );
          }),
        );
      },
    );
  }
}
