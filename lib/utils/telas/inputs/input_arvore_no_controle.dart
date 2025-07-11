import 'package:mobx/mobx.dart';
part 'input_arvore_no_controle.g.dart';

///Input Arvore
// ignore: library_private_types_in_public_api
class InputArvoreNoController = _InputArvoreNoControllerBase
    with _$InputArvoreNoController;

abstract class _InputArvoreNoControllerBase with Store {
  @observable
  bool selecionado = false;

  void mudarestado() {
    selecionado = !selecionado;
  }
}
