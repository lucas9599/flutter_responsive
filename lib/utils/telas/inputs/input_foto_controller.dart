// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'input_foto_controller.g.dart';

class InputFotoController = _InputFotoControllerBase with _$InputFotoController;

abstract class _InputFotoControllerBase with Store {
  @observable
  String foto = "";
}
