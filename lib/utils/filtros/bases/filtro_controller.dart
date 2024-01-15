import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/repository/chaves.dart';
import 'package:flutter_responsive_template/utils/repository/repository_base.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_checkbox.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'filtro_controller.g.dart';

///__Controlador de Filtro Basico__
// ignore: library_private_types_in_public_api
class FiltroController = _FiltroControllerBase with _$FiltroController;

abstract class _FiltroControllerBase extends Conexao with Store {
  bool isLookup = false;
  ObservableList<int> selecionados = <int>[].asObservable();
  ObservableList<InputCheckBox> dados = <InputCheckBox>[].asObservable();
  String? rotacrud;
  late String endpoint;
  late FiltroBase filtro;
  late String keyMap;
  late String campodescricao;
  late TipoApi tipoApi;
  List<FiltroBase> filtros = [];
  List<Map<String, dynamic>>? dadosfixos;
  _FiltroControllerBase() {
    pesquisa = Input(
      name: "PESQUISA",
      label: "Pesquisa",
      prefixIcon: Icons.search,
      border: const OutlineInputBorder(),
      fillColor: Colors.white,
      filled: true,
      onChanged: (descricao) => pesquisar(descricao),
    );
  }

  selecionar(int index) {
    if (isLookup) {
      dados[index].controller.selecionado = false;
      Modular.to.pop({
        "id": int.parse(
          dados[index].name,
        ),
        "descricao": dados[index].label
      });
    } else {
      if (dados[index].controller.selecionado) {
        selecionados.removeWhere((element) => element == index);
      } else {
        selecionados.add(index);
      }
    }
  }

  desmarcar(int index) {
    dados[index].controller.selecionado = false;
    selecionados.removeWhere((element) => element == index);
  }

  late Input pesquisa;
  inicializarVariaveis(
      {required String endpoint,
      required String campodescricao,
      required FiltroBase filtro,
      String? rotacrud,
      TipoApi tipoApi = TipoApi.normal,
      bool isLookup = false,
      List<Map<String, dynamic>>? dadosfixos,
      required String keyMap}) {
    this.filtro =
        Modular.get<StoreBase>(key: "tabela").filtros[keyMap] ?? filtro;
    this.isLookup = isLookup;
    this.keyMap = keyMap;
    this.tipoApi = tipoApi;
    this.campodescricao = campodescricao;
    this.endpoint = endpoint;
    this.dadosfixos = dadosfixos;
    this.rotacrud = rotacrud;
    if (!this.isLookup) {
      inicializar();
    }
  }

  pesquisarid({required List<int> valor}) async {
    Repository repository =
        Repository(endpoint, campoDescricao: campodescricao, tipoApi: tipoApi);
    List<FiltroBase> f = [FiltroBase(valor: valor, coluna: "id")];
    if (filtros.isNotEmpty) {
      f.addAll(filtros);
    }
    final resposta = await repository.getAll(filtros: f);
    if (resposta.isNotEmpty) {
      return resposta.first;
    }
  }

  atualizar() async {
    await Modular.to.pushNamed(
        "$rotacrud${rotacrud!.endsWith("/") ? "" : "/"}crud",
        arguments: -1);
    inicializar(filtros: filtros);
  }

  inicializar({
    List<FiltroBase>? filtros,
  }) async {
    try {
      filtros = filtros ?? [];
      conexao = StatusConexao.carregando;
      Repository repository = Repository(endpoint,
          isLista: true, campoDescricao: campodescricao, tipoApi: tipoApi);
      List res = dadosfixos ?? await repository.getAll(filtros: filtros);
      dados.clear();
      for (int i = 0; i < res.length; i++) {
        dados.add(InputCheckBox(
          name: res[i]['id'].toString(),
          label: res[i]['descricao'] ?? res[i][campodescricao],
          function: () => selecionar(i),
        ));
      }
      for (int i = 0; i < dados.length; i++) {
        if (filtro.valor.contains(int.parse(dados[i].name))) {
          selecionar(i);
          dados[i].controller.selecionado = true;
        }
      }
      conexao = StatusConexao.sucesso;
    } catch (ex) {
      conexao = StatusConexao.sucesso;
    }
  }

  pesquisar(String descricao) {
    for (var element in dados) {
      element.controller.visible =
          element.label.toUpperCase().contains(descricao.toUpperCase()) ||
              descricao.isEmpty;
    }
  }

  filtrar() {
    filtro.valor.clear();
    for (int i = 0; i < selecionados.length; i++) {
      filtro.valor.add(int.parse(dados[selecionados[i]].name));
    }
    StoreBase store = Modular.get<StoreBase>(key: "tabela");

    if (filtro.valor.isNotEmpty) {
      store.filtros.addAll({keyMap: filtro});
    } else {
      store.filtros.removeWhere((key, value) => key == keyMap);
    }

    Modular.to.pop(true);
  }
}
