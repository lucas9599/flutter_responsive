import 'package:flutter_responsive_template/app/modules/perfis/crud/crud_perfil_page.dart';
import 'package:flutter_responsive_template/app/modules/perfis/crud/crud_perfil_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive_template/utils/rotas/custom.dart';

class CrudPerfilModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(CrudPerfilStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child("/",
        child: (contex) => CrudPerfilPage(),
        transition: TransitionType.custom,
        customTransition: Custom());
  }
}
