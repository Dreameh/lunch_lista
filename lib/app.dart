import 'package:flutter/material.dart';
import 'package:lunch_lista/ui/ListPage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: new ListPage(title: 'Lunch Lista'),
      );
  }
}