// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'controller_menu.g.dart';

///Controlador de menu
class ControllerMenu = _ControllerMenuBase with _$ControllerMenu;

abstract class _ControllerMenuBase with Store {
  @observable
  bool espandido = true;
  @action
  void selecionar() {
    espandido = !espandido;
  }
}
