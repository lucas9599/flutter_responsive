import 'package:flutter_responsive/constantes.dart';
import 'package:flutter_responsive/utils/module_base/app_controller.dart';
import 'package:flutter_responsive/utils/telas/menus/menu_espandido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuEsquerdo extends StatefulWidget {
  final List<MenuExpandido> menusexpandidos;

  const MenuEsquerdo({Key? key, required this.menusexpandidos})
      : super(key: key);
  @override
  State<MenuEsquerdo> createState() => _MenuEsquerdoState();
}

class _MenuEsquerdoState extends State<MenuEsquerdo> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Visibility(
        visible: isTelaPequena(context) ? false : true,
        child: Container(
          width: !Modular.get<IAppController>().esconder ? 200 : 70,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,

            // gradient: LinearGradient(
            //  begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   stops: [
            //     0.1,
            //     0.4,
            //     0.6,
            //    0.9,
            // ],
            // colors: [
            //   Color.fromARGB(255, 1, 60, 3),
            //   Color.fromARGB(255, 3, 61, 5),
            //    Color.fromARGB(255, 2, 63, 4),
            //    Colors.teal,
            //   ],
            //  ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  // color: Color.fromARGB(255, 1, 53, 4),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.school,
                          color: Colors.blueGrey, size: 25),
                      Visibility(
                        visible: !Modular.get<IAppController>().esconder,
                        child: const Text(
                          "SIGA",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 180,
                  // ignore: sort_child_properties_last
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      CircleAvatar(
                          foregroundImage: usuarioLogado!.foto != null
                              ? MemoryImage(usuarioLogado!.foto!)
                              : null,
                          backgroundColor: Colors.green,
                          // ignore: sort_child_properties_last
                          child: Text(
                            _getIniciais(usuarioLogado!.usuario!),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          radius: 40),
                      Visibility(
                        visible: !Modular.get<IAppController>().esconder,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            Row(children: [
                              const Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(usuarioLogado!.email!, maxLines: 1),
                            ]),
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.white),
                                const SizedBox(width: 10),
                                Text(usuarioLogado!.usuario!),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Expanded(child: Container()),
                      Visibility(
                        visible: !Modular.get<IAppController>().esconder,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          width: MediaQuery.of(context).size.width,
                          // ignore: sort_child_properties_last
                          child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.online_prediction,
                                    color: Colors.greenAccent),
                                Text("online",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style:
                                        TextStyle(color: Colors.greenAccent)),
                              ]),
                          color: Colors.black.withOpacity(0.70),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          opacity: !Modular.get<IAppController>().esconder
                              ? 0.4
                              : 0.3,
                          image: const AssetImage("imagens/fundo.jpg"),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      widget.menusexpandidos.length,
                      (index) => widget.menusexpandidos[index],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(5),
                  color: Colors.black87,
                  child: Visibility(
                    visible: !Modular.get<IAppController>().esconder,
                    child: const Text(
                      "V. 2.0.1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getIniciais(String nome) {
    List<String> n = nome.split(" ");
    if (n.length > 2) {
      return "${n.first[0]}${n.last[0]}";
    } else {
      return n.first[0];
    }
  }
}
