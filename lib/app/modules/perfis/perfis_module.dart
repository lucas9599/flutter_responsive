import 'package:flutter_responsive_template/app/modules/perfis/crud/crud_perfil_module.dart';
import 'package:flutter_responsive_template/app/modules/perfis/perfis_page.dart';
import 'package:flutter_responsive_template/app/modules/perfis/perfis_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfisModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(PerfisStore.new, key: "tabela");
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (contex) => PerfisPage(),
    );
    r.module('/crud', module: CrudPerfilModule());
  }
}
