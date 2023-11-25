import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/app/modules/perfis/crud/crud_perfil_store.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/crud_base.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_arvore.dart';

class CrudPerfilPage extends CrudBase<CrudPerfilStore> {
  CrudPerfilPage({Key? key})
      : super(
          key: key,
          height: 700,
          width: 600,
          inputs: [
            Input(
              name: "id",
              label: "Id",
              isPrimaryKey: true,
            ),
            Input(
              label: "Id Sistema",
              name: "id_sistema",
              visible: false,
            ),
            Input(
              label: "id_permissao",
              name: "id_permissao",
              valorinicial: "-1",
              visible: false,
            ),
            Input(name: "descricao", label: "Descricão", obrigatorio: true),
            InputArvore(name: "permissao")
          ],
          title: "Perfis",
        );
}
