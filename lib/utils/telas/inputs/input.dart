import 'package:flutter_responsive_template/utils/rotas/mensagens.dart';
import 'package:flutter_responsive_template/utils/telas/extras/validador.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/latex_repository.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/view_latex.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum InputType {
  date,
  dateTime,
  text,
  numeric,
  currency,
  quantitative,
  phone,
}

class Input extends StatefulWidget implements IInput {
  @override
  final String name;
  final TextEditingController controller = TextEditingController();
  final String label;
  final bool isPrimaryKey;
  final int? maxLines;
  final bool latext;
  final bool obscureText;
  final bool visible;
  final bool obrigatorio;
  final String? valorinicial;
  final ViewLatex viewLatex = ViewLatex();
  final double? width;
  final bool? editable;
  final LatexRepository repository = LatexRepository();
  final InputBorder? border;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool? filled;
  final IconData? prefixIcon;
  final InputType inputType;
  final Function(String)? onChanged;
  bool validar() {
    if (inputType == InputType.date) {
      return Validador.validaData(value);
    } else if (obrigatorio && value.isEmpty) {
      return false;
    }
    return true;
  }

  Input(
      {Key? key,
      required this.name,
      this.editable,
      required this.label,
      this.visible = true,
      this.isPrimaryKey = false,
      this.obrigatorio = false,
      this.maxLines = 1,
      this.latext = false,
      this.valorinicial,
      this.onChanged,
      this.width,
      this.border,
      this.filled,
      this.style,
      this.labelStyle,
      this.prefixIcon,
      this.obscureText = false,
      this.fillColor,
      this.inputType = InputType.text})
      : super(key: key);

  @override
  State<Input> createState() => _InputState();

  @override
  Map<String, dynamic> getValue() {
    return {
      name: (latext && controller.text.isNotEmpty)
          ? controller.text
          : controller.text.isNotEmpty
              ? inputType == InputType.currency
                  ? double.parse(
                      controller.text.replaceAll(".", "").replaceAll(',', "."))
                  : inputType == InputType.date
                      ? "${controller.text.split('/').reversed.join("-")}T00:00:00.000-03:00"
                      : obscureText
                          ? controller.text
                          : (controller.text.toUpperCase())
              : ""
    };
  }

  @override
  void setValue(Map<String, dynamic> values) {
    String? valor = values[name]?.toString();
    if (valor != null && inputType == InputType.date) {
      valor = valor.split('-').reversed.join("/");
    }
    controller.text = ((valor) ?? valorinicial ?? "");
    if (inputType == InputType.currency) {
      String valorFormatado = NumberFormat.currency(locale: 'pt_BR', symbol: '')
          .format(values[name]);
      controller.text = valorFormatado;
    }
    if (controller.text.isEmpty && isPrimaryKey) {
      controller.text = "-1";
    } else if (latext && controller.text.isNotEmpty) {
      controller.text = controller.text;
    }
  }

  @override
  String get value => controller.text;
}

class _InputState extends State<Input> with Mensagens {
  bool bloqueado = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            width: widget.width ?? (widget.isPrimaryKey ? 70 : null),
            child: TextFormField(
              inputFormatters: widget.inputType == InputType.numeric
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : widget.inputType == InputType.date
                      ? [
                          // obrigatório
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ]
                      : widget.inputType == InputType.currency
                          ? [
                              // obrigatório
                              FilteringTextInputFormatter.digitsOnly,
                              CentavosInputFormatter(),
                            ]
                          : widget.inputType == InputType.phone
                              ? [
                                  // obrigatório
                                  FilteringTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter(),
                                ]
                              : null,
              style: widget.style,
              validator: (String? s) {
                if (widget.obrigatorio && s!.isEmpty) {
                  return "Campo obrigatório";
                } else if (widget.inputType == InputType.date && s != null) {
                  if (!Validador.validaData(s)) {
                    return "Data Invalida";
                  }
                }
                return null;
              },
              onChanged: widget.onChanged != null
                  ? (value) => widget.onChanged!(value)
                  : null,
              controller: widget.controller,
              maxLines: widget.maxLines,
              obscureText: widget.obscureText,
              enabled: widget.editable ?? (widget.isPrimaryKey ? false : true),
              decoration: InputDecoration(
                prefixIcon:
                    widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
                filled: widget.filled,
                labelStyle: widget.labelStyle,
                border: widget.border,
                fillColor: widget.fillColor,
                isDense: true,
                suffixIcon: (widget.inputType == InputType.date ||
                        widget.inputType == InputType.dateTime)
                    ? IconButton(
                        onPressed: () async {
                          await _selectDate(context);
                        },
                        icon: const Icon(Icons.calendar_month))
                    : widget.latext
                        ? IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () async {
                              if (!bloqueado) {
                                try {
                                  bloqueado = true;

                                  //  print(dados);
                                  visualizadorDePDF(
                                    () async => await widget.repository
                                        .getLatex(widget.controller.text),
                                  );
                                  bloqueado = false;
                                } catch (ex) {
                                  bloqueado = false;
                                }
                              }
                            })
                        : null,
                label: Text(
                  widget.label,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    DateTime date;
    if (Validador.validaData(widget.controller.text)) {
      date = DateFormat("dd/MM/yyyy").parse(widget.controller.text);
    } else {
      date = DateTime.now();
    }
    final picked = await showDatePicker(
        initialDate: date,
        context: context,
        firstDate: DateTime(
          date.year - 122,
        ),
        lastDate: DateTime(
          date.year + 50,
        ));
    if (picked != null) {
      widget.controller.text = DateFormat("dd/MM/yyyy").format(picked);
    }
  }
}
