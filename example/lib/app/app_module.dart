import 'package:example/app/modules/home2/home2_module.dart';
import 'package:flutter_responsive_template/app/modules/login/login_module.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_module.dart';
import 'package:flutter_responsive_template/app/modules/perfis/perfis_module.dart';
import 'package:flutter_responsive_template/flutter_responsive.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';
import 'package:flutter_responsive_template/utils/rotas/custom.dart';
import 'package:flutter_responsive_template/utils/filtros/herdados/filtro_descricao.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(IAppController.new);
  }

  @override
  void routes(RouteManager r) {
    r.module("/", module: LoginModule());

    r.module(
      "/home",
      module: HomeModule(),
      transition: TransitionType.noTransition,
    );
    r.module(
      "/home2",
      module: Home2Module(),
      transition: TransitionType.noTransition,
    );
    r.module(
      "/usuario",
      module: UsuariosModule(),
      transition: TransitionType.fadeIn,
    );
    r.module(
      "/perfis",
      module: PerfisModule(),
      transition: TransitionType.fadeIn,
    );
    r.child('/filtrardescricao',
        child: (args) => FiltroDescricao(),
        customTransition: Custom(),
        transition: TransitionType.custom);
  }
}
