//for provider
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qutation/classes/quote.dart';
//database
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../classes/quote.dart';

part 'quoteDB.g.dart';

@HiveType(typeId: 0)
class QuoteDB extends HiveObject {
  @HiveField(0)
 late int id;
  @HiveField(1)
 late String author;
  @HiveField(2)
 late String quoteContent;
}

// @HiveType(typeId: 1)
// class QuoteFav extends HiveObject {
//  @HiveField(0)
//  late int id;
//  @HiveField(1)
//  late String author;
//  @HiveField(2)
//  late String quoteContent;
// }

///SQLight
// class QuoteDB{
//
//   static final QuoteDB instance = QuoteDB._init();
// static Database? _quoteDB;
//
// QuoteDB._init();
//
//   Future<Database> get quoteDB async{
//     if(_quoteDB != null){return _quoteDB!;}
//     else{
//       _quoteDB = await _initDB('quote.db');
//       return _quoteDB!;
//     }
//    }
//
//   Future<Database> _initDB(String s) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, s);
//
//
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//
//
//   Future _createDB(Database db, int version) async {
//     await db.execute('CREATE TABLE quote(author TEXT, id INTEGER, contentQ Text)');
//
//     await db.execute('CREATE TABLE likedQuote(author TEXT, id INTEGER, contentQ Text)');
//   }
//
//   Future<void> insert(Quote quote)async{
//     final db =await instance.quoteDB;
//     await db.insert('quote', quote.toJson(),  conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<void> addToFavorite(Quote quote)async{
//     final db =await instance.quoteDB;
//     await db.insert('likedQuote', quote.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
//
//   }
//
//
//   Future<List<Quote>> readLoaded() async {
//
//     final db = await instance.quoteDB;
//
//
//     final List<Map<String, dynamic>> loadedQuote = await db.query('quote');
//
//
//     return List.generate(loadedQuote.length, (i) {
//       return Quote(
//         id: loadedQuote[i]['id'] as int,
//         author: loadedQuote[i]['autor'],
//         quoteContent: loadedQuote[i]['contentQ'],
//       );
//     });
//   }
//
//   Future<List<Quote>> readFavorite() async {
//     // Get a reference to the database.
//     final db = await instance.quoteDB;
//
//     // Query the table for all The Dogs.
//     final List<Map<String, dynamic>> loadedQuote = await db.query('likedQuote');
//
//     // Convert the List<Map<String, dynamic> into a List<Dog>.
//     return List.generate(loadedQuote.length, (i) {
//       return Quote(
//         id: loadedQuote[i]['id'],
//         author: loadedQuote[i]['autor'],
//         quoteContent: loadedQuote[i]['contentQ'],
//       );
//     });
//   }
//
//   Future<int> deleteFromFav(int id) async{
//     final db = await instance.quoteDB;
//     return await db.delete('likedQuote', where: 'id = ?', whereArgs: [id]);
//
//   }
//
//
//
//   Future close() async {
//     final db = await instance.quoteDB;
//     db.close();
//   }
// }