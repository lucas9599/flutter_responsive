library flutter_responsive_template;

import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';

class FlutterResposive {
  FlutterResposive(
      {required List<MenuExpandido> menusexpandidos,
      required String descricaosistema,
      required String infosistema,
      required String pathLogo,
      required String fundoLoginLateral,
      required String fundoLoginPrincipal}) {
    menus = menusexpandidos;
    nomesistema = descricaosistema;
    logo = pathLogo;
    fundo = fundoLoginLateral;
    fundoPrincipal = fundoLoginPrincipal;
    nomeSistemaDescricao = infosistema;
  }
}
