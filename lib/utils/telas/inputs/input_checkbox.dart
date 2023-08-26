import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_chekbox_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

///Input Check bok
class InputCheckBox extends StatefulWidget implements IInput {
  @override
  final String name;
  final String label;
  final Function? function;
  final bool initialValue;
  final ControllerCheckBox controller = ControllerCheckBox();
  final Color? fillColor;
  final bool? filled;

  InputCheckBox({
    Key? key,
    required this.name,
    required this.label,
    this.fillColor,
    this.filled,
    this.function,
    this.initialValue = false,
  }) : super(key: key) {
    controller.selecionado = initialValue;
  }

  @override
  State<InputCheckBox> createState() => _InputCheckBoxState();

  @override
  Map<String, dynamic> getValue() {
    return {name: controller.selecionado};
  }

  @override
  void setValue(Map<String, dynamic> values) {
    controller.selecionado = values[name] ?? initialValue;
  }

  @override
  String get value => controller.selecionado.toString();
}

class _InputCheckBoxState extends State<InputCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Visibility(
        visible: widget.controller.visible,
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: widget.controller.selecionado,
          onChanged: (value) {
            if (widget.function != null) {
              widget.function!();
            }
            widget.controller.marcarDesmarcar();
          },
          title: Text(widget.label),
        ),
      ),
    );
  }
}
