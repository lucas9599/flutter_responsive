import 'package:flutter_responsive/utils/observables/conexao.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PosicionedMensagem<ConexaoBase extends Conexao> extends StatefulWidget {
  const PosicionedMensagem({Key? key, this.left}) : super(key: key);
  final double? left;
  @override
  State<PosicionedMensagem> createState() =>
      _PosicionedMensagemState<ConexaoBase>();
}

class _PosicionedMensagemState<ConexaoBase extends Conexao>
    extends State<PosicionedMensagem> {
  final appcontroler = Modular.get<ConexaoBase>();
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Visibility(
        visible: appcontroler.mensegem != Mensagem.semmensagem,
        child: AnimatedPositioned(
          duration: const Duration(seconds: 1),
          left: widget.left ?? MediaQuery.of(context).size.width - 250,
          top: 100,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              color: appcontroler.mensegem == Mensagem.erro
                  ? Colors.red
                  : appcontroler.mensegem == Mensagem.aviso
                      ? Colors.yellow[900]
                      : Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(2, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                    appcontroler.mensegem == Mensagem.erro
                        ? Icons.error
                        : appcontroler.mensegem == Mensagem.aviso
                            ? Icons.warning
                            : Icons.check_circle,
                    size: 40,
                    color: Colors.white),
                Text(
                  appcontroler.textoMensagem,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: 200,
                    height: 10,
                    child: LinearProgressIndicator(
                      color: Colors.green[900],
                      backgroundColor: Colors.grey[100],
                      value: appcontroler.porcentagemmensagem,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
