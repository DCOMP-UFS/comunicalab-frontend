import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import '../models/laboratorio_model.dart';

class LaboratorioBloc extends BlocBase{
  //GET Laboratorios
  final _laboratorioController = StreamController<List<Laboratorio>>.broadcast();
  StreamSink<List<Laboratorio>> get _inLaboratorios => _laboratorioController.sink;
  Stream<List<Laboratorio>> get laboratorios => _laboratorioController.stream;

  //DELETE Laboratorios
  final _deleteLaboratorioController = StreamController<int>.broadcast();
  StreamSink<int> get inDeleteLab => _deleteLaboratorioController.sink;

  final _deletedLaboratorioController = StreamController<bool>.broadcast();
  StreamSink<bool> get _inDeleted => _deletedLaboratorioController.sink;
  Stream<bool> get deleted => _deletedLaboratorioController.stream;

  //PUT Laboratorios
  final _updateLaboratorioController = StreamController<Laboratorio>.broadcast();
  StreamSink<Laboratorio> get inUpdateLab => _updateLaboratorioController.sink;

  final _updatedLaboratorioController = StreamController<bool>.broadcast();
  StreamSink<bool> get _inUpdated => _updatedLaboratorioController.sink;
  Stream<bool> get updated => _updatedLaboratorioController.stream;

  //Create Lab
  final _createLaboratorioController = StreamController<Laboratorio>.broadcast();
  StreamSink<Laboratorio> get inCreateLab => _createLaboratorioController.sink;

  final _createdLaboratorioController = StreamController<bool>.broadcast();
  StreamSink<bool> get _inCreated => _createdLaboratorioController.sink;
  Stream<bool> get created => _createdLaboratorioController.stream;
  

  LaboratorioBloc() {
    getLaboratorios();

    _deleteLaboratorioController.stream.listen(_handleDeleteLaboratorio);
    _updateLaboratorioController.stream.listen(_handleUpdateLaboratorio);
    _createLaboratorioController.stream.listen(_handleCreateLaboratorio);
  }

  @override
  dispose(){
    _laboratorioController.close();
    _deleteLaboratorioController.close();
    _deletedLaboratorioController.close();
    _updateLaboratorioController.close();
    _updatedLaboratorioController.close();
    _createLaboratorioController.close();
    _createdLaboratorioController.close();

    super.dispose();
  }

  Future<void> _handleUpdateLaboratorio(Laboratorio lab) async {

    Response response = await Dio().put('https://comunicabackdev.herokuapp.com/laboratory/${lab.id}',
    data: {'name': lab.name, 'location': lab.location, 'status': lab.status, 'capacity': lab.capacity.toString(), 'active': lab.active.toString()});

    if(response.statusCode == 200){
      _inUpdated.add(true);
      getLaboratorios();
    }
    else
      _inUpdated.add(false);
  }

  Future<void> _handleCreateLaboratorio(Laboratorio lab) async {
    Response response = await Dio().post('https://comunicabackdev.herokuapp.com/laboratory/',
    data: {'name': lab.name, 'location': lab.location, 'status': lab.status, 'capacity': lab.capacity.toString()});
    print(response.data);
    if(response.statusCode == 201){
      _inCreated.add(true);
      getLaboratorios();
    }
    else
      _inCreated.add(false);
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