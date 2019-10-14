import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class ListarLaboratorio extends StatefulWidget {
  @override
  ListarLaboratorioState createState() => ListarLaboratorioState();
}

class ListarLaboratorioState extends State<ListarLaboratorio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de laboratórios"),
        ),
      body: Center(
        child: Text('Hello Listar Laboratórios'),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}