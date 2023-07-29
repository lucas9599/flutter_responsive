import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_responsive/model/usuario.dart';
import 'package:flutter_responsive/constantes.dart';
import 'package:flutter_responsive/utils/criptografia.dart';

class LoginRepository {
  Dio cliente = Dio();

  Future<bool> login(Usuario usuario) async {
    String data = Criptografia.criptografar(
      json.encode(
        usuario.toJson(),
      ),
    );

    Response response =
        await cliente.post("$urlApiGeral/usuario/login", data: data);
    if (response.statusCode == 200) {
      usuario.admin = response.data['usuario']['admin'];
      usuario.usuario = response.data['usuario']['usuario'];
      usuario.id = response.data['usuario']['id'];
      usuario.foto = (response.data['usuario']['foto'] != null &&
              (response.data['usuario']['foto'] as String).isNotEmpty)
          ? base64.decode(response.data['usuario']['foto'])
          : null;
      usuario.permissoes = json.decode(
          (response.data['usuario']['id_perfil'] != null &&
                  (response.data['usuario']['id_perfil']['permissao'] as String)
                      .isNotEmpty)
              ? response.data['usuario']['id_perfil']['permissao'].toLowerCase()
              : "{}");
      usuario.token = response.data['token'];
      return true;
    } else {
      return false;
    }
  }
}
