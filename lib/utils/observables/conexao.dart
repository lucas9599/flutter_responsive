// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'conexao.g.dart';

enum StatusConexao { carregando, sucesso, erro }

enum Mensagem { sucesso, erro, aviso, semmensagem }

///Gerencia o estado da comunicação com a api
class Conexao = _ConexaoBase with _$Conexao;

abstract class _ConexaoBase with Store {
  @observable
  Mensagem mensegem = Mensagem.semmensagem;
  @observable
  String textoMensagem = "";
  @observable
  double porcentagemmensagem = 0;

  @observable
  StatusConexao conexao = StatusConexao.carregando;

  Future<void> mensagemSucesso(
      {String sucesso = "Sucesso, operação realizada com sucesso!"}) async {
    porcentagemmensagem = 0;
    mensegem = Mensagem.sucesso;
    textoMensagem = sucesso;
    for (int i = 0; i < 10; i++) {
      porcentagemmensagem = i / 10;
      await Future.delayed(const Duration(milliseconds: 200));
    }
    mensegem = Mensagem.semmensagem;
  }

  Future<void> mensagemError(
      {String erro = "Erro, operação não pode ser realizada!"}) async {
    porcentagemmensagem = 0;
    mensegem = Mensagem.erro;
    textoMensagem = erro;
    for (int i = 0; i < 10; i++) {
      porcentagemmensagem = i / 10;
      await Future.delayed(const Duration(milliseconds: 200));
    }
    mensegem = Mensagem.semmensagem;
  }

  Future<void> mensagemAviso({String aviso = "Atenção"}) async {
    porcentagemmensagem = 0;
    mensegem = Mensagem.aviso;
    textoMensagem = aviso;
    for (int i = 0; i < 10; i++) {
      porcentagemmensagem = i / 10;
      await Future.delayed(const Duration(milliseconds: 200));
    }
    mensegem = Mensagem.semmensagem;
  }
}
