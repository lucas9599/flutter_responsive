import 'package:flutter_responsive_template/utils/rotas/mensagens.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardOpcoes extends StatefulWidget with Mensagens {
  const CardOpcoes(
      {Key? key,
      required this.child,
      required this.id,
      this.editar = true,
      this.excluir = true})
      : super(key: key);
  final Widget child;
  final int id;
  final bool editar;
  final bool excluir;
  @override
  State<CardOpcoes> createState() => _CardOpcoesState();
}

class _CardOpcoesState extends State<CardOpcoes> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.editar
          ? () => Modular.get<StoreBase>(key: "tabela").editar(id: widget.id)
          : null,
      child: Dismissible(
        background: Container(color: Colors.red),
        key: Key(widget.id.toString()),
        onDismissed: widget.excluir
            ? (direction) => Modular.get<StoreBase>(key: "tabela")
                .delete(id: widget.id, confirmacao: false)
            : null,
        confirmDismiss: widget.excluir
            ? (direction) async {
                return await widget.openDialogoConfirmacao(
                    mensagem: "Confirmar Exclusão do registro?");
              }
            : (_) async {
                return false;
              },
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
