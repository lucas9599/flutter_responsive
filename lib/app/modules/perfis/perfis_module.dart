import 'package:flutter_responsive/app/modules/perfis/crud/crud_module.dart';
import 'package:flutter_responsive/app/modules/perfis/perfis_page.dart';
import 'package:flutter_responsive/app/modules/perfis/perfis_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfisModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => PerfisStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => PerfisPage()),
    ModuleRoute('/crud', module: CrudModule()),
  ];
}
