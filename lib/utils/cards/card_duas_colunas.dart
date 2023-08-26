import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/cards/card_label_valor.dart';
import 'package:flutter_responsive_template/utils/cards/card_opcoes.dart';
import 'package:flutter/material.dart';

class CardDuasColunas extends StatefulWidget {
  const CardDuasColunas({
    Key? key,
    required this.codigo,
    required this.descricao,
    required this.id,
  }) : super(key: key);
  final LabelValor codigo;
  final LabelValor descricao;
  final int id;

  @override
  State<CardDuasColunas> createState() => _CardDuasColunasState();
}

class _CardDuasColunasState extends State<CardDuasColunas> {
  @override
  Widget build(BuildContext context) {
    return CardOpcoes(
      editar: (rotaatual.isEmpty)
          ? true
          : usuarioLogado?.permissoes?[rotaatual.replaceAll("/", "")]
                  ?['permissoes']?['editar']?['ativado'] ??
              false,
      excluir: (rotaatual.isEmpty)
          ? true
          : usuarioLogado?.permissoes?[rotaatual.replaceAll("/", "")]
                  ?['permissoes']?["excluir"]?['ativado'] ??
              false,
      id: widget.id,
      child: ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          padding: const EdgeInsets.all(5),
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.codigo.label,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              Text(
                widget.codigo.valor,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.descricao.label,
              style: TextStyle(fontSize: 10, color: Colors.green.shade800),
            ),
            Text(widget.descricao.valor,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.green.shade900)),
          ],
        ),
      ),
    );
  }
}
