library flutter_responsive;

import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';
export 'package:flutter_modular/flutter_modular.dart';
export 'package:flutter_mobx/flutter_mobx.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:bitsdojo_window/bitsdojo_window.dart';

class FlutterResposive {
  FlutterResposive(
      {required List<MenuExpandido> menusexpandidos,
      required String descricaosistema,
      required String infosistema,
      required String pathLogo,
      required String fundoLoginLateral,
      required String fundoLoginPrincipal,
      required String pathImageHeader,
      required bool menuMobilePrimaryColor,
      Widget? logoSecundario}) {
    menus = menusexpandidos;
    nomesistema = descricaosistema;
    logo = pathLogo;
    fundo = fundoLoginLateral;
    fundoPrincipal = fundoLoginPrincipal;
    nomeSistemaDescricao = infosistema;
    imagemheader = pathImageHeader;
    mobilePrimary = menuMobilePrimaryColor;
    logosecundario = logoSecundario;
  }
}
