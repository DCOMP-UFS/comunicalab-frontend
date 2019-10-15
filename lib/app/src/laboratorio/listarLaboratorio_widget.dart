import 'package:flutter/material.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/listarLaboratorio_module.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/models/laboratorio_model.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/laboratorio_bloc.dart';

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
          autofocus: true,
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
    return StreamBuilder<List<Laboratorio>>(
      stream: ListarLaboratorioModule.to.bloc<LaboratorioBloc>().laboratorios,
      initialData: [],
      builder: (context, snapshot) {
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
    );
  }
}
