import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter/material.dart';

///Menu Mobile. É chamado internamente quando é indentificado uma resolução mobile.
class MenuButton extends StatefulWidget {
  const MenuButton({
    Key? key,
    required this.itens,
    this.icon = Icons.app_registration,
  }) : super(key: key);
  final List<MenuButtonItem> itens;
  final IconData icon;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.itens.isNotEmpty,
      child: PopupMenuButton<MenuButtonItem>(
        tooltip: "Mostrar Menus",
        onSelected: (value) {
          value.onSelected();
        },
        itemBuilder: (BuildContext context) {
          return List.generate(
            widget.itens.length,
            (index) => PopupMenuItem<MenuButtonItem>(
              value: widget.itens[index],
              child: Row(
                children: [
                  widget.itens[index].iconData != null
                      ? Icon(widget.itens[index].iconData!)
                      : Container(),
                  Text(widget.itens[index].descricao)
                ],
              ),
            ),
          );
        },
        icon: Icon(widget.icon, color: Colors.black),
        position: PopupMenuPosition.under,
        offset:
            isTelaGrande(context) ? const Offset(0, 0) : const Offset(50, 13),
      ),
    );
  }
}

///Classe auxiliar dos menus mobile
class MenuButtonItem {
  MenuButtonItem(
      {required this.descricao, required this.onSelected, this.iconData});
  final String descricao;
  final Function onSelected;
  final IconData? iconData;
}
