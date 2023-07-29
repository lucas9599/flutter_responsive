import 'package:flutter_responsive/app/modules/perfis/perfis_store.dart';
import 'package:flutter_responsive/utils/telas/partes_tela/rota_filtros.dart';
import 'package:flutter_responsive/utils/telas/tela_desktop.dart';
import 'package:flutter/material.dart';

class PerfisPage extends TelaDesktopBase<PerfisStore> {
  PerfisPage({Key? key})
      : super(
            key: key,
            conteudo: () => const Text("Perfis"),
            title: "Manutenção de Perfis",
            filtros: [
              RotaFiltros(label: "Descrição", rota: "filtrardescricao"),
            ]);
}
