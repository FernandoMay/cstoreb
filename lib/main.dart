import 'package:cstore/cart.dart';
import 'package:cstore/productlist.dart';
import 'package:cstore/search.dart';
import 'package:cstore/statemodel.dart';
import 'package:cstore/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (_) => AppStateModel()..loadProducts(),
      child: const CupertinoStoreApp(),
    ),
  );
}

CupertinoThemeData ctheme() {
  return const CupertinoThemeData(
    barBackgroundColor: Color(0xFFFCE9F1),
    scaffoldBackgroundColor: Color(0xFFFCE9F1),
    primaryColor: Color(0xFF73BBC9),
    primaryContrastingColor: Color(0xFFF1D4E5),
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      primaryColor: Styles.goldColor,
      navTitleTextStyle: TextStyle(
        color: Styles.goldColor, // This is where you use the gold color
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textStyle: TextStyle(
        color: Styles.goldColor, // You can define a default text color as well
        fontSize: 16,
      ),
    ),
  );
}

class CupertinoStoreApp extends StatelessWidget {
  const CupertinoStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: ctheme(),
      home: const CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  const CupertinoStoreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return switch (index) {
          0 => CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: ProductListTab(),
              ),
            ),
          1 => CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: SearchTab(),
              ),
            ),
          2 => CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: ShoppingCartTab(),
              ),
            ),
          _ => throw Exception('Invalid index $index'),
        };
      },
    );
  }
}
