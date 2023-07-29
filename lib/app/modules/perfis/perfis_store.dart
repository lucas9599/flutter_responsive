// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive/model/perfis.dart';
import 'package:flutter_responsive/app/modules/perfis/perfis_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_responsive/utils/telas/store/store_base.dart';
part 'perfis_store.g.dart';

class PerfisStore = _PerfisStoreBase with _$PerfisStore;

abstract class _PerfisStoreBase extends StoreBase with Store {
  _PerfisStoreBase()
      : super(datatype: Perfis(), repository: PerfisRepository());
}
