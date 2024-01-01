import 'package:mobx/mobx.dart';
part 'input_dados_controller.g.dart';

// ignore: library_private_types_in_public_api
class InputDadosController = _InputDadosControllerBase
    with _$InputDadosController;

abstract class _InputDadosControllerBase with Store {
  final ObservableList<Map<String, dynamic>> dados =
      <Map<String, dynamic>>[].asObservable();
  bool inicializado = false;

  inicializar(Map<String, dynamic> values, String name) {
    if (values[name] != null) {
      List<Map<String, dynamic>> a =
          List<Map<String, dynamic>>.from(values[name]);
      if (!inicializado) {
        dados.addAll(a);
        inicializado = true;
      }
    }
  }
}
