import 'package:agenda_contatos/App/src/views/home_views.dart';
import 'package:flutter/material.dart';

class AgendaContatosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeViews(),
      theme: ThemeData(
        cursorColor: Colors.brown,
        buttonColor: Colors.brown,
        indicatorColor: Colors.brown,
        accentColor: Colors.grey[700],
        hintColor: Colors.brown,
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown,
        fontFamily: 'Amiri',
        canvasColor: Colors.yellow[50],
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontFamily: 'Amiri',
            color: Colors.white,
            fontSize: 24,
          ),
          headline6: TextStyle(
            fontFamily: 'AsapCondensed',
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 5,
          color: Colors.brown,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: 'AsapCondensed',
              color: Colors.white,
              letterSpacing: 3,
            ),
          ),
        ),
      ),
    );
  }
}
