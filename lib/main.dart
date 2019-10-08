import 'package:flutter/material.dart';
import 'package:comunicalab_frontend/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comunica-lab',
      theme: ThemeData(
          primaryColor: Color(0xFF000080),
          fontFamily: 'Roboto',
          textTheme: TextTheme(subhead: TextStyle(color: Color(0xFF000080))),
          unselectedWidgetColor: Color(0xFF000080),
          dialogTheme: DialogTheme(contentTextStyle: TextStyle(color: Color(0xFF4F4F4F))),
          inputDecorationTheme: InputDecorationTheme(
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Color(0xFF000080), width: 2.0)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Color(0xFF000080), width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: Color(0xFF000080), width: 2.0))),
          appBarTheme: AppBarTheme(color: Color(0xFFF8F8FF)),
          primaryIconTheme: IconThemeData(color: Color(0xFF000080)),
          primaryTextTheme: Theme.of(context).primaryTextTheme.apply(bodyColor: Color(0xFF000080)),
          accentTextTheme: Theme.of(context).primaryTextTheme.apply(bodyColor: Color(0xFF4682B4))
      ),
      home: LoginPage(),
    );
  }
}
