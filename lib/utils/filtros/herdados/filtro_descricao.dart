import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_textform.dart';

class FiltroDescricao extends FiltroTextForm {
  FiltroDescricao(
      {Key? key,
      String titulo = "Filtrar Descrição",
      String keyMap = "descricao",
      TipoJuncao juncao = TipoJuncao.like})
      : super(
          key: key,
          titulo: titulo,
          keyMap: keyMap,
          filtro: FiltroBase(
            valor: [],
            labelChip: "Descricão",
            coluna: "descricao",
            juncao: juncao,
          ),
        );
}
