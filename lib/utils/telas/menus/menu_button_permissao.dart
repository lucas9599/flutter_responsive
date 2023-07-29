import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter/material.dart';

class MenuButtonPermissao extends StatefulWidget {
  const MenuButtonPermissao({
    Key? key,
    required this.itens,
    this.icon = Icons.app_registration,
  }) : super(key: key);
  final List<MenuButtonPermissaoItem> itens;
  final IconData icon;
  bool get isVisible {
    for (int i = 0; i < itens.length; i++) {
      if (itens[i].isVisible) return true;
    }
    return false;
  }

  @override
  State<MenuButtonPermissao> createState() => _MenuButtonPermissaoState();
}

class _MenuButtonPermissaoState extends State<MenuButtonPermissao> {
  List<PopupMenuItem<MenuButtonPermissaoItem>> _getItens() {
    List<PopupMenuItem<MenuButtonPermissaoItem>> itens = [];
    for (int i = 0; i < widget.itens.length; i++) {
      if (widget.itens[i].isVisible) {
        itens.add(PopupMenuItem<MenuButtonPermissaoItem>(
            value: widget.itens[i],
            child: Row(
              children: [
                widget.itens[i].iconData != null
                    ? Icon(widget.itens[i].iconData!)
                    : Container(),
                Text(widget.itens[i].descricao)
              ],
            )));
      }
    }

    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: PopupMenuButton<MenuButtonPermissaoItem>(
        tooltip: "Mostrar Menus",
        onSelected: (value) {
          value.onSelected();
        },
        itemBuilder: (BuildContext context) {
          return _getItens();
        },
        icon: Icon(widget.icon, color: Colors.black),
        position: PopupMenuPosition.under,
        offset:
            isTelaGrande(context) ? const Offset(0, 0) : const Offset(50, 13),
      ),
    );
  }
}

class MenuButtonPermissaoItem {
  MenuButtonPermissaoItem(
      {required this.descricao,
      required this.onSelected,
      this.iconData,
      this.name});
  final String descricao;
  final Function onSelected;
  final IconData? iconData;
  final String? name;
  bool get isVisible => (name == null || rotaatual.isEmpty)
      ? true
      : usuarioLogado?.permissoes?[rotaatual.replaceAll("/", "")]?['permissoes']
              ?[name!]?['ativado'] ??
          false;
}
