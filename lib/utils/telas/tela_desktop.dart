import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';
import 'package:flutter_responsive_template/utils/telas/extras/scrool.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_lateral.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/body.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/header.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/posicioned_mensagens.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/rota_filtros.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

///Classe que modela a tela principal. Todas as Pages principais devem herdar desta classe
abstract class TelaDesktopBase<Store extends StoreBase> extends StatefulWidget {
  final Widget? Function()? conteudo;
  final String title;
  final List<RotaFiltros>? filtros;

  ///Apenas informe o titulo e o conteudo em telas que não tenha datatables
  const TelaDesktopBase(
      {Key? key, this.conteudo, this.title = "Titulo", this.filtros})
      : super(key: key);

  @override
  State<TelaDesktopBase> createState() => _TelaDesktopBaseState<Store>();
}

class _TelaDesktopBaseState<Store extends StoreBase>
    extends State<TelaDesktopBase> {
  final store = Modular.get<Store>();
  final appcontroler = Modular.get<IAppController>();

  Widget _mobile() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(),
                  Row(children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green.shade900.withOpacity(0.5),
                          image: const DecorationImage(
                            image: AssetImage(
                              "imagens/top-header.png",
                            ),
                            fit: BoxFit.fill,
                            opacity: 0.3,
                          ),
                        ),

                        /*
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [
                              0.1,
                              0.4,
                              0.6,
                              0.9,
                            ],
                            colors: [
                              Colors.teal,
                              Color.fromARGB(255, 1, 60, 3),
                              Color.fromARGB(255, 3, 61, 5),
                              Color.fromARGB(255, 2, 63, 4),
                            ],
                          ),
                        ),*/
                        height: 180,
                        child: ScrollConfiguration(
                          behavior: MyCustomScrollBehavior(),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              widget.title,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                  Expanded(child: Container()),
                ],
              ),
              Positioned(
                top: 100,
                child: Body<Store>(
                  conteudo: widget.conteudo != null ? widget.conteudo!() : null,
                  filtros: widget.filtros ?? [],
                ),
              )
            ],
          ),
        ) /*,
        Container(
          color: Colors.green[900],
          child: MenuMobile(
            menusexpandidos: menus,
          ),
        )
        */
      ],
    );
  }

  Widget _desktop() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            MenuEsquerdo(
              menusexpandidos: menus,
            ),
            Observer(
              builder: (context) => Container(
                decoration:
                    BoxDecoration(color: Colors.grey.shade200, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 3,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ]),
                // color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width -
                    (isTelaPequena(context)
                        ? 0
                        : (!appcontroler.esconder ? 200 : 70)),
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Header(),
                        Row(children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.green[900],
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "imagens/top-header.png",
                                    ),
                                    fit: BoxFit.fill,
                                    opacity: 0.3),
                              ),
                              //color: Colors.green[900],
                              //  decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //    begin: Alignment.topRight,
                              //   end: Alignment.bottomLeft,
                              //   stops: [
                              //   0.1,
                              //    0.4,
                              //    0.6,
                              //    0.9,
                              //  ],
                              //  colors: [
                              //  Colors.teal,
                              //    Color.fromARGB(255, 1, 60, 3),
                              //   Color.fromARGB(255, 3, 61, 5),
                              //    Color.fromARGB(255, 2, 63, 4),
                              // ],
                              // ),
                              //   ),
                              height: 180,
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                        Expanded(child: Container()),
                      ],
                    ),
                    Positioned(
                      top: 100,
                      child: Body<Store>(
                        conteudo:
                            widget.conteudo != null ? widget.conteudo!() : null,
                        filtros: widget.filtros ?? [],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: SafeArea(
        child: Stack(
          children: [
            isTelaPequena(context) ? _mobile() : _desktop(),
            PosicionedMensagem<Store>()
          ],
        ),
      ),
      bottomNavigationBar: isTelaPequena(context)
          ? Observer(
              builder: (context) => CurvedNavigationBar(
                  buttonBackgroundColor: Colors.green,
                  height: 60,
                  color: Colors.green.shade900,
                  index: appcontroler.index,
                  backgroundColor: Colors.white,
                  items: menus,
                  onTap: (value) {
                    menus[value].abriMenuMobile(context);
                  }),
            )
          : null,
    );
  }
}
