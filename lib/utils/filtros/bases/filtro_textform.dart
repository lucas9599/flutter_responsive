// ignore_for_file: sized_box_for_whitespace

import 'package:flutter_responsive/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive/utils/filtros/bases/filtro_textform_controller.dart';
import 'package:flutter_responsive/utils/telas/inputs/input.dart';
import 'package:flutter_responsive/utils/telas/inputs/input_inline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/constantes.dart';

class FiltroTextForm extends StatefulWidget {
  final String titulo;
  final String keyMap;
  final String campodescricao;
  final FiltroBase filtro;

  final FiltroTextFormController controller = FiltroTextFormController();
  FiltroTextForm({
    Key? key,
    required this.titulo,
    this.campodescricao = "descricao",
    required this.keyMap,
    required this.filtro,
    InputType inputType = InputType.text,
    String label = "Descrição",
  }) : super(key: key) {
    controller.inicializarVariaveis(
        campodescricao: campodescricao,
        label: label,
        filtro: filtro,
        keyMap: keyMap,
        inputType: inputType);
  }

  @override
  State<FiltroTextForm> createState() => _FiltroTextFormState();
}

class _FiltroTextFormState extends State<FiltroTextForm> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Builder(
        builder: (context) {
          return Container(
            height: !isTelaPequena(context)
                ? widget.filtro.juncao == TipoJuncao.between
                    ? 200
                    : 180
                : null,
            width: !isTelaPequena(context)
                ? widget.filtro.juncao == TipoJuncao.between
                    ? 500
                    : 400
                : null,
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.titulo),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    widget.filtro.juncao == TipoJuncao.between
                        ? InputInline(
                            colslg: 2,
                            colsmd: 2,
                            colssm: 1,
                            inputs: [
                              widget.controller.input,
                              widget.controller.input2!
                            ],
                          )
                        : widget.controller.input,
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              widget.controller.filtrar();
                            },
                            label: const Text("Filtrar"),
                            icon: const Icon(Icons.search),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
