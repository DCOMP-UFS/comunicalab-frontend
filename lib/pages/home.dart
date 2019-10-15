import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/listarLaboratorio_module.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final headerTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0);

  void _handleLogout(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tem certeza que deseja sair desta sessão?'),
            content: Text('Sua sessão com este usuário será encerrada.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Sim'),
                textColor: Color(0xFF000080),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();},
              ),
              FlatButton(
                child: Text('Não'),
                textColor: Color(0xFF000080),
                onPressed: () {Navigator.of(context).pop();},
              )
            ],
          );
        });

  }

  Widget _handlerSideBar(){
    return Drawer(
      child: SingleChildScrollView(
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
            ),
            ExpansionTile(
              title: Text('Software'),
              leading: Icon(MdiIcons.console),
              children: <Widget>[
                ListTile(
                  title: Text('Cadastrar software', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Listar softwares', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Cadastrar categorias', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Listar categorias', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Registrar instalação', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Ver instalações', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                )
              ],
            ),
            ExpansionTile(
              title: Text('Equipamento'),
              leading: Icon(MdiIcons.projector),
              children: <Widget>[
                ListTile(
                  title: Text('Cadastrar equipamento', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Listar equipamentos', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Cadastrar categorias', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Listar categorias', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                )
              ],
            ),
            ExpansionTile(
              title: Text('Laboratório'),
              leading: Icon(MdiIcons.desktopTowerMonitor),
              children: <Widget>[
                ListTile(
                  title: Text('Cadastrar laboratório', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){},
                ),
                ListTile(
                  title: Text('Listar laboratórios', style: TextStyle(color: Color(0xFF6A5ACD))),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListarLaboratorioModule()));
                  },
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(MdiIcons.logout),
              title: Text('Logout'),
              onTap: () => _handleLogout(context),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
      ),
    );
  }
}