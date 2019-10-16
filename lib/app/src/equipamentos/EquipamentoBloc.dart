import 'package:comunicalab_frontend/app/src/equipamentos/EquipamentoService.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class EquipamentoBloc {
  final BehaviorSubject<bool> _listController = BehaviorSubject<bool>.seeded(true);
  Sink<bool> get listIn => _listController.sink;
  Observable<List<Equipamento>> listOut;
  EquipamentoService service = EquipamentoService();

  EquipamentoBloc(){
    print("aqui 0");
    listOut = _listController.stream
            .asyncMap((d)=>service.getEquipamentos());
  }

  dispose(){
    _listController.close();
  }
}