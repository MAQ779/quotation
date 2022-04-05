import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:qutation/SavingQuotes/quoteDB.dart';
import 'package:qutation/classes/quote.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
//Hive
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../SavingQuotes/quoteDB.dart';

import '../SavingQuotes/boxes.dart';

class FavoriteQuotesPage extends StatelessWidget {
  const FavoriteQuotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: loadedBody(),
    );
  }
}

class loadedBody extends StatefulWidget {
  //const loadedBody({Key? key}) : super(key: key);

  @override
  _loadedBodyState createState() => _loadedBodyState();
}

class _loadedBodyState extends State<loadedBody> {
  // @override
  // void dispose(){
  //   Hive.close();
  //   super.dispose();
  // }
  int? selectedCard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FAVORITE'),
        ),
        body: ValueListenableBuilder<Box<QuoteDB>>(
          valueListenable: Boxes.getAllFavoriteQuotes().listenable(),
          builder: (context, box, _) {
            final quotes = box.values.toList().cast<QuoteDB>();
            return newQUI(quotes);
          },
        ));
    ;
  }

  Widget newQUI(List<QuoteDB> quotes) {
    if (quotes.isEmpty) {

      return Center(
        child: Text('no Favorite Quotes'),
      );
    } else {

      return SafeArea(
        child: ListView.builder(
            key: Key('builder ${selectedCard.toString()}'),
            shrinkWrap: true,
            itemCount: quotes.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              final quoteFav = quotes[index];
              return loadedQuoteCard(context, quoteFav, index);
            }),
      );
    }
  }

  Widget loadedQuoteCard(BuildContext context, QuoteDB quoteFav, int i) {
    return Card(

        color: Colors.purple,
        borderOnForeground: true,
        child: Theme(
          data: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0XFF100424),
              textTheme: TextTheme(headline1: TextStyle(color: Colors.white38)),
              appBarTheme: AppBarTheme(
                color: Color(0xB7695390),
              )),
          child: ExpansionTile(
            key: Key(i.toString()), //attention
            initiallyExpanded: i == selectedCard,
            textColor: Colors.white,
            collapsedTextColor: Colors.white ,
            backgroundColor: Colors.purple,
            tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            title:  Text(
              quoteFav.quoteContent,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              'by '+quoteFav.author,
              maxLines: 2,
              style: TextStyle( fontSize: 16),
            ),
            trailing: Text(
              quoteFav.id.toString(),
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            children: [
              deleteButton(context, quoteFav),
            ],
            onExpansionChanged: ((newState){
              if(newState) {
                setState(() {
                  selectedCard = i;
                });
              }
              else{
                setState(() {
                  selectedCard =-1;
                });
              }

            }),
          ),
        ));
  }

  Widget deleteButton(BuildContext context, QuoteDB quoteFav) => Row(
    children: [
      Expanded(
          child: TextButton.icon(
              onPressed: () {
                deleteQuote(quoteFav);
              },
              icon: Icon(Icons.delete, color: Colors.pink,),
              label: Text('Remove', style: TextStyle(color: Colors.white),)))
    ],
  );

  ///delete from hive
  /// it is used with deleteButton method
  void deleteQuote(QuoteDB quoteFav) {
    quoteFav.delete();
  }
}
