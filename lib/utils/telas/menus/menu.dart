import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';

///Menu componente do MenuExpandido. Verifica se a rota se tem permissão de visualizar.
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

  ///__mapeado__ indica que a rota utiliza as permissões do modulo. Se for informado false o package não verifica as permissões.
  ///Exemplo: A rota home não precisa de mapeamento. É uma tela de acesso comum
  const Menu(
      {Key? key,
      required this.label,
      required this.icon,
      required this.rota,
      this.mapeado = true})
      : super(key: key);

  Color _adjustColorShade(Color color, int amount) {
    assert(amount >= -255 && amount <= 255);

    int red = color.red + amount;
    int green = color.green + amount;
    int blue = color.blue + amount;

    return Color.fromARGB(color.alpha, red.clamp(0, 255), green.clamp(0, 255),
        blue.clamp(0, 255));
  }

  @override
  Widget build(BuildContext context) {
    bool telapequena = isTelaPequena(context);
    final primary = telapequena ? mobilePrimary : false;
    final corForte = _adjustColorShade(
        primary
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        -100);
    final cornormal = primary
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

    return Observer(
      builder: (context) => Visibility(
        visible: isVisible,
        child: Container(
          decoration: BoxDecoration(
              color: (rotaatual.isEmpty ? rota == "/home" : rotaatual == rota)
                  ? corForte
                  : null,
              border: const Border(left: BorderSide(color: Colors.grey))),
          padding: EdgeInsets.only(
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
                      style: TextStyle(color: cornormal, fontSize: 12))
                  : null,
              leading: Icon(
                icon,
                color: cornormal,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
