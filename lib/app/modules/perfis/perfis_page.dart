import 'package:flutter_responsive_template/app/modules/perfis/perfis_store.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/rota_filtros.dart';
import 'package:flutter_responsive_template/utils/telas/tela_base.dart';
import 'package:flutter/material.dart';

class PerfisPage extends TelaBase<PerfisStore> {
  PerfisPage({Key? key})
      : super(
            key: key,
            conteudo: () => const Text("Perfis"),
            title: "Manutenção de Perfis",
            filtros: [
              RotaFiltros(
                label: "Descrição",
                rota: "filtrardescricao",
              ),
            ]);
}
