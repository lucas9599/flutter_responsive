import 'package:example/app/app_controller.dart';
import 'package:example/app/modules/home2/home2_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive_template/app/modules/login/login_module.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_module.dart';
import 'package:flutter_responsive_template/app/modules/perfis/perfis_module.dart';
import 'package:flutter_responsive_template/utils/rotas/rota_modal.dart';
import 'package:flutter_responsive_template/utils/filtros/herdados/filtro_descricao.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => AppController())];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: LoginModule(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/home",
      module: HomeModule(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/home2",
      module: Home2Module(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/usuario",
      module: UsuariosModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      "/perfis",
      module: PerfisModule(),
      transition: TransitionType.fadeIn,
    ),
    RotaModal('/filtrardescricao', child: (_, args) => FiltroDescricao())
  ];
}
