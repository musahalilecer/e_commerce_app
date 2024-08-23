import 'package:flutter/material.dart';
import '../model/product.dart';
 // DatabaseHelper sınıfını import etmeyi unutmayın

class BasketList extends StatefulWidget {
  final List<Product> basket;

  BasketList({required this.basket});

  @override
  _BasketListState createState() => _BasketListState();
}

class _BasketListState extends State<BasketList> {
  var dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basket"),
      ),
      body: ListView.builder(
        itemCount: widget.basket.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.basket[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.basket[index].description),
                  Text(widget.basket[index].price),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  deleteProduct(widget.basket[index].id!);
                },
                child: Text("Delete item"),
              ),
            ),
          );
        },
      ),
    );
  }

  void deleteProduct(int id) async {
    await dbHelper.deleteProduct(id);
    setState(() {
      widget.basket.removeWhere((product) => product.id == id); // Listeyi güncelle
    });
  }
}
