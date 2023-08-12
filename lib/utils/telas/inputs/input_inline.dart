import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter/material.dart';

///É possivel configurar a quantidade de inputs em uma linha em tres resoluções. MD (médio), SM (pequena), LG(grande)
class InputInline extends StatefulWidget implements IInput {
  ///__colslg__: Quantidade de inputs em tela grande
  ///
  ///__colsmd__: Quantidade de Inputs em uma tela média
  ///
  ///__colssm__: Quantidade de Inputs em uma tela pequena
  const InputInline({
    Key? key,
    required this.inputs,
    this.colslg,
    this.colsmd,
    this.colssm,
  }) : super(key: key);
  final List<IInput> inputs;
  final int? colsmd;
  final int? colssm;
  final int? colslg;

  @override
  State<InputInline> createState() => _InputInlineState();

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

class _InputInlineState extends State<InputInline> {
  List<Widget> processarResulocao() {
    List<Widget> res = [];
    int etapa = isTelaPequena(context)
        ? (widget.colssm ?? 0)
        : isTelaMedia(context)
            ? (widget.colsmd ?? 0)
            : (widget.colslg ?? 0);
    int i = 0;
    if (etapa == 0) {
      res.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(widget.inputs.length,
              (index) => Expanded(child: widget.inputs[index]))));
    } else {
      while (i < widget.inputs.length) {
        if (i + etapa < widget.inputs.length) {
          List<Widget> sublist = widget.inputs.sublist(i, i + etapa);
          res.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                sublist.length,
                (index) => Expanded(
                  child: sublist[index],
                ),
              ),
            ),
          );
        } else {
          List<Widget> sublist = widget.inputs.sublist(i, widget.inputs.length);
          res.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                sublist.length,
                (index) => Expanded(
                  child: sublist[index],
                ),
              ),
            ),
          );
        }
        i = i + etapa;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> linhas = processarResulocao();
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(linhas.length, (index) => linhas[index]));
  }
}
