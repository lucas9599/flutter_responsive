import 'package:flutter_responsive/app/modules/usuarios/crud/crud_page.dart';
import 'package:flutter_responsive/app/modules/usuarios/crud/crud_store.dart';
import 'package:flutter_responsive/utils/rotas/rota_modal.dart';
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
