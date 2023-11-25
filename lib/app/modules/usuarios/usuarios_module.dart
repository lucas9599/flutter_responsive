import 'package:flutter_responsive_template/app/modules/usuarios/crud/crud_usuario_module.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_page.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuariosModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(UsuariosStore.new, key: "tabela");
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (contex) => UsuariosPage());
    r.module("/crud",
        module: CrudUsuarioModule(), transition: TransitionType.noTransition);
  }
}
