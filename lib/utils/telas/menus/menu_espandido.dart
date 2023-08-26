import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu.dart';
import 'package:flutter_responsive_template/utils/telas/menus/submenumobile.dart';
import 'package:flutter_responsive_template/utils/telas/models/controller_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

///Constroe o menu lateral ou o menu mobile
///Esta classe identifica qual tipo de menu usar pela resolução
///Pode ser de varios niveis. Se informar um submenu a classe criar automaticamente um subnivel até ser informado um lista de menus.
class MenuExpandido extends StatefulWidget {
  final String label;
  final IconData iconMobile;
  final List<Menu> menus;
  final List<MenuExpandido>? submenu;

  ///esta veriavel verifica se é um botão principal(Rows) ou é um menu oculto (Colunm)
  final bool inRowMobile;

  ///identifica a posição do menu mobile
  final int? indexMenu;
  Color _adjustColorShade(Color color, int amount) {
    assert(amount >= -255 && amount <= 255);

    int red = color.red + amount;
    int green = color.green + amount;
    int blue = color.blue + amount;

    return Color.fromARGB(color.alpha, red.clamp(0, 255), green.clamp(0, 255),
        blue.clamp(0, 255));
  }

  bool get isVisible {
    if (submenu != null) {
      for (int i = 0; i < submenu!.length; i++) {
        if (submenu![i].isVisible) {
          return true;
        }
      }
    } else {
      for (int i = 0; i < menus.length; i++) {
        if (menus[i].isVisible) {
          return true;
        }
      }
    }
    return false;
  }

  MenuExpandido(
      {Key? key,
      required this.menus,
      required this.label,
      this.indexMenu,
      this.submenu,
      this.inRowMobile = true,
      this.iconMobile = Icons.menu})
      : super(key: key);
  final ControllerMenu controller = ControllerMenu();

  abriMenuMobile(context) {
    if (indexMenu != null) {
      Modular.get<IAppController>().indexMenuTemporario = indexMenu!;
    }
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          final cor = mobilePrimary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary;
          return Container(
            decoration: BoxDecoration(
              color: _adjustColorShade(cor, -100),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(10),
            height: 400,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SubMenuMobile(
                menu: this,
                inicio: true,
              ),
            ),
          );
        });
  }

  @override
  State<MenuExpandido> createState() => _MenuExpandidoState();
}

class _MenuExpandidoState extends State<MenuExpandido> {
  @override
  Widget build(BuildContext context) {
    return Container(child: isTelaPequena(context) ? _mobile() : _desktop());
  }

  _mobile() {
    final onSecundary = mobilePrimary
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;
    return Visibility(
        visible: widget.isVisible,
        child: TextButton(
            child: widget.inRowMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(widget.iconMobile, color: onSecundary),
                      Text(
                        widget.label,
                        style: TextStyle(color: onSecundary, fontSize: 7),
                      )
                    ],
                  )
                : Row(children: [
                    Icon(widget.iconMobile, color: onSecundary),
                    Text(
                      widget.label,
                      style: TextStyle(color: onSecundary),
                    )
                  ]),
            onPressed: () {
              widget.abriMenuMobile(context);
            }));
  }

  _desktop() {
    final normal = Theme.of(context).colorScheme.onSecondary;

    return Visibility(
      visible: widget.isVisible,
      child: Observer(
        builder: (context) => Container(
          padding: EdgeInsets.only(
              left: !Modular.get<IAppController>().esconder
                  ? 0
                  : isTelaPequena(context)
                      ? 20
                      : 5),
          child: Column(
            children: [
              Observer(
                builder: ((context) => ListTile(
                      minLeadingWidth: 10,
                      leading: Icon(
                        !Modular.get<IAppController>().esconder
                            ? (!widget.controller.espandido
                                ? Icons.arrow_right
                                : Icons.arrow_drop_down)
                            : widget.iconMobile,
                        color: normal,
                      ),
                      title: !Modular.get<IAppController>().esconder
                          ? Text(widget.label, style: TextStyle(color: normal))
                          : null,
                      onTap: () => widget.controller.selecionar(),
                    )),
              ),
              Observer(
                builder: (context) => Visibility(
                  visible: widget.controller.espandido,
                  child: Column(
                    children: widget.submenu != null
                        ? widget.submenu!
                        : List.generate(
                            widget.menus.length,
                            (index) => widget.menus[index],
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
