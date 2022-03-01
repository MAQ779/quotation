import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';

//for buttons and icons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//for provider
import 'package:path_provider/path_provider.dart';

//database
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:convert';
import '../SavingQuotes/quoteDB.dart';
import '../classes/quote.dart';

import 'package:provider/provider.dart';
import 'package:qutation/classes/Provider_loaded.dart';


import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../SavingQuotes/quoteDB.dart';
//import '../classes/quoteFav.dart';
import '../SavingQuotes/boxes.dart';


class NewQuotePage extends StatefulWidget {
  const NewQuotePage({Key? key}) : super(key: key);

  @override
  _NewQuotePageState createState() => _NewQuotePageState();
}

class _NewQuotePageState extends State<NewQuotePage> {
  //@override
  // void dispose(){
  //   Hive.close();
  //   super.dispose();
  // }
  final box = Boxes.getAllLoadedQuotes();
  final boxFav = Boxes.getAllFavoriteQuotes();

  ///--->holders
  late String newAuthor;
  late String newContentQuote;
  late int newId;

  late Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = RandomQuote().fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('QPM'),
        ),
        body: ValueListenableBuilder<Box<QuoteDB>>(
          valueListenable: Boxes.getAllLoadedQuotes().listenable(),
          builder: (context, box, _){

             // await Hive.openBox<QuoteDB>('quote');
              final quotes = box.values.toList().cast<QuoteDB>();

            return newQUI(quotes);

          },
        )
      );

  }

  Widget newQUI(List<QuoteDB> quotes){
    return Center(
      child: FutureBuilder<Quote>(
        future: futureQuote,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

                newAuthor= snapshot.data!.author;
                newId = snapshot.data!.id;
                newContentQuote = snapshot.data!.quoteContent;

            addNewQuote(newAuthor, newId, newContentQuote, quotes);



            return Column(
              children: [
                // main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: GFBorder(
                        dashedLine: [4, 6],
                        strokeWidth: 4,
                        type: GFBorderType.rRect,
                        color: Color(0xFF8608DC),
                        child: Text(
                          'ID: ' +
                              newId.toString() +
                              '\n\n"' +
                              newContentQuote +
                              '" By ' +
                              newAuthor,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                      children: [
                        //left arrow
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.arrowAltCircleLeft,
                              color: Colors.pink,
                              size: 70.0,
                              semanticLabel:
                              'Text to announce in accessibility modes',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // like button
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.pink,
                              size: 70.0,
                              semanticLabel:
                              'Text to announce in accessibility modes',
                            ),
                            onPressed: (){
                              addToFavorite(snapshot.data!.author,
                                  snapshot.data!.id,
                                  snapshot.data!.quoteContent);

                              showMyDialog();
                            },


                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        //right arrow
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                futureQuote = RandomQuote().fetchQuote();
                                newAuthor= snapshot.data!.author;
                                newId = snapshot.data!.id;
                                newContentQuote = snapshot.data!.quoteContent;

                                //Navigator.pushNamed(context, "/newQ");
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.arrowAltCircleRight,
                              color: Colors.pink,
                              size: 70.0,
                              semanticLabel:
                              'Text to announce in accessibility modes',
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const GFLoader(type: GFLoaderType.ios);
        },
      ),
    );
  }

  ///add hive method
Future addNewQuote(String nAuthor, int nId, String nQuoteContent, List<QuoteDB> allQ) async{
   int check =0;

  ///check if the quote is already loaded or not
   if(allQ.length >0){
   for(int i =0; i <= allQ.length-1 ; i++){
     if(nId == allQ[i].id){
       check=-1;
     }
   }}
  if(check == 0){
    final newQuote = QuoteDB()
    ..id = nId
    ..author = nAuthor
    ..quoteContent = nQuoteContent;
    //await Hive.openBox<QuoteDB>('quote');
  final box = Boxes.getAllLoadedQuotes();

  box.add(newQuote);

  }
}

  Future addToFavorite(String nAuthor, int nId, String nQuoteContent) async{
    int check =0;
    final favQ = boxFav.values.toList().cast<QuoteDB>();
    ///check if the quote is already loaded or not
    if(favQ.length >0){
      for(int i =0; i <= favQ.length-1 ; i++){
        if(nId == favQ[i].id){
          check=-1;
        }
      }}
    if(check == 0){
      final newQuote = QuoteDB()
        ..id = nId
        ..author = nAuthor
        ..quoteContent = nQuoteContent;
      //await Hive.openBox<QuoteDB>('quote');
      final box = Boxes.getAllFavoriteQuotes();

      box.add(newQuote);

    }
  }

  ///alert that quote was added to the favorite
Future<void> showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: const Text('FAVORITE'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('The quote was added to favorite.', style: TextStyle(color: Colors.white),),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(

            child: const Text('OK', style: TextStyle(color: Colors.white,),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}
