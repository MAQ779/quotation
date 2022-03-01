//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Quote {
  final String author;
  final int id;
  final String quoteContent;

  Quote({
    required this.author,
    required this.id,
    required this.quoteContent,
  });

  int getId(){
    return id;
  }
  String getAuthor(){
    return author;
  }
  String getContent(){
    return quoteContent;
  }

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      author: json['author'],
      id: json['id'],
      quoteContent: json['quote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'id': id,
      'contentQ': quoteContent,
    };
  }
}
class RandomQuote{

  Future<Quote> fetchQuote() async {
    final response = await http
        .get(Uri.parse('http://quotes.stormconsultancy.co.uk/random.json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Quote.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

