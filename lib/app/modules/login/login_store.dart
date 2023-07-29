// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_responsive_template/model/usuario.dart';

import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/app/modules/login/login_repository.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/repository/error.dart';
import 'package:flutter_responsive_template/utils/rotas/mensagens.dart';
import 'package:flutter_responsive_template/utils/telas/extras/config.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase extends Conexao with Store, Mensagens {
  _LoginStoreBase() {
    inicializar();
  }

  final ip = Input(name: "ip", label: "Servidor");
  final porta = Input(name: "porta", label: "Porta");

  openConfiguracao() {
    ip.controller.text = ipservidor;
    porta.controller.text = portaservidor;
    openMensagem(
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ip,
                porta,
                Expanded(child: Container()),
                Row(children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Config.gravarConfiguracao(
                            ip: ip.controller.text,
                            porta: porta.controller.text);
                        Modular.to.pop();
                      },
                      label: const Text(
                        "Salvar",
                      ),
                      icon: const Icon(
                        Icons.save,
                      ),
                    ),
                  ),
                ]),
              ]),
        ),
        height: 250,
        width: 150);
  }

  final Input senha = Input(
      name: "senha",
      label: "Senha",
      obscureText: true,
      prefixIcon: Icons.password_rounded,
      filled: true,
      onChanged: (p0) {
        Modular.get<LoginStore>().mensagem = "";
      },
      fillColor: Colors.white54,
      style: TextStyle(color: Colors.green[900]),
      labelStyle: TextStyle(color: Colors.green[900]),
      border: OutlineInputBorder(
          borderSide: const BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(10)));
  final Input email = Input(
      name: "email",
      label: "Email",
      filled: true,
      prefixIcon: Icons.email,
      fillColor: Colors.white54,
      style: TextStyle(color: Colors.green[900]),
      labelStyle: TextStyle(color: Colors.green[900]),
      onChanged: (p0) {
        Modular.get<LoginStore>().mensagem = "";
      },
      border: OutlineInputBorder(
          borderSide: const BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(10)));

  final InputCheckBox salvar = InputCheckBox(
    name: "SALVAR",
    label: "Salvar email e senha",
  );

  inicializar() async {
    conexao = StatusConexao.carregando;
    final config = await Config.getConfiguracao();
    ipservidor = config?['ip'] ?? "127.0.0.1";
    portaservidor = config?['porta'] ?? "8080";
    try {
      Map<String, dynamic>? dados = await Config.getUsuario();
      if (dados != null) {
        senha.setValue(dados);
        email.setValue(dados);
        salvar.controller.selecionado = true;
      }
    } finally {
      conexao = StatusConexao.sucesso;
    }
  }

  @observable
  String mensagem = "";

  Future login() async {
    try {
      mensagem = "Fazendo login, aguarde...";
      conexao = StatusConexao.carregando;
      Usuario u = Usuario(
        email: email.value,
        senha: senha.value,
      );
      LoginRepository repository = LoginRepository();
      bool resposta = await repository.login(u);
      if (resposta) {
        if (salvar.controller.selecionado) {
          Config.gravarUsuario(email: email.value, senha: senha.value);
        } else {
          Config.excluirusuario();
        }
        usuarioLogado = u;
        conexao = StatusConexao.sucesso;
        Modular.to.navigate("/home/");
      }
      conexao = StatusConexao.sucesso;
      mensagem = "Usuário ou senha inválidos!";
    } on Exception catch (ex) {
      conexao = StatusConexao.sucesso;
      mensagem = ErrorConexao(exception: ex).mensagem;
    }
  }
}
