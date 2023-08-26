import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';
import 'package:flutter_responsive_template/utils/observables/carregando_widget.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/telas/extras/scrool.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/data_source.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/rota_filtros.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:data_table_2/data_table_2.dart';

class Body<Store extends StoreBase> extends StatefulWidget {
  final Widget? conteudo;
  final List<RotaFiltros> filtros;
  const Body({
    Key? key,
    this.conteudo,
    required this.filtros,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState<Store>();
}

class _BodyState<Store extends StoreBase> extends State<Body> {
  final store = Modular.get<Store>();
  final appcontroler = Modular.get<IAppController>();

  Color _adjustColorShade(Color color, int amount) {
    assert(amount >= -255 && amount <= 255);

    int red = color.red + amount;
    int green = color.green + amount;
    int blue = color.blue + amount;

    return Color.fromARGB(color.alpha, red.clamp(0, 255), green.clamp(0, 255),
        blue.clamp(0, 255));
  }

  Widget _chips(context, int tipo) {
    Widget chips = Observer(
      builder: (context) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: this
            .store
            .filtros
            .entries
            .map(
              (e) => Chip(
                label: Text(e.value.labelChip),
                onDeleted: () => this.store.removerChips(e.value),
              ),
            )
            .toList(),
      ),
    );
    return isTelaGrande(context) && tipo == 1
        ? chips
        : !isTelaGrande(context) && tipo == 2
            ? chips
            : Container();
  }

  @override
  Widget build(BuildContext context) {
    bool telaPequena = isTelaPequena(context);
    return Container(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width -
            (telaPequena ? 0 : (appcontroler.esconder ? 110 : 250)),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(telaPequena ? 30 : 5),
              topRight: Radius.circular(telaPequena ? 30 : 5)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.only(left: telaPequena ? 0 : 20, right: 20, top: 20),
        child: this.store.datatype != null
            ? Observer(
                builder: (context) => store.conexao == StatusConexao.carregando
                    ? const Column(
                        children: [CarregandoWidget()],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Visibility(
                                visible: rotaatual.isNotEmpty
                                    ? usuarioLogado?.permissoes?[rotaatual
                                                    .replaceAll("/", "")]
                                                ?['permissoes']?["incluir"]
                                            ?['ativado'] ??
                                        false
                                    : true,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          _adjustColorShade(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              -150))),
                                  onPressed: () {
                                    Modular.to
                                        .pushNamed("crud/", arguments: -1);
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Adicionar"),
                                ),
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    reverse: true,
                                    child: this._chips(context, 1),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  store.inicializar();
                                },
                                icon: const Icon(
                                  Icons.replay_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  store.imprimirListagem();
                                },
                                icon: const Icon(
                                  Icons.print,
                                  color: Colors.black,
                                ),
                              ),
                              Visibility(
                                visible: widget.filtros.isNotEmpty,
                                child: PopupMenuButton<RotaFiltros>(
                                  onSelected: (value) {
                                    this.store.filtrar(value);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return List.generate(
                                      widget.filtros.length,
                                      (index) => PopupMenuItem<RotaFiltros>(
                                        value: widget.filtros[index],
                                        child: Row(
                                          children: [
                                            Text(widget.filtros[index].label)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.search,
                                      color: Colors.black),
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(50, 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: this._chips(context, 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: telaPequena
                                ? ScrollConfiguration(
                                    behavior: MyCustomScrollBehavior(),
                                    child: Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 200),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: this.store.datatype!.card),
                                  )
                                : ScrollConfiguration(
                                    behavior: MyCustomScrollBehavior(),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 110),
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      child: Observer(
                                        builder: (context) => DataTable2(
                                          // rowsPerPage: 50,
                                          sortColumnIndex:
                                              this.appcontroler.indexsort,
                                          sortAscending:
                                              this.appcontroler.crescente,
                                          dataRowHeight: 30,

                                          columns: this.store.datatype!.colunas,
                                          rows: this.appcontroler.ordenacao ==
                                                  Sorting.normal
                                              ? DataSource(this.store.datatype)
                                                  .getRows()
                                              : [],
                                          // source:
                                          //   DataSource(this.store.datatype),
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
              )
            : widget.conteudo ?? Container(),
      ),
    );
  }
}
