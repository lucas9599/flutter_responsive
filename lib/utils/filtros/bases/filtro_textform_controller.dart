// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive/utils/telas/inputs/input.dart';
import 'package:flutter_responsive/utils/telas/store/store_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'filtro_textform_controller.g.dart';

class FiltroTextFormController = _FiltroTextFormControllerBase
    with _$FiltroTextFormController;

abstract class _FiltroTextFormControllerBase with Store {
  late Input input;
  Input? input2;
  late String keyMap;

  late FiltroBase filtro;
  late String campodescricao;
  inicializarVariaveis(
      {required String campodescricao,
      required FiltroBase filtro,
      required InputType inputType,
      required String label,
      required String keyMap}) {
    // ignore: unnecessary_this
    this.input = Input(
      name: "DESCRICAO",
      label: label + (filtro.juncao == TipoJuncao.between ? ' 1' : ''),
      inputType: inputType,
    );
    if (filtro.juncao == TipoJuncao.between) {
      input2 = Input(
        name: "DESCRICAO",
        label: "$label 2",
        inputType: inputType,
      );
    }
    this.filtro = Modular.get<StoreBase>().filtros[keyMap] ?? filtro;

    if (this.filtro.valor.isNotEmpty) {
      input.setValue(
          {"DESCRICAO": _pegarValor(this.filtro.valor[0].toString())});
      if (input2 != null && this.filtro.valor.length == 2) {
        input2!.setValue(
            {"DESCRICAO": _pegarValor(this.filtro.valor[1].toString())});
      }
    }

    this.keyMap = keyMap;
    this.campodescricao = campodescricao;
  }

  String _pegarValor(String valor) {
    if (input.inputType == InputType.date) {
      List value = valor.split("-");
      return value.length == 3
          ? value[2] + "/" + value[1] + "/" + value[0]
          : "";
    }
    return valor;
  }

  bool _formatarFiltro(Input i) {
    String s = "";
    if (i.value.isNotEmpty) {
      if (i.inputType == InputType.date) {
        if (i.validar()) {
          List value = i.value.split("/");
          s = value[2] + "-" + value[1] + "-" + value[0];
        }
      } else {
        s = i.value;
      }
    }
    if (s.isNotEmpty) {
      filtro.valor.add(s);
      return true;
    }
    return false;
  }

  filtrar() {
    StoreBase store = Modular.get<StoreBase>();

    if (input.value.isNotEmpty && (input2?.value.isNotEmpty ?? true)) {
      bool resposta = _formatarFiltro(input);

      if (resposta && input2 != null) {
        _formatarFiltro(input2!);
      }
      if (resposta) {
        store.filtros.addAll({keyMap: filtro});
      } else {
        store.openMensagem(const Text("Valor Invalido"));
      }
    } else {
      store.filtros.removeWhere((key, value) => key == keyMap);
    }

    Modular.to.pop(true);
  }
}
