import 'package:flutter/material.dart';
import 'listarLaboratorio_module.dart';
import '../../models/laboratorio_model.dart';
import '../../bloc/laboratorio_bloc.dart';

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

  bool ifDelete = false;
  bool ifSuccessful = false;

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

    ListarLaboratorioModule.to.bloc<LaboratorioBloc>().deleted.listen((deleted) {
      if (deleted)
        ifSuccessful = true;
      else
        ifSuccessful = false;
      Navigator.of(context).pop();
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

  void _popupSelect(String choice, Laboratorio lab) async {
    if(choice == 'Editar laboratório')
      print('Editar laboratorio');
    else if(choice == 'Excluir laboratório'){
    ifDelete = false;
    ifSuccessful = false;

      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Tem certeza que deseja excluir?'),
              content: Text('O laboratório será excluido permanentemente.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  textColor: Color(0xFF000080),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('OK'),
                  textColor: Color(0xFF000080),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ifDelete = true;
                  },
                )
              ],
            );
          });      

      if(ifDelete){
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            //comando de deletar laboratorio usando a API do backend
            ListarLaboratorioModule.to.bloc<LaboratorioBloc>().inDeleteTodo.add(lab.id);

            return SimpleDialog(children: <Widget>[
              Column(children: <Widget>[
                Container(
                  child: Text('Processando...', style: TextStyle(color: Color(0xFF4F4F4F), fontSize: 16)),
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                CircularProgressIndicator()
              ],)
            ]);
          });

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(ifSuccessful ? 'Laboratório excluido' : 'Erro'),
              content: Text(ifSuccessful ? 'Laboratório excluido com sucesso' : 'Ocorreu um erro ao tentar excluir o laboratório'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  textColor: Color(0xFF000080),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      }
    }
    else 
      print('Ver equipamentos');
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
              onSelected: (choice) => _popupSelect(choice, filteredLabs[index]),
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
