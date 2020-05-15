import 'package:agenda_contatos/App/src/views/home_views.dart';
import 'package:flutter/material.dart';

class AgendaContatosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeViews(),
      theme: ThemeData(
        cursorColor: Colors.lightBlue,
        buttonColor: Colors.lightBlue,
        indicatorColor: Colors.lightBlue,
        accentColor: Colors.grey[600],
        hintColor: Colors.lightBlue,
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.lightBlue,
        fontFamily: 'Amiri',
        canvasColor: Colors.yellow[50],
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontFamily: 'Amiri',
            color: Colors.black,
            fontSize: 16,
          ),
          headline6: TextStyle(
            fontFamily: 'AsapCondensed',
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 5,
          color: Colors.lightBlue,
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
