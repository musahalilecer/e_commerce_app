import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../model/user.dart';

class User{
  int? id;
  late String name;
  late String mail;
//  late String img;
//  late String password;

  User(this.name,this.mail);
  User.withId(this.id,this.name,this.mail);

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["mail"] = mail;
    if(id != null){
      map["id"] = id;
    }
    return map;
  }

  User.fromObject(dynamic o){
    this.id = o["Id"];
    this.name = o["Name"];
    this.mail = o["Mail"];
  }
}

class UserDatabase {
  static UserDatabase? _userDatabase; // Singleton UserDatabase
  static Database? _database; // Singleton Database

  String userTable = 'user_table';
  String colId = 'id';
  String colName = 'name';
  String colMail = 'mail';

  UserDatabase._createInstance(); // Named constructor to create instance of UserDatabase

  factory UserDatabase() {
    if (_userDatabase == null) {
      _userDatabase = UserDatabase._createInstance(); // This is executed only once, singleton object
    }
    return _userDatabase!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    String path = join(await getDatabasesPath(), 'users.db');

    // Open/create the database at a given path
    var userDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colMail TEXT)');
  }

  // Fetch Operation: Get all user objects from database
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;

    var result = await db.query(userTable, orderBy: '$colId ASC');
    return result;
  }

  // Insert Operation: Insert a User object to database
  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  // Update Operation: Update a User object and save it to database
  Future<int> updateUser(User user) async {
    var db = await this.database;
    var result = await db.update(userTable, user.toMap(), where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete Operation: Delete a User object from database
  Future<int> deleteUser(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
    return result;
  }

  // Get number of User objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $userTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'User List' [ List<User> ]
  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length; // Count the number of map entries in db table

    List<User> userList = <User>[];
    // For loop to create a 'User List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromObject(userMapList[i]));
    }

    return userList;
  }
}
