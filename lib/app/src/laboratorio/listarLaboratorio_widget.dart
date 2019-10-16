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

  final List<String> _popupChoices = [
    'Editar laboratório',
    'Excluir laboratório',
    'Ver equipamentos'
  ];

  ListarLaboratorioState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

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

  void _popupSelect(String choice) {
    /*if(choice == 'Editar laboratório')
      rota para tela de editar laboratório
    else if(choice == 'Excluir laboratório')
      rota para tela de excluir laboratório
    else 
      rota para tela de exibição de equipamentos do laboratório*/
  }

  Widget _buildList(List<Laboratorio> labs) {
    List<Laboratorio> filteredLabs = [];

    labs.forEach((lab) {
      if (lab.name.toUpperCase().contains(_searchText.toUpperCase()))
        filteredLabs.add(lab);
    });

    if (filteredLabs.isEmpty)
      return Center(child: Text('Laboratório(s) não encontrado(s)'));

    return ListView.builder(
      itemCount: filteredLabs.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Color(0xFFF8F8FF),
          child: ListTile(
            title: Text(filteredLabs[index].name),
            subtitle: Text(
                'Capacidade: ${filteredLabs[index].capacity.toString()} pessoas',
                style: TextStyle(color: Color(0xFF4682B4))),
            trailing: PopupMenuButton<String>(
              onSelected: _popupSelect,
              itemBuilder: (BuildContext context) {
                return _popupChoices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(color: Color(0xFF4F4F4F)),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Laboratorio>>(
        stream: ListarLaboratorioModule.to.bloc<LaboratorioBloc>().laboratorios,
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
            body: snapshot.hasData ? _buildList(snapshot.data) : Center(child: CircularProgressIndicator()),
          );
        });
  }
}
