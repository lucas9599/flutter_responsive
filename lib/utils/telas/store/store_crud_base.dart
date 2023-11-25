// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/repository/repository_base.dart';
import 'package:flutter_responsive_template/utils/telas/extras/padrao_erro.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_base.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'store_crud_base.g.dart';

///controlador basico para cruds
class StoreCrudBase = _StoreCrudBaseBase with _$StoreCrudBase;

abstract class _StoreCrudBaseBase extends Conexao with Store {
  final Repository repository;
  final Map<String, dynamic> dados = {};
  List<IInput>? inputs;

  ///pesquisa input pelo nome
  IInput? getInputForName(String name) {
    if (inputs != null) {
      for (int i = 0; i < inputs!.length; i++) {
        if (inputs![i].name == name) {
          return inputs![i];
        }
      }
    }
    return null;
  }

  int? id;
  String get latex => "";
  @observable
  int index = 0;

  _StoreCrudBaseBase({required this.repository}) {
    id = Modular.args.data;
    inicializar();
  }

  inicializar() async {
    try {
      conexao = StatusConexao.carregando;
      dados.clear();
      dados.addAll(await repository.getID(id!));
      conexao = StatusConexao.sucesso;

      conexao = StatusConexao.sucesso;
    } catch (ex) {
      conexao = StatusConexao.erro;
    }
  }

  ///Salva os dados
  salvar(Map<String, dynamic> dados) async {
    try {
      await repository.save(dados);
      Modular.get<StoreBase>(key: "tabela").inicializar();
      Modular.get<StoreBase>(key: "tabela").mensagemSucesso();
      Modular.to.pop();
    } on DioException catch (ex) {
      if ((ex.response!.statusCode ?? -1) == 401) {
        mensagemAviso(aviso: "Sessão expirada!favor fazer login novamente");
      } else {
        mensagemError(erro: PadraoErro(erroDio: ex).error);
      }
    } catch (ex) {
      mensagemError();
    }
  }

  void go(int index, tamanho) {
    if (index == -1 && this.index <= 0) {
      //  ddlog("it's first Step!");
      return;
    }

    if (index == 1 && this.index >= tamanho - 1) {
      // ddlog("it's last Step!");
      return;
    }

    this.index += index;
  }
}
