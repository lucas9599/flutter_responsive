import 'package:flutter_responsive/utils/telas/store/store_base.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase extends StoreBase with Store {}
