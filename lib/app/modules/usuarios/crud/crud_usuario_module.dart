import 'package:flutter_responsive_template/app/modules/usuarios/crud/crud_usuario_page.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/crud/crud_usuario_store.dart';
import 'package:flutter_responsive_template/utils/rotas/custom.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CrudUsuarioModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(
      CrudUsuarioStore.new,
    );
  }

  @override
  void routes(RouteManager r) {
    r.child("/",
        child: (contex) => CrudUsuarioPage(),
        transition: TransitionType.custom,
        customTransition: Custom());
  }
}
