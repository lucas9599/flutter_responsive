// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

enum Sorting {
  normal,
  ordenando,
}

///Atenção o app controller tem que extender dessa classe
class IAppController = _IAppControllerBase with _$IAppController;

abstract class _IAppControllerBase extends Conexao with Store {
  @observable
  bool esconder = false;

  @observable
  bool crescente = false;

  @observable
  int indexsort = 1;

  @observable
  int index = 0;

  int indexMenuTemporario = 0;

  @observable
  Sorting ordenacao = Sorting.normal;

  @action
  sorting({required Function ordernador, required int index}) {
    crescente = !crescente;
    indexsort = index;
    ordenacao = Sorting.ordenando;
    ordernador();
    ordenacao = Sorting.normal;
  }

  @action
  escondermenu() {
    esconder = !esconder;
  }
}
