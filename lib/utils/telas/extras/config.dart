import 'dart:convert';

import 'package:flutter_responsive_template/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Configurador de sessões
class Config {
  ///grava usuario no cache
  static gravarUsuario({
    required String email,
    required String senha,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'usuario', json.encode({"email": email, "senha": senha}));
  }

//Exclui usuario do cache
  static excluirusuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('usuario', "");
  }

  ///retorna o usuario
  static Future<Map<String, dynamic>?> getUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final res = preferences.getString('usuario');
    if (res != null && res.isNotEmpty) {
      return json.decode(res);
    }
    return null;
  }

  ///gravar o ip e porta da aplicação
  static gravarConfiguracao({
    required String ip,
    required String porta,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(
        'config', json.encode({"ip": ip, "porta": porta}));
    ipservidor = ip;
    portaservidor = porta;
  }

  ///retorna a configuração. Caso seja a primeira configuração retorna ip: 127.0.0.1 e prota 8080
  static Future<Map<String, dynamic>?> getConfiguracao() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final res = preferences.getString('config');
    if (res != null && res.isNotEmpty) {
      return json.decode(res);
    }
    return {"ip": "127.0.0.1", "porta": "8080"};
  }
}
