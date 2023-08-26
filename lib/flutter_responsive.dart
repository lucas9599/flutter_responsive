library flutter_responsive;

import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';

class FlutterResposive {
  FlutterResposive({
    required List<MenuExpandido> menusexpandidos,
    required String descricaosistema,
    required String infosistema,
    required String pathLogo,
    required String fundoLoginLateral,
    required String fundoLoginPrincipal,
    required String pathImageHeader,
    required bool menuMobilePrimaryColor,
  }) {
    menus = menusexpandidos;
    nomesistema = descricaosistema;
    logo = pathLogo;
    fundo = fundoLoginLateral;
    fundoPrincipal = fundoLoginPrincipal;
    nomeSistemaDescricao = infosistema;
    imagemheader = pathImageHeader;
    mobilePrimary = menuMobilePrimaryColor;
  }
}
