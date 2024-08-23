import 'package:e_commerce/screen/productAdd.dart';
import 'package:flutter/material.dart';
import '../model/product.dart';
import 'basketList.dart';

class ProductList extends StatefulWidget {
  final List<Product> basket;

  ProductList({required this.basket});

  @override
  State<StatefulWidget> createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Product> products = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: listProduct(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        tooltip: "Add new product",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView listProduct() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text("Product name: ${products[index].name}"),
                subtitle: Text("Product Description: ${products[index].description}"),
              ),
              Row(
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: Text("Add to Basket"),
                        onPressed: () {
                          addItemToBasket(products[index]);
                        },
                      ),
                      ElevatedButton(
                        child: Text("Delete"),
                        onPressed: () {
                          deleteItem(products[index]);
                        },
                      ),
                      ElevatedButton(
                          onPressed: (){

                          }, child: Text("Update"))
                    ],
                  ),
                ],
              )

            ],
          ),
        );
      },
    );
  }

  void addItemToBasket(Product product) {
    setState(() {
      widget.basket.add(product); // Add the product to the basket list
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BasketList(basket: widget.basket)),
    );
  }

  void getData() async {
    var dbFuture = dbHelper.initializeDatabase();
    dbFuture.then((result) {
      var productsFuture = dbHelper.getProductList();
      productsFuture.then((data) {
        setState(() {
          products = data;
          count = data.length;
        });
      });
    });
  }

  void goToProductAdd() async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductAdd()),
    );
    if (result != null && result) {
      getData();
    }
  }

  void deleteItem(Product product) async {
    int result = await dbHelper.deleteProduct(product.id!);
    if (result != 0) { // Success
      setState(() {
        products.remove(product);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product Deleted Successfully')),
      );
    } else { // Failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Occurred while Deleting Product')),
      );
    }
  }
}
