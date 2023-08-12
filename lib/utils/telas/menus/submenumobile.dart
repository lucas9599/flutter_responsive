import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

///Converte um menu expandido em Submenu Mobile.
class SubMenuMobile extends StatefulWidget {
  const SubMenuMobile({
    Key? key,
    required this.menu,
    this.inicio = false,
  }) : super(key: key);
  final MenuExpandido menu;
  final bool inicio;

  @override
  State<SubMenuMobile> createState() => _SubMenuMobileState();
}

class _SubMenuMobileState extends State<SubMenuMobile> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.menu.isVisible,
        child: Column(
          children: [
            (widget.inicio
                ? Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.menu.iconMobile,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.menu.label,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    )
                  ])
                : Container()),
            !widget.inicio
                ? Observer(
                    builder: ((context) => ListTile(
                          minLeadingWidth: 10,
                          leading: Icon(
                            !widget.menu.controller.espandido
                                ? Icons.arrow_right
                                : Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          title: Text(widget.menu.label,
                              style: const TextStyle(color: Colors.white)),
                          onTap: () => widget.menu.controller.selecionar(),
                        )),
                  )
                : Container(),
            Observer(
              builder: (context) => Visibility(
                visible: widget.menu.controller.espandido || widget.inicio,
                child: Column(
                  children: widget.menu.submenu != null
                      ? List.generate(
                          widget.menu.submenu!.length,
                          (index) =>
                              SubMenuMobile(menu: widget.menu.submenu![index]))
                      : List.generate(
                          widget.menu.menus.length,
                          (index) => widget.menu.menus[index],
                        ),
                ),
              ),
            )
          ],
        ));
  }
}
