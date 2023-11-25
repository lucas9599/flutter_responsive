// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';

///Retorna um padrao de erro
class PadraoErro {
  DioException? erroDio;

  PadraoErro({this.erroDio});

  String get error {
    String mensagem = "Erro Não especificado!";
    if (erroDio != null) {
      if (erroDio?.response?.statusCode == 500) {
        mensagem = "Erro:" + (erroDio?.response?.data['detail'] ?? "");
      } else {
        mensagem = "Erro: " + (erroDio?.response?.data['message'] ?? "");
      }
    }
    return mensagem;
  }
}
