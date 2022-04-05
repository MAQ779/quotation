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
