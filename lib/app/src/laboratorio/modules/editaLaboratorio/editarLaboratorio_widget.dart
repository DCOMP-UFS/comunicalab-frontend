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

  final List<String> _dropdownChoices = [
    'Disponível',
    'Reservado',
    'Em aula',
    'Em reforma'
  ];

  TextEditingController _nomeController = TextEditingController(),
                        _localizacaoController = TextEditingController(),
                        _latitudeController = TextEditingController(),
                        _longitudeController = TextEditingController(),
                        _capacidadeController = TextEditingController();

  bool ifDeleteChosen = false;
  bool ifDeleted = false;

  String _dropdownValue;

  EditarLaboratorioState(){
    ListarLaboratorioModule.to.bloc<LaboratorioBloc>().deleted.listen((deleted) {
      if (deleted)
        ifDeleted = true;
      else
        ifDeleted = false;
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();

    _nomeController.text = widget.lab.name;
    _localizacaoController.text = widget.lab.location;
    _latitudeController.text = widget.lab.latitude.toString();
    _longitudeController.text = widget.lab.longitude.toString();
    _capacidadeController.text = widget.lab.capacity.toString();
    _dropdownValue = widget.lab.status;
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
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Container(
                constraints: BoxConstraints(maxWidth: 350),
                child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      hintText: "Nome",
                    ),
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16.0),
                  ),
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                  constraints: BoxConstraints(maxWidth: 350),
                  child: TextField(
                    controller: _localizacaoController,
                    decoration: InputDecoration(
                      hintText: "Localização",
                    ),
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16.0),
                  ),
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                constraints: BoxConstraints(maxWidth: 350),
                child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _latitudeController,
                          decoration: InputDecoration(
                          hintText: "Latitude",
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Flexible(
                        child: TextField(
                          controller: _longitudeController,
                          decoration: InputDecoration(
                          hintText: "Longitude",
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                constraints: BoxConstraints(maxWidth: 350),
                child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: DropdownButton(
                            items: _dropdownChoices.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _dropdownValue,
                            isExpanded: true,
                            hint: new Text("Select City"),
                            onChanged: (value){
                              setState(() => _dropdownValue = value);
                            }
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: _capacidadeController,
                          decoration: InputDecoration(
                          hintText: "Capacidade",
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                ),
              ),
              Container()
            ]),
    );
  }
}
