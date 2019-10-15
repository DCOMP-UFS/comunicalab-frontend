import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/models/laboratorio_model.dart';

class LaboratorioBloc extends BlocBase{

  final _laboratorioController = StreamController<List<Laboratorio>>.broadcast();
  StreamSink<List<Laboratorio>> get _inLaboratorios => _laboratorioController.sink;
  Stream<List<Laboratorio>> get laboratorios => _laboratorioController.stream;

  LaboratorioBloc() {
    getLaboratorios();
  }

  @override
  dispose(){
    _laboratorioController.close();
    super.dispose();
  }

  Future<void> getLaboratorios() async {
    Response response = await Dio().get('https://comunicabackdev.herokuapp.com/laboratory');
    List<Laboratorio> labs = [];

    if(response.data.length != 0)
      response.data.forEach((lab) => labs.add(Laboratorio.fromJson(lab)));

    _inLaboratorios.add(labs);
  }
}