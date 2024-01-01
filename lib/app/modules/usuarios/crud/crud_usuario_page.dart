import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/crud/crud_usuario_store.dart';
import 'package:flutter_responsive_template/utils/filtros/herdados/filtrar_perfil.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/crud_base.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_checkbox.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_dados.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_foto.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_incolumn.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_inline.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_lookup.dart';

///Crud Basica dos usuarios
class CrudUsuarioPage extends CrudBase<CrudUsuarioStore> {
  CrudUsuarioPage({Key? key})
      : super(
          key: key,
          inputs: [
            InputInline(colslg: 2, colssm: 1, colsmd: 2, inputs: [
              InputInColunm(inputs: [
                Input(
                  name: "id",
                  label: "ID",
                  isPrimaryKey: true,
                ),
                Input(
                  name: "descricao",
                  label: "Nome Completo",
                  obrigatorio: true,
                ),
                Input(
                  name: "usuario",
                  label: "Usuario",
                  obrigatorio: true,
                ),
                Input(
                  name: "id_sistema",
                  label: "id_sistema",
                  valorinicial: "1",
                  visible: false,
                ),
                InputCheckBox(name: "admin", label: "Administrador"),
              ]),
              InputFoto(name: "foto", label: "Foto"),
            ]),
            Input(
              name: "email",
              label: "Email",
              obrigatorio: true,
            ),
            Input(name: "senha", label: "Senha", obscureText: true),
            InputLookup(
              name: "id_perfil",
              label: "Perfil",
              obrigatorio: true,
              telaPesquisa: FiltrarPerfil(isLookup: true),
            ),
            /*
            InputDados(
              name: "dados",
              label: "Ddos",
              linhas: (dados) => [
                DataCell(
                  Text(dados['perfil']['id'].toString()),
                ),
                DataCell(Text(dados['perfil']['descricao']))
              ],
              identificador: ((dados) => dados['perfil']['id']),
              input: InputLookup(
                name: "perfil",
                label: "Perfil",
                telaPesquisa: FiltrarPerfil(isLookup: true),
              ),
              colunas: () => [
                const DataColumn(label: Text("ID")),
                const DataColumn(label: Text("Descricao"))
              ],
            )*/
          ],
          title: "Usuários",
          height: 700,
          width: 500,
        );
}
