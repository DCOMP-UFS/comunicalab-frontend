import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import '../models/laboratorio_model.dart';

class LaboratorioBloc extends BlocBase{
  //GET Laboratorios
  final _laboratorioController = StreamController<List<Laboratorio>>.broadcast();
  StreamSink<List<Laboratorio>> get _inLaboratorios => _laboratorioController.sink;
  Stream<List<Laboratorio>> get laboratorios => _laboratorioController.stream;

  //DELETE ToDos
  final _deleteLaboratorioController = StreamController<int>.broadcast();
  StreamSink<int> get inDeleteTodo => _deleteLaboratorioController.sink;

  final _deletedLaboratorioController = StreamController<bool>.broadcast();
  StreamSink<bool> get _inDeleted => _deletedLaboratorioController.sink;
  Stream<bool> get deleted => _deletedLaboratorioController.stream;

  LaboratorioBloc() {
    getLaboratorios();

    _deleteLaboratorioController.stream.listen(_handleDeleteLaboratorio);
  }

  @override
  dispose(){
    _laboratorioController.close();
    _deleteLaboratorioController.close();
    _deletedLaboratorioController.close();

    super.dispose();
  }

  Future<void> _handleDeleteLaboratorio(int numLaboratorio) async {
    Response response = await Dio().delete('https://comunicabackdev.herokuapp.com/laboratory/${numLaboratorio.toString()}');

    if(response.statusCode == 200){
      _inDeleted.add(true);
      getLaboratorios();
    }
    else
      _inDeleted.add(false);
  }

  Future<void> getLaboratorios() async {
    Response response = await Dio().get('https://comunicabackdev.herokuapp.com/laboratory');
    List<Laboratorio> labs = [];

    if(response.data.length != 0)
      response.data.forEach((lab) => labs.add(Laboratorio.fromJson(lab)));

    _inLaboratorios.add(labs);
  }
}