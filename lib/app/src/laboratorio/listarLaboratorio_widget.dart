import 'package:flutter/material.dart';

class ListarLaboratorio extends StatefulWidget {
  @override
  ListarLaboratorioState createState() => ListarLaboratorioState();
}

class ListarLaboratorioState extends State<ListarLaboratorio> {
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('Lista de laboratórios');

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF8F8FF))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF8F8FF)))),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Lista de laboratórios');
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: () => _searchPressed(),
          )
        ],
      ),
      body: Center(
        child: Text('Hello Listar Laboratórios'),
      ),
    );
  }
}
