import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';
import 'dart:async';
import 'dart:convert';
import 'classes/quote.dart';
import 'screen/new_quote_page.dart';
import 'screen/loaded_quote.dart';
import 'screen/favorite_quote.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'SavingQuotes/quoteDB.dart';

//const NewQuotePage()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(QuoteDBAdapter());

 ///for the fav quote
 // Hive.registerAdapter(QuoteFavAdapter());
  await Hive.openBox<QuoteDB>('quote');
  await Hive.openBox<QuoteDB>('quoteFav');

  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
      MainPage(),

  );
}


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QPM',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0XFF100424),
          textTheme: TextTheme(headline1: TextStyle(color: Colors.white38)),
          appBarTheme: AppBarTheme(
            color: Color(0xB7695390),
          )),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const Main(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/newQ': (context) => const NewQuotePage(),
        '/loadedQ': (context) => const LoadedQuotesPage(),
        '/favoriteQ': (context) => const FavoriteQuotesPage(),
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}


class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                  child: Text(
                'WELCOME TO MPQ',
                style: TextStyle(fontSize: 40, color: Colors.purple),
              )),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 2,
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: GFButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.pushNamed(context, '/newQ');
                        },
                        textStyle:
                            TextStyle(fontSize: 30, color: Colors.deepPurple),
                        text: 'New Quote',
                        shape: GFButtonShape.pills,
                        type: GFButtonType.outline2x,
                        size: GFSize.LARGE,
                        splashColor: Color(0xB7695390),
                        fullWidthButton: true,
                      ),
                    ),
                  ),
                  //SizedBox(height: 2,),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: GFButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.pushNamed(context, '/favoriteQ');
                        },
                        textStyle:
                            TextStyle(fontSize: 20, color: Colors.deepPurple),
                        text: 'Liked quote',
                        shape: GFButtonShape.pills,
                        type: GFButtonType.outline2x,
                        size: GFSize.LARGE,
                        splashColor: Color(0xB7695390),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: GFButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.pushNamed(context, '/loadedQ');
                        },
                        textStyle:
                            TextStyle(fontSize: 20, color: Colors.deepPurple),
                        text: 'loaded Quote',
                        shape: GFButtonShape.pills,
                        type: GFButtonType.outline2x,
                        size: GFSize.LARGE,
                        splashColor: Color(0xB7695390),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
