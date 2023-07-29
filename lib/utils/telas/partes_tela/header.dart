import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_responsive/constantes.dart';
import 'package:flutter_responsive/utils/module_base/app_controller.dart';
import 'package:flutter_responsive/utils/telas/menus/windows_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade900,
            spreadRadius: 10,
            blurRadius: 7,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
        color: Colors.green.shade900.withOpacity(0.5),
        image: const DecorationImage(
          image: AssetImage(
            "imagens/top-header.png",
          ),
          fit: BoxFit.fill,
          opacity: 0.1,
        ),
      ),
      height: 50,
      child: Row(
        children: [
          Visibility(
            visible: isTelaPequena(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.school,
                color: Colors.white,
              ),
            ),
          ),
          Visibility(
            visible: !isTelaPequena(context),
            child: IconButton(
              onPressed: () {
                Modular.get<IAppController>().escondermenu();
              },
              icon: const Icon(Icons.menu),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Visibility(
              visible: MediaQuery.of(context).size.width > 500,
              child: const Text(
                " Sistema gerador de Avaliação",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Text(
            usuarioLogado?.email ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 0) {
                Modular.to.pushNamed("/usuario/");
                rotaatual = "";
              } else if (value == 1) {
                Modular.to.navigate("/");
                rotaatual = "";
              }
              if (value == 2) {
                Modular.to.pushNamed("/perfis/");
                rotaatual = "";
              }
            },
            itemBuilder: (BuildContext context) {
              return usuarioLogado!.admin!
                  ? [
                      const PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.supervised_user_circle),
                              Text('Usuarios')
                            ],
                          )),
                      const PopupMenuItem<int>(
                          value: 2,
                          child: Row(
                            children: [
                              Icon(Icons.perm_device_info),
                              Text('Perfis')
                            ],
                          )),
                      const PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [Icon(Icons.logout), Text('Sair')],
                          )),
                    ]
                  : [
                      const PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [Icon(Icons.logout), Text('Sair')],
                          ))
                    ];
            },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            position: PopupMenuPosition.under,
            offset: const Offset(50, 13),
          ),
          isDesktop
              ? WindowTitleBarBox(child: const WindowButtons())
              : Container()
        ],
      ),
    );
  }
}
