import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_tela_base.dart';
import 'package:flutter_responsive_template/utils/repository/chaves.dart';

//Filtro Padrão para Usuários
class FiltroUsuario extends FiltroTelaBase {
  FiltroUsuario({
    Key? key,
    String titulo = "Professor",
    String endpoint = "usuario",
    String keyMap = "usuarios",
    bool isLookup = false,
  }) : super(
            key: key,
            titulo: titulo,
            endpoint: endpoint,
            keyMap: keyMap,
            tipoApi: TipoApi.geral,
            filtro: FiltroBase(
              valor: [],
              coluna: "id_professor",
              labelChip: "Usuários",
            ),
            isLookup: isLookup);
}
