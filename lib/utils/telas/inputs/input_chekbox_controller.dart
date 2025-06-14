// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'input_chekbox_controller.g.dart';

class ControllerCheckBox = _ControllerCheckBoxBase with _$ControllerCheckBox;

abstract class _ControllerCheckBoxBase with Store {
  @observable
  bool selecionado = false;
  void marcarDesmarcar() {
    selecionado = !selecionado;
  }

  @observable
  bool visible = true;
}
