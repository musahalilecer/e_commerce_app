import 'package:sqflite/sqflite.dart';

class Product{
  int? id;
  late String name;
  late String description;
  late String price;

  Product(this.name,this.description,this.price);
  Product.withId(this.id,this.name,this.description,this.price);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Extract a Product object from a Map object
  Product.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    price = map['price'];
  }
}

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String productTable = 'product_table';
  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colPrice = 'price';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'products.db';

    // Open/create the database at a given path
    var productsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return productsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
            '$colDescription TEXT, $colPrice TEXT)');
  }

  // Fetch Operation: Get all product objects from database
  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await this.database;

    var result = await db.query(productTable, orderBy: '$colId ASC');
    return result;
  }

  // Insert Operation: Insert a Product object to database
  Future<int> insertProduct(Product product) async {
    Database db = await this.database;
    var result = await db.insert(productTable, product.toMap());
    return result;
  }

  // Update Operation: Update a Product object and save it to database
  Future<int> updateProduct(Product product) async {
    var db = await this.database;
    var result = await db.update(productTable, product.toMap(), where: '$colId = ?', whereArgs: [product.id]);
    return result;
  }

  // Delete Operation: Delete a Product object from database
  Future<int> deleteProduct(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $productTable WHERE $colId = $id');
    return result;
  }

  // Get number of Product objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $productTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Product List' [ List<Product> ]
  Future<List<Product>> getProductList() async {
    var productMapList = await getProductMapList(); // Get 'Map List' from database
    int count = productMapList.length; // Count the number of map entries in db table

    List<Product> productList = <Product>[];
    // For loop to create a 'Product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMapObject(productMapList[i]));
    }

    return productList;
  }
}

