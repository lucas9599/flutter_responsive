import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_responsive_template/model/usuario.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';

String nomesistema = "";

List<MenuExpandido> menus = [];
Widget? logosecundario;
String ipservidor = "127.0.0.1";
String portaservidor = "8080";
String fundo = "imagens/fundo_login.jpg";
String logo = "imagens/fundo2.jpg";
String nomeSistemaDescricao = "";
String fundoPrincipal = "";
String imagemheader = "imagens/top-header.png";
bool mobilePrimary = true;

String urlApi = "http://$ipservidor:$portaservidor";
String urlApiGeral = "http://$ipservidor:$portaservidor";
Usuario? usuarioLogado;
String rotaatual = "";

bool isTelaPequena(BuildContext context) {
  return MediaQuery.of(context).size.width < 600;
}

bool isTelaMedia(BuildContext context) {
  final largura = MediaQuery.of(context).size.width;
  return largura > 600 && largura <= 800;
}

bool isTelaGrande(BuildContext context) {
  return MediaQuery.of(context).size.width > 800;
}

bool get isDesktop =>
    !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

bool get isWeb => kIsWeb;
