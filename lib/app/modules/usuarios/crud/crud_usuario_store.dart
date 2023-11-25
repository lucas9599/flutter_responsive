// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_repository.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_crud_base.dart';
import 'package:mobx/mobx.dart';

part 'crud_usuario_store.g.dart';

class CrudUsuarioStore = _CrudUsuarioStoreBase with _$CrudUsuarioStore;

abstract class _CrudUsuarioStoreBase extends StoreCrudBase with Store {
  _CrudUsuarioStoreBase() : super(repository: UsuariosRepository());
}
