import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_tela_base.dart';

class FiltrarPerfil extends FiltroTelaBase {
  FiltrarPerfil({
    Key? key,
    String titulo = "Perfil",
    String endpoint = "servidor_perfil",
    String keyMap = "perfil",
    bool isLookup = false,
  }) : super(
          key: key,
          titulo: titulo,
          endpoint: endpoint,
          keyMap: keyMap,
          rotacrud: "/perfis/",
          filtro:
              FiltroBase(valor: [], labelChip: "Perfis", coluna: "id_perfil"),
          isLookup: isLookup,
        );
}
