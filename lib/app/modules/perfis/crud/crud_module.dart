import 'package:flutter_responsive_template/app/modules/perfis/crud/crud_page.dart';
import 'package:flutter_responsive_template/app/modules/perfis/crud/crud_store.dart';
import 'package:flutter_responsive_template/utils/rotas/rota_modal.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CrudModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CrudStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    RotaModal('/', child: (_, args) => CrudPage()),
  ];
}
