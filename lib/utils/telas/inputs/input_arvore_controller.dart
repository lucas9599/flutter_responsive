///Controlador de um input no formato de arvore
class InputArvoreController {
  final Map<String, dynamic> _values = {};
  void add(Map<String, dynamic> values) {
    _values.clear();
    _values.addAll(values);
  }

  Map<String, dynamic> get values => _values;
}
