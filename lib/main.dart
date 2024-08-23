import 'package:e_commerce/screen/UserLogoutScreen.dart';
import 'package:e_commerce/screen/UserScreen.dart';
import 'package:e_commerce/screen/basketList.dart';
import 'package:e_commerce/screen/productAdd.dart';
import 'package:e_commerce/screen/productList.dart';
import 'package:flutter/material.dart';

import 'model/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  List<Product> basket = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("E Commerce"),
      ),
      body: currentPage == 0
          ? ProductList(basket: basket)
          : (currentPage == 1 ? BasketList(basket: basket) : UserScreenLogout()),

      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.shopping_basket), label: "Basket"),
          NavigationDestination(icon: Icon(Icons.manage_accounts), label: "Account"),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,

      ),
    );
  }
}
