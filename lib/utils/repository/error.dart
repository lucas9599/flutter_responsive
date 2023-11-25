import 'package:dio/dio.dart';

class ErrorConexao implements Exception {
  final Exception exception;

  ErrorConexao({required this.exception});
  String get mensagem {
    if (exception is DioException) {
      DioException d = (exception as DioException);
      if ((d.response?.statusCode ?? 0) == 401) {
        return d.response?.data['message'] ?? "Erro ao enviar dados";
      } else if ((d.response?.statusCode ?? 0) == 900) {
        return d.response!.data['ERRO'];
      } else {
        return "Error ao enviar dados!";
      }
    }
    return "Erro de processamento!";
  }
}
