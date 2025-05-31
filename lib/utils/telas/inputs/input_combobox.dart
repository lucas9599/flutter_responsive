import 'package:flutter_responsive_template/utils/filtros/bases/filtro_base.dart';
import 'package:flutter_responsive_template/utils/repository/chaves.dart';
import 'package:flutter_responsive_template/utils/repository/repository_base.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_combobox_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

///Input comboBox
class InputComboBox extends StatefulWidget implements IInput {
  @override
  final String name;
  final InputComboboxController controller = InputComboboxController();
  final String label;
  final String? endpoint;
  final List<Map<String, dynamic>>? dados;
  final List response = [];
  final bool composto;
  final bool obrigatorio;
  final List<FiltroBase> filtro = [];
  final Function? function;

  ///__composto__: Recebe o __setValue__ com id e descricao, senão somente o valor (o value do map não é outro map).
  ///Retorna o __getValue__ com id e descricao, senao somente retorna um valor (Não vai ser um map)
  ///
  ///__dados__ : Iniciar o combo box com dados locais. um list com map com keys "id" e "descricao"
  ///
  ///__endpoint__ : Indica o endpoint da api para busca de dados
  ///
  ///__function__ : Funcão que é executada apos uma selecção. A função recebe um valor (String) e executa
  ///
  ///__É obrigatório passar um endpoint ou um dado para preencher o combobox__
  InputComboBox({
    Key? key,
    required this.name,
    required this.label,
    this.obrigatorio = false,
    this.dados,
    this.function,
    this.endpoint,
    this.composto = true,
  })  : assert(dados != null && endpoint == null ||
            endpoint != null && dados == null),
        super(key: key);
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
                          element['id'].toString() ==
                          (controller.valor ?? "-1"))?['descricao'] ??
                      "")
                  : ""
            }
          : controller.valor
    };
  }

  bool contemValor() {
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

  void setFiltro(List<FiltroBase> filtros) {
    filtro.clear();
    filtro.addAll(filtros);
    controller.valor = null;
    inicializar();
  }

  final ObservableList<Map<String, dynamic>> items =
      <Map<String, dynamic>>[].asObservable();

  Future<void> inicializar() async {
    response.clear();
    List? d;
    if (dados != null) {
      d = dados;
    } else {
      Repository repository = Repository(
        endpoint!,
        //endpoint: this.endpoint,
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

  @override
  clean() {}
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
