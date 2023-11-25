import 'dart:convert';

import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

///Grava dados com associação @oneToMany
class InputDados extends StatefulWidget implements IInput {
  ///linhas: Linhas que aparecera no datatable
  ///colunas: Colunas que aparecera no datatable
  InputDados({
    Key? key,
    required this.name,
    required this.label,
    required this.linhas,
    required this.input,
    required this.colunas,
    this.identificador,
  }) : super(key: key);
  final ObservableList<Map<String, dynamic>> dados =
      <Map<String, dynamic>>[].asObservable();
  @override
  final String name;
  final String label;
  final IInput input;
  final String Function(Map<String, dynamic> dados)? identificador;
  final List<DataCell> Function(Map<String, dynamic> dados) linhas;
  final List<DataColumn> Function() colunas;

  @override
  State<InputDados> createState() => _InputDadosState();

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

class _InputDadosState extends State<InputDados> {
  List<DataCell> _linhas(Map<String, dynamic> dados, int index) {
    List<DataCell> celulas = widget.linhas(dados);
    celulas.add(
      DataCell(
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => widget.dados.removeAt(index),
        ),
      ),
    );

    return celulas;
  }

  List<DataColumn> _colunas() {
    List<DataColumn> colunas = widget.colunas();
    colunas.add(const DataColumn(label: Text("Ação")));
    return colunas;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            widget.input,
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> v = widget.input.getValue();
                if (widget.dados.isNotEmpty) {
                  if (widget.identificador != null) {
                    for (int i = 0; i < widget.dados.length; i++) {
                      if (widget.identificador!(widget.dados[i]) ==
                          widget.identificador!(v)) {
                        return;
                      }
                    }
                  }
                }
                widget.dados.add(v);
                widget.input.clean();
              },
              child: const Text("Adicionar"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(thickness: 1),
            Observer(
              builder: (context) => DataTable(
                columns: _colunas(),
                rows: List.generate(
                  widget.dados.length,
                  (index) =>
                      DataRow(cells: _linhas(widget.dados[index], index)),
                ),
              ),
            ),
          ],
        ));
  }
}
