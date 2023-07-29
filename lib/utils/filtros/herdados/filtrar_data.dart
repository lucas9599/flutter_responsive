import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_textform.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input.dart';

class FiltrarData extends FiltroTextForm {
  FiltrarData(
      {Key? key,
      String titulo = "Filtrar Data",
      String keyMap = "data",
      String coluna = "data",
      TipoJuncao juncao = TipoJuncao.iquals})
      : super(
          key: key,
          label: "Data",
          titulo: titulo,
          keyMap: keyMap,
          inputType: InputType.date,
          filtro: FiltroBase(
            valor: [],
            coluna: coluna,
            labelChip: "Data",
            juncao: juncao,
          ),
        );
}
