import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter/material.dart';

///Gerencia a alocação de varios inputs em varias linhas de acordo com a resolução
///
///__atenção sempre use dentro de um input inline__
class InputInColunm extends StatefulWidget implements IInput {
  const InputInColunm({
    Key? key,
    required this.inputs,
  }) : super(key: key);
  final List<IInput> inputs;

  @override
  State<InputInColunm> createState() => _InputInColunmState();

  @override
  Map<String, dynamic> getValue() {
    Map<String, dynamic> values = {};
    for (int i = 0; i < inputs.length; i++) {
      values.addAll(inputs[i].getValue());
    }
    return values;
  }

  @override
  String get name => "";

  @override
  void setValue(Map<String, dynamic> values) {
    for (int i = 0; i < inputs.length; i++) {
      inputs[i].setValue(values);
    }
  }

  @override
  String get value => "";
}

class _InputInColunmState extends State<InputInColunm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.inputs.length,
              (index) => (widget.inputs[index]),
            ),
          ),
        ),
      ],
    );
  }
}
