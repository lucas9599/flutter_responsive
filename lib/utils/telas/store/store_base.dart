// ignore_for_file: unused_element, library_private_types_in_public_api

import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/rotas/mensagens.dart';
import 'package:flutter_responsive_template/utils/telas/datatable/data.dart';
import 'package:flutter_responsive_template/utils/repository/repository_base.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/rota_filtros.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';

part 'store_base.g.dart';

///classe basica para os controladores de tabelas
class StoreBase = _StoreBaseBase with _$StoreBase;

abstract class _StoreBaseBase extends Conexao with Store, Mensagens {
  final Dados? datatype;
  final Repository? repository;

  ObservableMap<String, FiltroBase> filtros =
      <String, FiltroBase>{}.asObservable();

  bool get isDatatable => true;

  _StoreBaseBase({this.datatype, this.repository}) {
    inicializar();
  }

  imprimirListagem() async {
    try {
      conexao = StatusConexao.carregando;

      await visualizadorDePDF(() async =>
          await repository!.gerarPDFListagem(filtros: filtros.values.toList()));

      conexao = StatusConexao.sucesso;
    } catch (ex) {
      conexao = StatusConexao.erro;
    }
  }

  inicializar() async {
    try {
      conexao = StatusConexao.carregando;
      if (repository != null && datatype != null) {
        datatype!.dados =
            await repository!.getAll(filtros: filtros.values.toList());
        conexao = StatusConexao.sucesso;
      }
      conexao = StatusConexao.sucesso;
    } on DioError catch (ex) {
      datatype!.dados = [];
      if ((ex.response?.statusCode ?? -1) == 401) {
        mensagemAviso(aviso: "Sessão expirada!Favor fazer novo login!");
      } else {
        mensagemError(erro: "Não Foi possivel carregar dados!");
      }
      conexao = StatusConexao.erro;
    } catch (ex) {
      datatype!.dados = [];
      mensagemError(erro: "Não Foi possivel carregar dados!");
      conexao = StatusConexao.erro;
    }
  }

  editar({required int id}) async {
    Modular.to.pushNamed("crud/", arguments: id);
  }

  removerChips(FiltroBase e) {
    filtros.removeWhere((key, value) => value == e);
    inicializar();
  }

  delete({required int id, bool confirmacao = true}) async {
    dynamic resposta = confirmacao
        ? await openDialogoConfirmacao(mensagem: "Excluir registro?")
        : true;
    if (resposta ?? false) {
      try {
        await repository!.delete(id);
        mensagemSucesso();
        inicializar();
      } on DioError catch (ex) {
        datatype!.dados = [];
        if ((ex.response?.statusCode ?? -1) == 401) {
          mensagemAviso(aviso: "Sessão expirada!Favor fazer novo login!");
        } else {
          mensagemError();
        }
        conexao = StatusConexao.erro;
      } catch (ex) {
        datatype!.dados = [];
        mensagemError();
        conexao = StatusConexao.erro;
      }
    }
  }

  filtrar(RotaFiltros value) async {
    final resposta = await Modular.to
        .pushNamed((value.isInAppModule ? "/" : "") + value.rota);
    if (resposta != null) {
      inicializar();
    }
  }
}
