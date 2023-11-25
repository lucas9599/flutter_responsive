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

///Tela basica
abstract class TelaBase<Store extends StoreBase> extends StatefulWidget {
  final Widget? Function()? conteudo;
  final String title;
  final List<RotaFiltros>? filtros;
  const TelaBase({
    Key? key,
    this.conteudo,
    this.title = "Titulo",
    this.filtros,
  }) : super(key: key);

  @override
  State<TelaBase> createState() => _TelaBaseState<Store>();
}

class _TelaBaseState<Store extends StoreBase> extends State<TelaBase> {
  final store = Modular.get<Store>(key: "tabela");
  final appcontroler = Modular.get<IAppController>();
  Color _adjustColorShade(Color color, int amount) {
    assert(amount >= -255 && amount <= 255);

    int red = color.red + amount;
    int green = color.green + amount;
    int blue = color.blue + amount;

    return Color.fromARGB(color.alpha, red.clamp(0, 255), green.clamp(0, 255),
        blue.clamp(0, 255));
  }

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
                          color: _adjustColorShade(
                                  Theme.of(context).colorScheme.primary, -150)
                              .withOpacity(0.5),
                          image: DecorationImage(
                            image: AssetImage(
                              imagemheader,
                            ),
                            fit: BoxFit.fill,
                            opacity: 0.1,
                          ),
                        ),
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
                                color: _adjustColorShade(
                                    Theme.of(context).colorScheme.primary,
                                    -120),
                                image: DecorationImage(
                                    image: AssetImage(
                                      imagemheader,
                                    ),
                                    fit: BoxFit.fill,
                                    opacity: 0.1),
                              ),
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
      backgroundColor: _adjustColorShade(Theme.of(context).primaryColor, -200),
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
                  buttonBackgroundColor: Theme.of(context).colorScheme.primary,
                  height: 60,
                  color: _adjustColorShade(
                      Theme.of(context).colorScheme.primary, -100),
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
