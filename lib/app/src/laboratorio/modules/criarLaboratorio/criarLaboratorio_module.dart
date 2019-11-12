import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/bloc/laboratorio_bloc.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/models/laboratorio_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'criarLaboratorio_widget.dart';

class CriarLaboratorioModule extends ModuleWidget{
  CriarLaboratorioModule({this.lab});

  final Laboratorio lab;

  @override
  List<Bloc> get blocs => [
    Bloc((i) => LaboratorioBloc(), singleton: true)
  ];

  @override
  List<Dependency> get dependencies => null;

  @override
  Widget get view => CriarLaboratorio();

  static Inject get to => Inject<CriarLaboratorioModule>.of();
}