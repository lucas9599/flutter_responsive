import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/filtros/bases/filtro_tela_base.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

///InputLookup precisa de uma tela de pesquisa
class InputLookup extends StatefulWidget implements IInput {
  final FiltroTelaBase telaPesquisa;
  @override
  final String name;
  late final Input id;
  late final Input descricao;
  final String label;
  final bool obrigatorio;
  final bool visivel;
  final List<FiltroBase> filtros = [];
  final Map<String, dynamic>? valorinicial;
  final Function(String valor)? function;
  void setFiltro(List<FiltroBase> filtros) {
    this.filtros.clear();
    this.filtros.addAll(filtros);
  }

  InputLookup({
    Key? key,
    required this.name,
    required this.label,
    required this.telaPesquisa,
    this.function,
    this.visivel = true,
    this.valorinicial,
    this.obrigatorio = false,
  }) : super(key: key) {
    id = Input(
      name: "ID",
      label: "Codigo",
      width: 90,
      onChanged: (valor) async {
        if (valor.isNotEmpty) {
          if (function != null) {
            function!(valor);
          }
          final res = await telaPesquisa.controller
              .pesquisarid(valor: [int.parse(valor)]);
          if (res != null) {
            descricao.controller.text = res['descricao'];
          } else {
            descricao.controller.text = "";
          }
        } else {
          descricao.controller.text = "";
        }
      },
    );
    descricao = Input(
      name: "DESCRICAO",
      label: label,
      editable: false,
      obrigatorio: obrigatorio,
    );
  }

  @override
  State<InputLookup> createState() => _InputLookupState();

  @override
  Map<String, dynamic> getValue() {
    if (descricao.controller.text.isNotEmpty) {
      return {
        name: {"id": id.controller.text, "descricao": descricao.controller.text}
      };
    } else {
      return {};
    }
  }

  @override
  void setValue(Map<String, dynamic> values) {
    descricao.controller.text = values[name]?['descricao'] ?? "";
    id.controller.text = values[name]?['id']?.toString() ?? "";
    if (obrigatorio && id.value.isEmpty && valorinicial != null) {
      id.controller.text = valorinicial!['id'].toString();
      descricao.controller.text = valorinicial!['descricao'];
    }
  }

  @override
  String get value => id.value;

  @override
  clean() {
    descricao.clean();
    id.clean();
  }
}

class _InputLookupState extends State<InputLookup> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visivel,
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.id,
            Expanded(
              child: widget.descricao,
            ),
            IconButton(
                onPressed: () async {
                  dynamic resposta = await Modular.to.push(
                    PageRouteBuilder(
                        opaque: false,
                        barrierColor: Colors.black.withValues(alpha: 0.5),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          widget.telaPesquisa.controller
                              .inicializar(filtros: widget.filtros);
                          return widget.telaPesquisa;
                        }),
                  );
                  if (resposta != null) {
                    widget.descricao.controller.text = resposta['descricao'];
                    widget.id.controller.text = resposta['id'].toString();
                    if (widget.function != null) {
                      widget.function!(resposta['id'].toString());
                    }
                  }
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
        )
      ]),
    );
  }
}
