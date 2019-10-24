import '../../models/laboratorio_model.dart';
import '../listarLaboratorio/listarLaboratorio_module.dart';
import '../../bloc/laboratorio_bloc.dart';
import 'package:flutter/material.dart';

class EditarLaboratorio extends StatefulWidget {
  EditarLaboratorio({this.lab});

  final Laboratorio lab;

  @override
  EditarLaboratorioState createState() => EditarLaboratorioState();
}

class EditarLaboratorioState extends State<EditarLaboratorio> {
  final List<String> _popupChoices = [
    'Excluir laboratório'
    ];

  bool ifDeleteChosen = false;
  bool ifDeleted = false;

  EditarLaboratorioState(){
    ListarLaboratorioModule.to.bloc<LaboratorioBloc>().deleted.listen((deleted) {
      if (deleted)
        ifDeleted = true;
      else
        ifDeleted = false;
      Navigator.of(context).pop();
    });
  }

  void _appBarPopupSelect(choice) async {
    if(choice == 'Excluir laboratório'){
      ifDeleteChosen = false;
      ifDeleted = false;

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
                    ifDeleteChosen = true;
                  },
                )
              ],
            );
          });

      if(ifDeleteChosen){
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            //comando de deletar laboratorio usando a API do backend
            ListarLaboratorioModule.to.bloc<LaboratorioBloc>().inDeleteTodo.add(widget.lab.id);

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
              title: Text(ifDeleted ? 'Laboratório excluido' : 'Erro'),
              content: Text(ifDeleted ? 'Laboratório excluido com sucesso' : 'Ocorreu um erro ao tentar excluir o laboratório'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  textColor: Color(0xFF000080),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if(ifDeleted)
                      Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lab.name),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice) => _appBarPopupSelect(choice),
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
          )
        ],
      ),
      body: Center(child: Text('Editar laboratório')),
    );
  }
}
