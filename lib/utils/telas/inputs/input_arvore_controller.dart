///Controllador do input arvore
class InputArvoreController {
  final Map<String, dynamic> _values = {};
  add(Map<String, dynamic> values) {
    _values.clear();
    _values.addAll(values);
  }

  Map<String, dynamic> get values => _values;
}
