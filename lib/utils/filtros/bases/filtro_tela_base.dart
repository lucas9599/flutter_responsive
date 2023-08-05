// ignore_for_file: sized_box_for_whitespace

import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_controller.dart';
import 'package:flutter_responsive_template/utils/observables/carregando_widget.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/repository/chaves.dart';
import 'package:flutter_responsive_template/utils/telas/extras/scrool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

///Tela basica de Filtros
class FiltroTelaBase extends StatefulWidget {
  ///
  ///__dadosFixos__: Caso nao utilize uma api, passe somente dados fixos.
  ///
  ///__campodescricao__: Por padrão a classe busca o campo descrição para exibir o nome dos filtros.
  ///
  ///__keyMap__: Chave que sera usada no retorno do filtro. Por exemplo pode ter em uma tela
  ///dois tipos de filtros. Cada filtro é armazenado com uma chave diferente para enviar para api

  ///__filtro__: Padrão de formatação do filtro
  ///
  FiltroTelaBase(
      {Key? key,
      List<Map<String, dynamic>>? dadosfixos,
      required this.titulo,
      required this.endpoint,
      this.campodescricao = "descricao",
      required this.keyMap,
      required FiltroBase filtro,
      TipoApi tipoApi = TipoApi.normal,
      required bool isLookup})
      : super(key: key) {
    controller.inicializarVariaveis(
        endpoint: endpoint,
        campodescricao: campodescricao,
        filtro: filtro,
        isLookup: isLookup,
        tipoApi: tipoApi,
        dadosfixos: dadosfixos,
        keyMap: keyMap);
  }
  final String titulo;
  final String endpoint;
  final String campodescricao;
  final String keyMap;

  final FiltroController controller = FiltroController();

  @override
  State<FiltroTelaBase> createState() => _FiltroTelaBaseState();
}

class _FiltroTelaBaseState extends State<FiltroTelaBase> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Builder(
        builder: (context) {
          return Container(
            height: !isTelaPequena(context) ? 700 : null,
            width: !isTelaPequena(context) ? 500 : null,
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.titulo),
              ),
              body: Observer(
                builder: (context) => Column(
                  children: [
                    Container(
                      color: Colors.green,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: widget.controller.pesquisa,
                    ),
                    Expanded(
                      child: widget.controller.conexao ==
                              StatusConexao.carregando
                          ? const Column(children: [CarregandoWidget()])
                          : Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: ScrollConfiguration(
                                behavior: MyCustomScrollBehavior(),
                                child: ListView.builder(
                                    itemCount: widget.controller.dados.length,
                                    itemBuilder: (context, index) =>
                                        widget.controller.dados[index]),
                              ),
                            ),
                    ),
                    Visibility(
                      visible: !widget.controller.isLookup &&
                          widget.controller.selecionados.isNotEmpty,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 100,
                        width: double.infinity,
                        color: Colors.grey,
                        child: ScrollConfiguration(
                          behavior: MyCustomScrollBehavior(),
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              children: List.generate(
                                widget.controller.selecionados.length,
                                (index) => Chip(
                                  elevation: 6.0,
                                  shadowColor: Colors.grey[60],
                                  deleteIcon: const Icon(Icons.cancel_rounded),
                                  onDeleted: () => widget.controller.desmarcar(
                                      widget.controller.selecionados[index]),
                                  label: Text(widget
                                      .controller
                                      .dados[
                                          widget.controller.selecionados[index]]
                                      .label),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: !widget.controller.isLookup,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  widget.controller.filtrar();
                                },
                                icon: const Icon(Icons.search),
                                label: const Text("Filtrar"),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
