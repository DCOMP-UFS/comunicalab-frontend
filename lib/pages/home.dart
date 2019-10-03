import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final headerTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0);

  Widget _handlerSideBar(){
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.all(0.0),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color(0xFFFFFFFF),
              child: Icon(Icons.person_outline,
              color: Color(0xFF000080),
              size: 64),
            ),
            accountEmail: Text('email@email.com', style: headerTextStyle),
            onDetailsPressed: (){},
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comunica-lab"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){},
          )
        ],
      ),
      drawer: ListTileTheme(
          iconColor: Color(0xFF000080),
          child: _handlerSideBar()), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}