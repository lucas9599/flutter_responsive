import 'package:mobx/mobx.dart';
part 'input_arvore_no_controle.g.dart';

///Controlador do no de um InputArvore
// ignore: library_private_types_in_public_api
class InputArvoreNoController = _InputArvoreNoControllerBase
    with _$InputArvoreNoController;

abstract class _InputArvoreNoControllerBase with Store {
  @observable
  bool selecionado = false;

  ///seleciona ou retira a seleção de um nó
  mudarestado() {
    selecionado = !selecionado;
  }
}
