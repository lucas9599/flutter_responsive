import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';

class Menu extends StatelessWidget {
  final String label;
  final IconData icon;
  final String rota;
  final bool mapeado;
  bool get isVisible => !mapeado
      ? true
      : usuarioLogado?.permissoes?[rota.replaceAll("/", "")]?['permissoes']
              ?['visualizar']?['ativado'] ??
          false;

  const Menu(
      {Key? key,
      required this.label,
      required this.icon,
      required this.rota,
      this.mapeado = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool telapequena = isTelaPequena(context);
    return Observer(
      builder: (context) => Visibility(
        visible: isVisible,
        child: Container(
          decoration: BoxDecoration(
              color: rotaatual == rota ? Colors.green.shade800 : null,
              border: const Border(left: BorderSide(color: Colors.grey))),
          margin: EdgeInsets.only(
              left: !Modular.get<IAppController>().esconder
                  ? 20
                  : telapequena
                      ? 20
                      : 5),
          child: Observer(
            builder: (context) => ListTile(
              onTap: () {
                final app = Modular.get<IAppController>();
                app.crescente = false;
                app.indexsort = 1;
                if (MediaQuery.of(context).size.width < 700) {
                  app.escondermenu();
                }
                app.index = app.indexMenuTemporario;
                rotaatual = rota;
                Modular.to.navigate("$rota/");
              },
              isThreeLine: false,
              dense: true,
              minLeadingWidth: 5,
              title: telapequena || !Modular.get<IAppController>().esconder
                  ? Text(label,
                      style: TextStyle(
                          color: (rotaatual == rota || telapequena)
                              ? Colors.white
                              : Colors.green.shade900,
                          fontSize: 12))
                  : null,
              leading: Icon(
                icon,
                color: rotaatual == rota ? Colors.white : Colors.green.shade900,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
