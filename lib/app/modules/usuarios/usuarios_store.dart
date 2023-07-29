// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive_template/model/usuario.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_repository.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_base.dart';
import 'package:mobx/mobx.dart';

part 'usuarios_store.g.dart';

class UsuariosStore = _UsuariosStoreBase with _$UsuariosStore;

abstract class _UsuariosStoreBase extends StoreBase with Store {
  _UsuariosStoreBase()
      : super(datatype: Usuario(), repository: UsuariosRepository());
}
