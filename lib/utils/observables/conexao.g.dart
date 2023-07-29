// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conexao.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Conexao on _ConexaoBase, Store {
  late final _$mensegemAtom =
      Atom(name: '_ConexaoBase.mensegem', context: context);

  @override
  Mensagem get mensegem {
    _$mensegemAtom.reportRead();
    return super.mensegem;
  }

  @override
  set mensegem(Mensagem value) {
    _$mensegemAtom.reportWrite(value, super.mensegem, () {
      super.mensegem = value;
    });
  }

  late final _$textoMensagemAtom =
      Atom(name: '_ConexaoBase.textoMensagem', context: context);

  @override
  String get textoMensagem {
    _$textoMensagemAtom.reportRead();
    return super.textoMensagem;
  }

  @override
  set textoMensagem(String value) {
    _$textoMensagemAtom.reportWrite(value, super.textoMensagem, () {
      super.textoMensagem = value;
    });
  }

  late final _$porcentagemmensagemAtom =
      Atom(name: '_ConexaoBase.porcentagemmensagem', context: context);

  @override
  double get porcentagemmensagem {
    _$porcentagemmensagemAtom.reportRead();
    return super.porcentagemmensagem;
  }

  @override
  set porcentagemmensagem(double value) {
    _$porcentagemmensagemAtom.reportWrite(value, super.porcentagemmensagem, () {
      super.porcentagemmensagem = value;
    });
  }

  late final _$conexaoAtom =
      Atom(name: '_ConexaoBase.conexao', context: context);

  @override
  StatusConexao get conexao {
    _$conexaoAtom.reportRead();
    return super.conexao;
  }

  @override
  set conexao(StatusConexao value) {
    _$conexaoAtom.reportWrite(value, super.conexao, () {
      super.conexao = value;
    });
  }

  @override
  String toString() {
    return '''
mensegem: ${mensegem},
textoMensagem: ${textoMensagem},
porcentagemmensagem: ${porcentagemmensagem},
conexao: ${conexao}
    ''';
  }
}
