import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/screens/home_screen.dart';
import 'package:shopsmart_user/screens/cart/cart_screen.dart';
import 'package:shopsmart_user/screens/profile_screen.dart';
import 'package:shopsmart_user/screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const routName = 'root_screen';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchFCT() async {
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    try {
      //Future.wait(productsProvider.fetchProducts(),);
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: screens,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 2,
        height: kBottomNavigationBarHeight,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.home,
              ),
              icon: Icon(IconlyLight.home),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.search,
              ),
              icon: Icon(IconlyLight.search),
              label: "search"),
          NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.bag2,
            ),
            icon: Badge(
                backgroundColor: Colors.blue,
                label: Text(cartProvider.getCartItems.length.toString()),
                child: const Icon(IconlyLight.bag2)),
            label: "Cart",
          ),
          NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.profile,
              ),
              icon: Icon(IconlyLight.profile),
              label: "Profile"),
        ],
      ),
    );
  }
}
