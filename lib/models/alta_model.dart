// To parse this JSON data, do
//
//     final alta = altaFromJson(jsonString);

import 'dart:convert';

List<Alta> altaFromJson(String str) => List<Alta>.from(json.decode(str).map((x) => Alta.fromJson(x)));

String altaToJson(List<Alta> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alta {
    Alta({
        required this.nroTransRef,
        required this.codigointegracion,
        required this.nombreIntegracion,
        required this.fechaDocumento,
        required this.estaActivo,
    });

    int nroTransRef;
    String codigointegracion;
    String nombreIntegracion;
    String fechaDocumento;
    String estaActivo;

    factory Alta.fromJson(Map<String, dynamic> json) => Alta(
        nroTransRef: json["nro_trans_ref"],
        codigointegracion: json["Codigointegracion"],
        nombreIntegracion: json["NombreIntegracion"],
        fechaDocumento: json["FechaDocumento"],
        estaActivo: json["EstaActivo"],
    );

    Map<String, dynamic> toJson() => {
        "nro_trans_ref": nroTransRef,
        "Codigointegracion": codigointegracion,
        "NombreIntegracion": nombreIntegracion,
        "FechaDocumento": fechaDocumento,
        "EstaActivo": estaActivo,
    };
}
