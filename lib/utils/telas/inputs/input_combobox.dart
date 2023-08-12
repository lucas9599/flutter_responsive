import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/repository/chaves.dart';
import 'package:flutter_responsive_template/utils/repository/repository_base.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_combobox_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

///Cria um inpu do Tipo Combobox
class InputComboBox extends StatefulWidget implements IInput {
  @override
  final String name;
  final InputComboboxController controller = InputComboboxController();
  final String label;
  final String tabela;
  final List<Map<String, dynamic>>? dados;
  final List response = [];
  final bool composto;
  final bool obrigatorio;
  final List<FiltroBase> filtro = [];
  final Function? function;

  ///__dados__: Pode ser passado dados locais (Sem ser de uma api)
  ///
  ///__function__: Pode se passar uma função que é chamada no evento onChanged
  ///
  ///__tablea__: Tabela do banco de dados. O nome da tabela deve ser o mesmo do endpoint.
  ///O  Combobox vai chamar a api para popular os dados;
  ///
  ///__composto__: Indica que o combobox tem duas chaves compostas por "id" e "descricao"

  InputComboBox({
    Key? key,
    required this.name,
    required this.label,
    this.obrigatorio = false,
    this.dados,
    this.function,
    required this.tabela,
    this.composto = true,
  }) : super(key: key);
  @override
  State<InputComboBox> createState() => _InputComboBoxState();

  @override
  Map<String, dynamic> getValue() {
    //  print(this.response);
    return {
      name: composto
          ? {
              "id": controller.valor ?? "",
              "descricao": (dados?.isNotEmpty ?? false)
                  ? (response.firstWhere((element) =>
                          element['id'] ==
                          int.parse(controller.valor ?? "-1"))?['descricao'] ??
                      "")
                  : ""
            }
          : controller.valor
    };
  }

  contemValor() {
    for (int i = 0; i < items.length; i++) {
      if (items[i]['value'].toString() == controller.valor) {
        return true;
      }
    }
    return false;
  }

  @override
  void setValue(Map<String, dynamic> values) {
    controller.valor = composto
        ? ((values[name]?['id'])?.toString())
        : ((values[name])?.toString());
  }

  @override
  String get value => controller.valor ?? "";

  /// Pode se atribuir um filtro no combobox
  setFiltro(List<FiltroBase> filtros) {
    filtro.clear();
    filtro.addAll(filtros);
    controller.valor = null;
    inicializar();
  }

  final ObservableList<Map<String, dynamic>> items =
      <Map<String, dynamic>>[].asObservable();

  inicializar() async {
    response.clear();
    List? d;
    if (dados != null) {
      d = dados;
    } else {
      Repository repository = Repository(
        tabela,
        //tabela: this.tabela,
        tipoApi: TipoApi.normal,
        isLista: true,
      );
      d = await repository.getAll(filtros: filtro);
    }
    items.clear();
    d?.forEach((element) {
      items.add(
        {
          'value': element['id'],
          'label': element['descricao'],
          'icon': const Icon(Icons.stop),
        },
      );
    });
    response.addAll(d ?? []);
  }
}

class _InputComboBoxState extends State<InputComboBox> {
  @override
  Widget build(BuildContext context) {
    widget.inicializar();
    return Observer(
        builder: (context) => widget.items.isNotEmpty
            ? DropdownButtonFormField(
                validator: (String? s) {
                  if (widget.obrigatorio && (s?.isEmpty ?? true)) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text(widget.label)),
                // or can be dialog
                //initialValue: 'circle',

                //
                //initialValue: _initialValue,
                //icon: Icon(Icons.format_shapes),
                value: widget.contemValor() ? widget.controller.valor : null,

                items: List.generate(
                    widget.items.length,
                    (index) => DropdownMenuItem<String>(
                        value: widget.items[index]['value'].toString(),
                        child: Text(widget.items[index]['label']))),

                onChanged: (String? val) {
                  widget.controller.valor = val;
                  if (widget.function != null) {
                    widget.function!(val);
                  }
                },
                // ignore: avoid_print
                onSaved: (val) => print(val),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: const Text("Carregando... "),
              ));
  }
}
