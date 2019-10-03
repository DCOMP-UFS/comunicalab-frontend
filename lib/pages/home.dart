import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final headerTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0);

  Widget _handlerSideBar(){
    return Drawer(
      child: ListView(
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
          ),
          ExpansionTile(
            title: Text('Software'),
            children: <Widget>[
              ListTile(
                title: Text('Cadastrar software'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Listar softwares'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Cadastrar categorias'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Registrar instalação'),
                onTap: (){},
              )
            ],
          ),
          ExpansionTile(
            title: Text('Equipamento'),
            children: <Widget>[
              ListTile(
                title: Text('Cadastrar equipamento'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Listar equipamentos'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Cadastrar categorias'),
                onTap: (){},
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Laboratório'),
            children: <Widget>[
              ListTile(
                title: Text('Cadastrar laboratório'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Listar laboratórios'),
                onTap: (){},
              )
            ],
          ),
          ExpansionTile(
            title: Text('Configurações'),
          ),
          ExpansionTile(
            title: Text('Logout'),
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