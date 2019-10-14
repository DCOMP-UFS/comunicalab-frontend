import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:comunicalab_frontend/app/src/laboratorio/listarLaboratorio_widget.dart';

class ListarLaboratorioModule extends ModuleWidget{
  @override
  // TODO: implement blocs
  List<Bloc<BlocBase>> get blocs => null;

  @override
  // TODO: implement dependencies
  List<Dependency> get dependencies => null;

  @override
  // TODO: implement view
  Widget get view => ListarLaboratorio();
}