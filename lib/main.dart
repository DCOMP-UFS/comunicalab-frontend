import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xFFF8F8FF),
          fontFamily: 'Roboto',
          textTheme: TextTheme(
              headline: TextStyle(color: Color(0xFF000080)),
              body1: TextStyle(color: Color(0xFF000080)),
              title: TextStyle(color: Color(0xFF000080)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _opacity = 0.0;

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 400), () => setState(() {
        _opacity = 1.0;
        Future.delayed(Duration(seconds: 3), () => setState(() {
          _opacity = 0.0;
        }));
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.18,
          child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 500),
              child: Image.asset('assets/images/logo_dcomp.jpg')),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
