import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive_template/flutter_responsive.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_responsive_template/constantes.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  FlutterResposive(
    descricaosistema: "SIGA",
    fundoLoginLateral: "imagens/fundo_login.jpg",
    pathLogo: "imagens/avaliacao.png",
    fundoLoginPrincipal: "imagens/fundo2.jpg",
    infosistema: "Sistema de Avaliacao",
    menusexpandidos: [
      MenuExpandido(
        label: "Principal",
        indexMenu: 0,
        iconMobile: Icons.desktop_windows,
        menus: [
          Menu(
            label: "Home",
            icon: Icons.home,
            rota: "/home",
            mapeado: false,
          ),
        ],
      ),
    ],
  );
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
  if (isDesktop) {
    doWhenWindowReady(() {
      const initialSize = Size(900, 700);
      appWindow.minSize = Size(300, 500);
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}
