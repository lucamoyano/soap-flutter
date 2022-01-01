import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'package:consumir_soap/models/alta_model.dart';
import 'package:xml2json/xml2json.dart';

class AltaProvider {
  final _uri = Uri.parse("http://autoges.inavi.com.uy:8080/soap/Ndm_INAVI_Produccion/services/forms/v1.2/TMuestraApp?vista=resp");
  final _body ='''
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:resp="http://nodum.com.uy/soap/Ndm_INAVI_Produccion/schemas/forms/v1.2/TMuestraApp/resp">
      <soapenv:Header/>
      <soapenv:Body>
          <resp:procesarAlta>
            <!--1 or more repetitions:-->
            <resp:TMuestraApp>
                <resp:General>
                  <resp:G1>
      
                  </resp:G1>
                </resp:General>
            </resp:TMuestraApp>
          </resp:procesarAlta>
      </soapenv:Body>
    </soapenv:Envelope>
   ''';

  String username = 'nodum';
  String password = 'nodum123';
  String basicAuth = 'Basic bm9kdW06bm9kdW0xMjM=';//'Basic ' + base64Encode('$username:$password');

  AltaProvider(){
    getAlta();
  }

  Future<List<Alta>> getAlta() async {
    final resp = await http.post(_uri,
    headers: {
      "Content-Type": "text/xml; charset=utf-8",
      "SOAPAction" : "http://nodum.com.uy/soap/Ndm_INAVI_Produccion/schemas/forms/v1.2/TMuestraApp/resp/Forms/procesarAltaRequest",
      "authorization": basicAuth,
      //"Accept":"application/json"
    }, 
    body: _body
    );

    if(resp.statusCode == 200){
      final responseBody = resp.body;

      var nrotransref = xml.XmlDocument.parse(responseBody).findAllElements('ns1:nro_trans_ref').first.text;
      var codigointegracion = xml.XmlDocument.parse(responseBody).findAllElements('ns1:Codigointegracion').first.text;
      var nombreIntegracion = xml.XmlDocument.parse(responseBody).findAllElements('ns1:NombreIntegracion').first.text;
      var fechaDocumento = xml.XmlDocument.parse(responseBody).findAllElements('ns1:FechaDocumento').first.text;
      var estaActivo = xml.XmlDocument.parse(responseBody).findAllElements('ns1:EstaActivo').first.text;

   
      var jsonXml = """[{
       "nro_trans_ref": $nrotransref,
       "Codigointegracion": "$codigointegracion",
       "NombreIntegracion": "$nombreIntegracion",
       "FechaDocumento": "$fechaDocumento",
       "EstaActivo" :"$estaActivo"
      }]""";
      
      //final decodeJson = jsonDecode(parseXml) as List;

    return List<Alta>.from(
      json.decode(jsonXml)
      .map((data) => Alta.fromJson(data))
    );

      //List<Alta> data = jsonXml.map((e) => Alta.fromJson(e)).toList();

      //return data;
    } else {
      throw Exception("No se pudo conectar");
      
    }

    
  }


  void main() {
    String s = "Hello, world! i am 'foo'";
    print(s.replaceAll(new RegExp(r'[^\w\s]+'),''));
  }


}