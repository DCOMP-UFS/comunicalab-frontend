import 'package:comunicalab_frontend/app/src/utils/constantes.dart';
import 'package:dio/dio.dart';
import 'model/Equipamento.dart';

class EquipamentoService {
  Dio cliente = Dio();

  Future<List<Equipamento>> getEquipamentos() async{
    Response response = await cliente.get("$URL/softCategory");
  
    if (response.statusCode == 200) {      
      List<Equipamento> equipamentos = 
          (response.data as List).map((item) => Equipamento.fromJson(item)).toList();

      return equipamentos;                
    } else {
      Exception("Falha na requisição");
    }
  }

  Future<Equipamento> getEquipamento(int id) async{
    Response response = await cliente.get("$URL/equipment/$id");

    if (response.statusCode == 201) { 

      return Equipamento.fromJson(response.data);                
    } else {
      Exception("Falha na requisição");
    }
  }
}