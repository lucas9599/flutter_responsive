import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:flutter_responsive/utils/repository/repository_base.dart';

class LatexRepository extends Repository {
  LatexRepository() : super("avaliacao/latex");

  Future<Uint8List> getLatex(String latex) async {
    Response response = await cliente.post(urlapi,
        data: latex, options: Options(responseType: ResponseType.bytes));
    //   print(response.data);
    return response.data as Uint8List;
  }
}
