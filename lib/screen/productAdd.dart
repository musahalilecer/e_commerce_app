import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State<ProductAdd> {
  var dbHelper = DatabaseHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Page"),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(label: Text("Name"), focusColor: Colors.green),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(label: Text("Price"), focusColor: Colors.green),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(label: Text("Description"), focusColor: Colors.green),
            ),
            ElevatedButton(
              onPressed: () {
                insertProduct();
              },
              child: Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }

  void insertProduct() async {
    var product = Product(nameController.text, descriptionController.text, priceController.text);
    int result = await dbHelper.insertProduct(product);
    if (result != 0) {
      Navigator.pop(context, true); // Successfully added product
    } else {
      print("Error adding product");
    }
  }
}
