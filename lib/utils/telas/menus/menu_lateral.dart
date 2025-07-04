import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/color_utils.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

//Cria um menu na lateral esquerda da tela
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
    final secundary = Theme.of(context).colorScheme.secondary;
    final onSecundary = Theme.of(context).colorScheme.onSecondary;
    return Observer(
      builder: (context) => Visibility(
        visible: isTelaPequena(context) ? false : true,
        child: Container(
          width: !Modular.get<IAppController>().esconder ? 200 : 70,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: secundary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.7),
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
                      Visibility(
                        visible: !Modular.get<IAppController>().esconder,
                        child: Text(
                          nomesistema,
                          style: TextStyle(
                            color: onSecundary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 80,
                  // ignore: sort_child_properties_last
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  foregroundImage: usuarioLogado!.foto != null
                                      ? MemoryImage(usuarioLogado!.foto!)
                                      : null,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,

                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    _getIniciais(usuarioLogado!.usuario!),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  radius: 20),
                              Visibility(
                                visible:
                                    !Modular.get<IAppController>().esconder,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Icon(
                                            Icons.email,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                            size: 10,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            usuarioLogado!.email!,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                          ),
                                        ]),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              size: 10,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              usuarioLogado!.usuario!,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /* Visibility(
                        visible: !Modular.get<IAppController>().esconder,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          width: MediaQuery.of(context).size.width,
                          // ignore: sort_child_properties_last
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.online_prediction,
                                    size: 15,
                                    color: _adjustColorShade(secundary, 200)),
                                Text("online",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            _adjustColorShade(secundary, 200))),
                              ]),
                          color: Colors.black.withOpacity(0.70),
                        ),
                      )
                    */
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: ColorUtils.adjustColorShade(
                    Theme.of(context).colorScheme.secondary,
                    -25,
                  )
                      /*
                      image: DecorationImage(
                          opacity: !Modular.get<IAppController>().esconder
                              ? 0.4
                              : 0.3,
                          image: const AssetImage("imagens/fundo.jpg"),
                          fit: BoxFit.cover)*/
                      ),
                ),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      widget.menusexpandidos.length,
                      (index) => widget.menusexpandidos[index],
                    ),
                  ),
                ),
                /*
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
                */
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getIniciais(String nome) {
    List<String> n = nome.split(" ");
    if (n.length > 2) {
      return "${n.first[0]}${n.last[0]}";
    } else {
      return n.first[0];
    }
  }
}
