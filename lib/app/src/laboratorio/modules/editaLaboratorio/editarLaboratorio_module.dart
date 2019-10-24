import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'editarLaboratorio_widget.dart';
import '../../models/laboratorio_model.dart';

class EditarLaboratorioModule extends ModuleWidget{
  EditarLaboratorioModule({this.lab});

  final Laboratorio lab;

  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => null;

  @override
  Widget get view => EditarLaboratorio(lab: lab);

  static Inject get to => Inject<EditarLaboratorioModule>.of();
}