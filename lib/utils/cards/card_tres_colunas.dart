import 'package:flutter_responsive/constantes.dart';
import 'package:flutter_responsive/utils/cards/card_label_valor.dart';
import 'package:flutter_responsive/utils/cards/card_opcoes.dart';
import 'package:flutter/material.dart';

class CardTresColunas extends StatefulWidget {
  const CardTresColunas({
    Key? key,
    required this.codigo,
    required this.descricao,
    required this.acaoes,
    required this.id,
  }) : super(key: key);
  final LabelValor codigo;
  final LabelValor descricao;
  final int id;
  final Widget acaoes;

  @override
  State<CardTresColunas> createState() => _CardTresColunasState();
}

class _CardTresColunasState extends State<CardTresColunas> {
  @override
  Widget build(BuildContext context) {
    return CardOpcoes(
      id: widget.id,
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
      child: ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.green.shade700,
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
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            Text(widget.descricao.valor),
          ],
        ),
        trailing: widget.acaoes,
      ),
    );
  }
}
