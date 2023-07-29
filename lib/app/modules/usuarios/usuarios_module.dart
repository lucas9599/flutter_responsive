import 'package:flutter_responsive_template/app/modules/usuarios/crud/crud_module.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_page.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuariosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UsuariosStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => UsuariosPage()),
    ModuleRoute("/crud",
        module: CrudModule(), transition: TransitionType.noTransition),
  ];
}
