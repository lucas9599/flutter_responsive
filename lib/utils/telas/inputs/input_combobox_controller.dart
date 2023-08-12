// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'input_combobox_controller.g.dart';

///Controlador do InputComboBox
class InputComboboxController = _InputComboboxControllerBase
    with _$InputComboboxController;

abstract class _InputComboboxControllerBase with Store {
  @observable
  String? valor;
}
