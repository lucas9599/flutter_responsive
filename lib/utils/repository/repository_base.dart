import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/criptografia.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';
import 'package:flutter_responsive_template/utils/repository/chaves.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class Repository with ChavesPadrao {
  final String endpoint;
  final TipoApi tipoApi;
  final String? tabela;
  final bool isLista;
  final String campoDescricao;
  final bool carregarInclusao;
  String get urlapi => "$urlApiGeral/$endpoint";

  Repository(this.endpoint,
      {this.tipoApi = TipoApi.geral,
      this.tabela,
      this.isLista = false,
      this.carregarInclusao = false,
      this.campoDescricao = "descricao"});

  Future<List> getAll({List<FiltroBase>? filtros}) async {
    Modular.get<IAppController>().crescente = false;
    Modular.get<IAppController>().indexsort = 1;
    Response response = await cliente.post(urlapi,
        data: Criptografia.criptografar(json.encode(filtros ?? [])));
    return response.data as List;
  }

  Future<Map<String, dynamic>> getID(int id) async {
    if (id == -1 && !carregarInclusao) {
      return {};
    } else {
      Response response =
          await cliente.get(urlapi, queryParameters: {"id": id});
      return response.data as Map<String, dynamic>;
    }
  }

  Future<bool> delete(int id) async {
    await cliente.delete(urlapi, queryParameters: {"id": id});
    return true;
  }

  Future<bool> save(
    Map<String, dynamic> data,
  ) async {
    await cliente.put(urlapi, data: json.encode(data));
    return true;
  }

  Future<Uint8List> gerarPDFListagem({List<FiltroBase>? filtros}) async {
    Response response = await cliente.post(
      "$urlapi/listagem",
      options: Options(responseType: ResponseType.bytes),
      data: json.encode(
        filtros ?? [],
      ),
    );
    return response.data as Uint8List;
  }
}
