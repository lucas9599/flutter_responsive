import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_store.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/rota_filtros.dart';
import 'package:flutter_responsive_template/utils/telas/tela_desktop.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends TelaDesktopBase<UsuariosStore> {
  UsuariosPage({Key? key})
      : super(
            key: key,
            conteudo: () => const Text("Usuários"),
            title: "Manutenção de Usuários",
            filtros: [
              RotaFiltros(label: "Descrição", rota: "filtrardescricao"),
            ]);
}
