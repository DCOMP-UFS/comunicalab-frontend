import 'package:comunicalab_frontend/app/src/equipamentos/EquipamentoBloc.dart';
import 'package:comunicalab_frontend/app/src/equipamentos/model/Equipamento.dart';
import 'package:flutter/material.dart';

class EquipamentoWidget extends StatefulWidget {
  @override
  
  _EquipamentoWidgetState createState() => _EquipamentoWidgetState();
}


class _EquipamentoWidgetState extends State<EquipamentoWidget> {
  EquipamentoBloc bloc;

  @override
  void initState() {    
    bloc = EquipamentoBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text("Equipamentos"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){},
            )
          ],
        ),
      body:StreamBuilder(
      stream: bloc.listOut,      
      builder: (context,AsyncSnapshot<List<Equipamento>> snapshot){

            print("antes do if");
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);

            if(snapshot.hasError) return Center(child: Text("Falha na requisição"),);
            print("depois do if");
            List<Equipamento> list = snapshot.data;

            if(list.isEmpty) return Center(child: Text("Não existe equipamentos cadastrados"),);

            print(list.length)  ;
            return ListView.builder(
                 itemCount: list.length, 
                 itemBuilder: (BuildContext context,int index) {
                   return Text(list[index].brand);
                 },
            );

        }
    )
      );      
  }
}