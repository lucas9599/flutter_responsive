// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive/app/modules/usuarios/usuarios_repository.dart';
import 'package:flutter_responsive/utils/telas/store/store_crud_base.dart';
import 'package:mobx/mobx.dart';

part 'crud_store.g.dart';

class CrudStore = _CrudStoreBase with _$CrudStore;

abstract class _CrudStoreBase extends StoreCrudBase with Store {
  @observable
  int value = 0;

  _CrudStoreBase() : super(repository: UsuariosRepository());

  @action
  void increment() {
    value++;
  }
}
