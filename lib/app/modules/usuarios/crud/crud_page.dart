import 'package:flutter/material.dart';
import 'package:flutter_responsive/app/modules/usuarios/crud/crud_store.dart';
import 'package:flutter_responsive/utils/telas/inputs/form_generator.dart';
import 'package:flutter_responsive/utils/telas/inputs/input.dart';
import 'package:flutter_responsive/utils/telas/inputs/input_checkbox.dart';
import 'package:flutter_responsive/utils/telas/inputs/input_foto.dart';
import 'package:flutter_responsive/utils/telas/inputs/input_combobox.dart';

class CrudPage extends FormGenerator<CrudStore> {
  CrudPage({Key? key})
      : super(
            key: key,
            inputs: [
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
              Input(
                name: "email",
                label: "Email",
                obrigatorio: true,
              ),
              Input(name: "senha", label: "Senha", obscureText: true),
              InputCheckBox(name: "admin", label: "Administrador"),
              InputComboBox(
                name: "id_perfil",
                label: "Perfil",
                tabela: "servidor_perfil",
              ),
              InputFoto(name: "foto", label: "Foto"),
            ],
            title: "Usuários",
            tuples: [],
            qtdInputsPorStep: [],
            height: 700,
            width: 500);
}
