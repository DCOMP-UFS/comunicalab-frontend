import 'dart:async';

import 'package:comunicalab_frontend/app/src/laboratorio/modules/criarLaboratorio/criarLaboratorio_module.dart';
import '../../models/laboratorio_model.dart';
import '../../bloc/laboratorio_bloc.dart';
import 'package:flutter/material.dart';

class CriarLaboratorio extends StatefulWidget {

  @override
  CriarLaboratorioState createState() => CriarLaboratorioState();
}

StreamSubscription createdStream;

class CriarLaboratorioState extends State<CriarLaboratorio> {

  final List<String> _dropdownChoices = [
    'Disponível',
    'Reservado',
    'Em aula',
    'Em reforma'
  ];

  TextEditingController _nomeController = TextEditingController(),
      _localizacaoController = TextEditingController(),
      _capacidadeController = TextEditingController();

  String _dropdownValue;


  CriarLaboratorioState() {
    createdStream = CriarLaboratorioModule.to
        .bloc<LaboratorioBloc>()
        .created
        .listen((created) async {
      Navigator.of(context).pop();
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(created ? 'Laboratório cadastrado' : 'Erro'),
              content: Text(created
                  ? 'Laboratório cadastrado com sucesso'
                  : 'Ocorreu um erro ao tentar cadastrar o laboratório'),
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
      Navigator.of(context).pop();
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _handleCreateConfirmation() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Text('Criando...',
                      style: TextStyle(color: Color(0xFF4F4F4F), fontSize: 16)),
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                CircularProgressIndicator()
              ],
            )
          ]);
        });

    Laboratorio putLab = Laboratorio(
        name: _nomeController.text,
        location: _localizacaoController.text,
        capacity: int.parse(_capacidadeController.text),
        status: _dropdownValue);
    CriarLaboratorioModule.to.bloc<LaboratorioBloc>().inCreateLab.add(putLab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Laboratório'),
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
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Color(0xFF000080), width: 2.0)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      items: _dropdownChoices
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _dropdownValue,
                      isExpanded: true,
                      hint: new Text("Status"),
                      onChanged: (value) {
                        setState(() => _dropdownValue = value);
                      })),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
                constraints: BoxConstraints(maxWidth: 350),
                child: TextField(
                  controller: _capacidadeController,
                  decoration: InputDecoration(
                    hintText: "Capacidade",
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 16.0),
                )),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
              constraints: BoxConstraints(maxWidth: 350),
              child: SizedBox(
                height: 50.0,
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Color(0xFF000080),
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () => _handleCreateConfirmation(),
                  child: new Text(
                    "Cadastrar",
                  ),
                ),
              ),
            ),
            Container()
          ]),
    );
  }
}
