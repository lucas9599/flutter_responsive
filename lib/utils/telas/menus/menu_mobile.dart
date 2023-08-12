import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';
import 'package:flutter/material.dart';

///Classe que converte o menu lateral em menu mobile.
class MenuMobile extends StatefulWidget {
  final List<MenuExpandido> menusexpandidos;
  const MenuMobile({Key? key, required this.menusexpandidos}) : super(key: key);

  @override
  State<MenuMobile> createState() => _MenuMobileState();
}

class _MenuMobileState extends State<MenuMobile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        widget.menusexpandidos.length,
        (index) => widget.menusexpandidos[index],
      ),
    );
  }
}
