import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/flutter_responsive.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';
import 'package:flutter_responsive_template/constantes.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  FlutterResposive(
    descricaosistema: "MEU SISTEMA",
    fundoLoginLateral: "imagens/fundo_login.jpg",
    pathLogo: "imagens/avaliacao.png",
    fundoLoginPrincipal: "imagens/fundo2.jpg",
    pathImageHeader: "imagens/top-header.png",
    menuMobilePrimaryColor: true,
    logoSecundario: Icon(Icons.edit, size: 50),
    infosistema: "Lorem Ipsum is simply dummy text of the",
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
          Menu(
            label: "Home 2",
            icon: Icons.home_filled,
            rota: "/home2",
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
