// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive_template/app/modules/perfis/perfis_repository.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_crud_base.dart';
import 'package:mobx/mobx.dart';

part 'crud_perfil_store.g.dart';

class CrudPerfilStore = _CrudPerfilStoreBase with _$CrudPerfilStore;

abstract class _CrudPerfilStoreBase extends StoreCrudBase with Store {
  _CrudPerfilStoreBase() : super(repository: PerfisRepository());
}
