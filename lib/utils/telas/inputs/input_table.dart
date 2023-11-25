import 'dart:convert';

import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_lookup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class InputTable extends StatefulWidget implements IInput {
  InputTable(
      {Key? key, required this.name, required this.label, required this.input})
      : super(key: key);
  final ObservableList<Map<String, dynamic>> dados =
      <Map<String, dynamic>>[].asObservable();
  @override
  final String name;
  final String label;
  final InputLookup input;

  @override
  State<InputTable> createState() => _InputTableState();

  @override
  Map<String, dynamic> getValue() {
    return {name: dados.toList()};
  }

  @override
  void setValue(Map<String, dynamic> values) {
    if (values[name] != null) {
      List<Map<String, dynamic>> a =
          List<Map<String, dynamic>>.from(values[name]);
      if (dados.isEmpty) {
        dados.addAll(a);
      }
    }
  }

  @override
  String get value => json.encode(dados.toList());

  @override
  clean() {
    dados.clear();
  }
}

class _InputTableState extends State<InputTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: widget.input,
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> v = widget.input.getValue();
                if (widget.dados.isNotEmpty) {
                  for (int i = 0; i < widget.dados.length; i++) {
                    if (widget.dados[i]['id'] == widget.input.value) {
                      return;
                    }
                  }
                }
                widget.dados.add(v[widget.name]);
              },
              child: const Text("Adicionar"),
            ),
          ],
        ),
        Observer(
          builder: (context) => DataTable(
            columns: const [
              DataColumn(label: Text("Nome")),
              DataColumn(label: Text("Ação"))
            ],
            rows: List.generate(
              widget.dados.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text(widget.dados[index]['descricao'])),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => widget.dados.removeAt(index),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
