import 'package:lunch_lista/models/Results.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ResultApiProvider {
  Client client = Client();

  Future<Results> fetchRestaurant() async {
    final response = await client.get('https://mauritz.cloud/lunch-meny',
        headers: {'Content-Type': 'application/json; charset=utf-8'});

    if (response.statusCode == 200) {
      return Results.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(' Failed to load restaurant list.');
    }
  }
}
