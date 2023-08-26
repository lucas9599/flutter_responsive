import 'dart:convert';

import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_arvore_controller.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_arvore_no_controle.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

///Input Arvore
class InputArvore extends StatefulWidget implements IInput {
  InputArvore({Key? key, required this.name}) : super(key: key);
  @override
  final String name;
  final InputArvoreController controller = InputArvoreController();

  @override
  State<InputArvore> createState() => _InputArvoreState();

  @override
  Map<String, dynamic> getValue() {
    return {name: json.encode(controller.values)};
  }

  @override
  void setValue(Map<String, dynamic> values) {
    controller.add(json.decode(values[name]));
  }

  @override
  String get value => "";
}

class _InputArvoreState extends State<InputArvore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          widget.controller.values.length,
          (index) => _InputArvoreNo(
              name: widget.controller.values.keys.toList()[index],
              values: widget.controller.values.values.toList()[index]
                  ['permissoes'],
              descricao: widget.controller.values.values.toList()[index]
                  ['descricao'])),
    );
  }
}

class _InputArvoreNo extends StatefulWidget {
  _InputArvoreNo(
      {Key? key,
      required this.name,
      required this.values,
      required this.descricao})
      : super(key: key);
  final String name;
  final String descricao;
  final Map<String, dynamic> values;
  final InputArvoreNoController controller = InputArvoreNoController();

  @override
  State<_InputArvoreNo> createState() => __InputArvoreNoState();
}

class __InputArvoreNoState extends State<_InputArvoreNo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          widget.controller.mudarestado();
        },
        child: Container(
          color: Colors.grey[100],
          child: Row(
            children: [
              const Icon(Icons.folder),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(widget.descricao,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Observer(
                  builder: (_) => Icon(widget.controller.selecionado
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down))
            ],
          ),
        ),
      ),
      Observer(
        builder: (context) => Visibility(
          visible: widget.controller.selecionado,
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Colors.black))),
            child: Column(
              children: List.generate(widget.values.length, (index) {
                dynamic valor = widget.values.values.toList()[index];
                return InputCheckBox(
                    initialValue: valor['ativado'],
                    function: () {
                      valor['ativado'] = !valor['ativado'];
                    },
                    name: widget.values.keys.toList()[index],
                    label: valor['descricao']);
              }),
            ),
          ),
        ),
      ),
    ]);
  }
}
