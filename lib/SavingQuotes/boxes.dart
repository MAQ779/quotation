import 'package:hive/hive.dart';
import 'quoteDB.dart';


class Boxes{
  static Box<QuoteDB> getAllLoadedQuotes()=>
    Hive.box<QuoteDB>('quote');

  static Box<QuoteDB> getAllFavoriteQuotes()=>
      Hive.box<QuoteDB>('quoteFav');

}