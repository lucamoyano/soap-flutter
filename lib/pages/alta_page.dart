import 'package:consumir_soap/models/alta_model.dart';
import 'package:consumir_soap/providers/alta_provider.dart';
import 'package:flutter/material.dart';

class AltaPage extends StatefulWidget {
  const AltaPage({Key? key}) : super(key: key);

  @override
  State<AltaPage> createState() => _AltaPageState();
}

class _AltaPageState extends State<AltaPage> {
  final altaProvider = AltaProvider();

 late Future<List<Alta>> alta;

  @override
  void initState() {
    alta = altaProvider.getAlta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: alta,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
            if(!snapshot.hasData){
              return Container(child: CircularProgressIndicator());
            }
            else {
              final data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return Column(children: <Widget>[
                    Text('nro trans: ${data[index].nroTransRef}'),
                    Text('codigo integracion: ${data[index].codigointegracion}'),
                    Text('nombre Integracion: ${data[index].nombreIntegracion}'),
                    Text('fecha Documento: ${data[index].fechaDocumento}'),
                    Divider(),
                  ]);
                });
            }
           },
         
        )
      )
    );
  }
}