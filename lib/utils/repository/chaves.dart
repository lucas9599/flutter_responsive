import 'dart:convert';

import 'package:flutter_responsive/constantes.dart';
import 'package:flutter_responsive/utils/filtros/bases/filtro_base.dart';
import 'package:dio/dio.dart';

enum TipoApi { normal, geral }

mixin ChavesPadrao {
  Dio cliente = Dio(BaseOptions(
    headers: {"Authorization": "Bearer ${usuarioLogado?.token ?? ''}"},
  ));

  Map<String, dynamic> getChaves(
      {Map<String, dynamic>? dados,
      List<FiltroBase>? filtros,
      String? tabela,
      int? tipo,
      bool isLista = false,
      String campodescricao = "descricao"}) {
    List<Map<String, dynamic>> f = [];
    if (filtros != null) {
      for (int i = 0; i < filtros.length; i++) {
        f.add(filtros[i].toJson());
      }
    }

    return {
      "dados": json.encode(dados ?? {}),
      "tabela": tabela ?? "",
      "idsistema": 1,
      "operador": usuarioLogado?.usuario ?? "",
      "id": usuarioLogado?.id ?? "-1",
      "tipo": tipo ?? 4,
      "filtros": f,
      "isLista": isLista,
      "campodescricao": campodescricao
    };
  }
}
